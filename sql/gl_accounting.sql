SET search_path TO gl;

-- types

CREATE TYPE accounttypes AS ENUM ('revenue', 'cost', 'asset', 'liability');
CREATE TYPE accountsoatypes AS ENUM ('pos', 'bank', 'owner');
CREATE TYPE batchstates AS ENUM ('active', 'accounted');
CREATE TYPE systemtype AS ENUM ('gl', 'contact', 'product');

-- functions

CREATE OR REPLACE FUNCTION get_dimensions(acctnr text, orgid integer) RETURNS integer[] AS $$
DECLARE
	dimrec      record;
	part        text;
	name        text;
	dimtable    text;
	dimcolumn   text;
	id          integer;
	id_a        integer[];
	loop_count  integer := 1;
	rowcount    integer;
BEGIN
	FOR dimrec IN 
		SELECT * FROM gl.dimensions WHERE org_id = orgid ORDER BY dimension

	LOOP
	part      := split_part(acctnr, '.', loop_count);
	dimtable  := dimrec.dimtable;
	dimcolumn := dimrec.dimcolumn;

	IF length(part) > 0 THEN
		EXECUTE 'SELECT id FROM '||dimtable|| ' WHERE org_id = '||orgid||' AND '||quote_ident(dimcolumn)||'='|| quote_literal(part)
		INTO id;

		GET DIAGNOSTICS rowcount := ROW_COUNT;
		IF rowcount = 0 THEN
			RAISE EXCEPTION 'Nonexistent % ID --> % (%)', dimtable, dimcolumn, part;
		--          id := 0;
		END IF;
	ELSE
		id := 0;
	END IF;

	id_a[loop_count] := id;
	loop_count       := loop_count + 1;
	END LOOP;

	RETURN id_a;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_acctnr(integer[], orgid integer) RETURNS text AS $$
DECLARE
	ids         ALIAS FOR $1;
	dimrec      record;
	part        text;
	name        text;
	dimtable    text;
	dimcolumn   text;
	acctnr      text := '';
	id          integer;
	loop_count  integer := 1;
	rowcount    integer;
BEGIN
	FOR dimrec IN
		SELECT * FROM gl.dimensions WHERE org_id = orgid ORDER BY dimension

	LOOP
		dimtable  := dimrec.dimtable;
		dimcolumn := dimrec.dimcolumn;
		id        := ids[loop_count];

		IF id > 0 THEN
			EXECUTE 'SELECT '||quote_ident(dimcolumn)||' FROM '||dimtable||' WHERE org_id ='||orgid||' AND id = '||id
			INTO part;

			GET DIAGNOSTICS rowcount := ROW_COUNT;
			IF rowcount = 0 THEN
				RAISE EXCEPTION 'Nonexistent % ID --> % (%)', dimtable, dimcolumn, part;
	--			id := 0;
			END IF;
		ELSE
			part := '';
		END IF;

		IF loop_count > 1 THEN
			acctnr     := acctnr || '.';
		END IF;
		acctnr     := acctnr || part;
		loop_count := loop_count + 1;
	END LOOP;

	RETURN acctnr;
END;
$$ LANGUAGE plpgsql;

-- tables

CREATE TABLE chartofaccounts (
	id						serial PRIMARY KEY,
	org_id					integer NOT NULL REFERENCES contact.organisations
							ON DELETE CASCADE
							ON UPDATE CASCADE,
	name					text,
	type					accounttypes,
	currency_id				integer NOT NULL REFERENCES currencies (id),
	account_nr				text,
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp
);

CREATE TABLE accountsoas (
	id						serial PRIMARY KEY,
	coa_id					integer NOT NULL REFERENCES chartofaccounts (id),
	type					accountsoatypes,
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp
);

CREATE TABLE accountvat (
	id						serial PRIMARY KEY,
	coa_id					integer REFERENCES chartofaccounts (id),
	vat_id					integer REFERENCES product.vats (id),
	vat_coa					integer REFERENCES chartofaccounts (id),
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp
);

CREATE TABLE acctgrid (
	id						serial PRIMARY KEY,
	org_id					integer NOT NULL REFERENCES contact.organisations
							ON DELETE CASCADE
							ON UPDATE CASCADE,
	dim						integer[],
	currency_id				integer NOT NULL REFERENCES currencies (id),
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp
);

CREATE TABLE balances (
	ag_id					integer NOT NULL REFERENCES acctgrid (id),
	periodnr				date NOT NULL,
	begindr					numeric DEFAULT 0,
	begincr					numeric DEFAULT 0,
	perioddr				numeric DEFAULT 0,
	periodcr				numeric DEFAULT 0,
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp,
	PRIMARY KEY (ag_id, periodnr)
);

CREATE TABLE countries (
	id						serial PRIMARY KEY,
	country_id				integer REFERENCES contact.countries (id),
	sales_vat				integer REFERENCES chartofaccounts (id),
	sales					integer REFERENCES chartofaccounts (id),
	debitor					integer REFERENCES chartofaccounts (id),
	vat_id					integer REFERENCES product.vats (id),
	currency_id				integer,
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp
);

CREATE TABLE dimensions (
	id						serial PRIMARY KEY,
	org_id					integer NOT NULL REFERENCES contact.organisations
							ON DELETE CASCADE
							ON UPDATE CASCADE,
	dimension				integer,
	dimtable				text,
	dimcolumn				text,
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp
);

CREATE TABLE batches (
	id						serial PRIMARY KEY,
	org_id					integer NOT NULL REFERENCES contact.organisations
							ON DELETE CASCADE
							ON UPDATE CASCADE,
	currency_id				integer REFERENCES currencies (id),
	system					systemtype,
	batchnr					integer,
	name					text,
	status					batchstates,
	totaldr					numeric DEFAULT 0,
	totalcr					numeric DEFAULT 0,
	postingdate				date DEFAULT now(),
	soa_id					integer REFERENCES accountsoas (id),
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp
);

CREATE TABLE batchjournals (
	id						serial PRIMARY KEY,
	batch_id				integer NOT NULL REFERENCES batches (id)
							ON DELETE CASCADE
							ON UPDATE CASCADE,
	journalnr				integer NOT NULL,
	ag_id					integer REFERENCES acctgrid (id),
	dr_amount				numeric,
	cr_amount				numeric,
	description				text,
	accountingdate			date,
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp
);

CREATE TABLE journals (
	id						serial PRIMARY KEY,
	batch_id				integer NOT NULL REFERENCES batches (id)
							ON DELETE CASCADE
							ON UPDATE CASCADE,
	journalnr				integer NOT NULL,
	ag_id					integer REFERENCES acctgrid (id),
	dr_amount				numeric,
	cr_amount				numeric,
	description				text,
	accountingdate			date,
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp
);

-- Triggers
CREATE TRIGGER set_modified BEFORE UPDATE ON chartofaccounts FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
CREATE TRIGGER set_modified BEFORE UPDATE ON accountsoas FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
CREATE TRIGGER set_modified BEFORE UPDATE ON accountvat FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
CREATE TRIGGER set_modified BEFORE UPDATE ON acctgrid FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
CREATE TRIGGER set_modified BEFORE UPDATE ON balances FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
CREATE TRIGGER set_modified BEFORE UPDATE ON countries FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
CREATE TRIGGER set_modified BEFORE UPDATE ON dimensions FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
CREATE TRIGGER set_modified BEFORE UPDATE ON batches FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
CREATE TRIGGER set_modified BEFORE UPDATE ON batchjournals FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
CREATE TRIGGER set_modified BEFORE UPDATE ON journals FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
