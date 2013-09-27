CREATE SCHEMA product;
SET search_path TO product;

CREATE TABLE vats (
	id						serial PRIMARY KEY,
	label					text,
	rate					numeric(5,2),
	start_time				timestamp with time zone,
	end_time				timestamp with time zone,
	country_id				int REFERENCES contact.countries (id),
	sv_coa					integer,
	pv_coa					integer,
	created					timestamp with time zone NOT NULL DEFAULT now(),
	modified				timestamp with time zone
);

-- Triggers
CREATE TRIGGER set_modified BEFORE UPDATE ON vats FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
