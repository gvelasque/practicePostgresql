SELECT * FROM fav;

UPDATE fav SET howmuch = howmuch + 1 
    WHERE post_id = 1 AND account_id = 1 
RETURNING *;

CREATE OR REPLACE FUNCTION trigger_set_timestamp()   
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;   
END;
$$ language 'plpgsql';

CREATE TRIGGER set_timestamp 
BEFORE UPDATE ON post 
FOR EACH ROW 
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TRIGGER set_timestamp 
BEFORE UPDATE ON fav 
FOR EACH ROW 
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TRIGGER set_timestamp 
BEFORE UPDATE ON comment 
FOR EACH ROW 
EXECUTE PROCEDURE trigger_set_timestamp();

