SET search_path TO contact;

-- tables

CREATE TABLE organisations (
	id						serial PRIMARY KEY,
	currency_id				integer NOT NULL REFERENCES gl.currencies,
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp
);

-- Triggers
CREATE TRIGGER set_modified BEFORE UPDATE ON organisations FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
