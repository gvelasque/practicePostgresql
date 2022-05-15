-- CREATE model account

CREATE TABLE account (
    id serial,
    email varchar(128) UNIQUE,
    created_at date NOT NULL DEFAULT now(),
    updated_at date NOT NULL DEFAULT now(),
    PRIMARY KEY(id)
);

-- CREATE model post

CREATE TABLE post (
    id serial,
    title varchar(128) UNIQUE NOT NULL,
    content varchar(1024), --will extend WITH ALTER
    account_id integer REFERENCES account(id) ON DELETE CASCADE,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY(id)
);

-- CREATE model comment

-- Allow multiple comments
CREATE TABLE comment (
    id serial,
    content TEXT NOT NULL,
    account_id integer REFERENCES account(id) ON DELETE CASCADE,
    post_id integer REFERENCES post(id) ON DELETE CASCADE,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY(id)
);

-- CREATE model comment

CREATE TABLE fav (
    id serial,
    oops TEXT, -- will remove later WITH ALTER
    post_id integer REFERENCES post(id) ON DELETE CASCADE,
    account_id integer REFERENCES account(id) ON DELETE CASCADE,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    UNIQUE(post_id, account_id),
    PRIMARY KEY(id)
);


INSERT INTO account(email) VALUES 
('ed@umich.edu'), ('sue@umich.edu'), ('sally@umich.edu');

INSERT INTO post (title, content, account_id) VALUES
( 'Dictionaries', 'Are fun', 3),  -- sally@umich.edu
( 'BeautifulSoup', 'Has a complex API', 1), -- ed@mich.edu
( 'Many to Many', 'Is elegant', (SELECT id FROM account WHERE email='sue@umich.edu' ));

INSERT INTO comment (content, post_id, account_id) VALUES
( 'I agree', 1, 1), -- dict / ed
( 'Especially for counting', 1, 2), -- dict / sue
( 'And I don''t understand why', 2, 2), -- dict / sue
( 'Someone should make "EasySoup" or something like that', 
    (SELECT id FROM post WHERE title='BeautifulSoup'),
    (SELECT id FROM account WHERE email='ed@umich.edu' )),
( 'Good idea - I might just do that', 
    (SELECT id FROM post WHERE title='BeautifulSoup'),
    (SELECT id FROM account WHERE email='sally@umich.edu' ))
;





