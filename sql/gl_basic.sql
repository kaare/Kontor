CREATE SCHEMA gl;
SET search_path TO gl;

-- functions

CREATE OR REPLACE FUNCTION newrate() RETURNS TRIGGER AS $$
DECLARE
	curtime        timestamp with time zone;
	rate_id        bigint;
	article_id     integer;
	conntablename  text;
BEGIN
	curtime := 'now';
	IF new.start_date > new.end_date THEN
		new.end_date = 'infinity';
	END IF;
	new.end_date = old.end_date;
	old.end_date = new.start_date;
	INSERT INTO gl.rates (label, ratetype_id, ratestate_id, rate, currency_id, start_date, end_date)
	VALUES (new.label, new.ratetype_id, new.ratestate_id, new.rate, new.currency_id, new.start_date, new.end_date)
	RETURNING id INTO rate_id;

	RETURN old;
END;
$$ language 'plpgsql';

-- tables

CREATE TABLE currencies (
	id						serial PRIMARY KEY,
	alpha3					char(3),
	country_id				integer NOT NULL REFERENCES contact.countries (id),
	name					text,
	decimals				integer,
	decimal_point			char(1),
	thousand_sep			char(1),
	created					timestamp with time zone DEFAULT now(),
	modified				timestamp with time zone
);

CREATE TABLE rates (
	id						serial PRIMARY KEY,
	label					text DEFAULT '',
	ratestate				public.activestate,
	rate					numeric(10,2) DEFAULT '1.00',
	currency_id				int NOT NULL REFERENCES currencies (id),
	start_time				timestamp with time zone DEFAULT '-infinity',
	end_time				timestamp with time zone DEFAULT 'infinity',
	created					timestamp with time zone DEFAULT now(),
	modified				timestamp with time zone
);

-- Triggers
CREATE TRIGGER set_modified BEFORE UPDATE ON currencies FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
CREATE TRIGGER set_modified BEFORE UPDATE ON rates FOR EACH ROW EXECUTE PROCEDURE public.set_modified();

CREATE TRIGGER newrate BEFORE UPDATE ON rates FOR EACH ROW EXECUTE PROCEDURE newrate();
