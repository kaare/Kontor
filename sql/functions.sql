-- Generic functions
CREATE FUNCTION set_modified () RETURNS "trigger" AS $$
BEGIN
	NEW.created = OLD.created;
	NEW.modified = now();
	RETURN NEW;
	END;
$$ LANGUAGE 'plpgsql';
