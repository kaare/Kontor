CREATE SCHEMA contact;
SET search_path TO contact;

-- tables

CREATE TABLE countries (
	id						serial PRIMARY KEY,
	alpha2					varchar(2) UNIQUE,
	alpha3					varchar(3) UNIQUE,
	name					varchar(255),
	created					timestamp NOT NULL DEFAULT now(),
	modified				timestamp
);

-- Triggers
CREATE TRIGGER set_modified BEFORE UPDATE ON countries FOR EACH ROW EXECUTE PROCEDURE public.set_modified();
