CREATE SCHEMA product;
SET search_path TO product;

CREATE TABLE vats (
	id						serial PRIMARY KEY,
	label					text,
	rate					numeric(5,2),
	start_time				timestamp,
	end_time				timestamp,
	country_id				int REFERENCES contact.countries (id),
	sv_coa					integer,
	pv_coa					integer,
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp NOT NULL
);

-- Triggers
CREATE TRIGGER set_modified BEFORE UPDATE ON vats FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
