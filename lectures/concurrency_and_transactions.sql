INSERT INTO fav (post_id, account_id, howmuch) VALUES (1, 1, 1) RETURNING *;

UPDATE fav SET howmuch = howmuch + 1 WHERE post_id = 1 AND account_id = 1 RETURNING *;

INSERT INTO fav (post_id, account_id, howmuch) VALUES (1, 1, 1)
ON CONFLICT (post_id, account_id)
DO UPDATE SET howmuch = fav.howmuch + 1 RETURNING *;

-- Multi-Statements Transactions

-- with ROLLBACK
BEGIN;
SELECT howmuch FROM fav WHERE account_id=1 AND post_id=1 FOR UPDATE OF fav;
UPDATE fav SET howmuch=999 WHERE account_id=1 AND post_id=1;
SELECT howmuch FROM fav WHERE account_id=1 AND post_id=1;
ROLLBACK;

SELECT howmuch FROM fav WHERE account_id=1 AND post_id=1;

-- with COMMIT
BEGIN;
SELECT howmuch FROM fav WHERE account_id=1 AND post_id=1 FOR UPDATE OF fav;
-- Time passes...
UPDATE fav SET howmuch=999 WHERE account_id=1 AND post_id=1;
COMMIT;

SELECT howmuch FROM fav WHERE account_id=1 AND post_id=1;
