-- CREATE model racing

CREATE TABLE racing (
    make VARCHAR,
    model VARCHAR,
    year INTEGER,
    price INTEGER
)

-- INSERT to racing model

INSERT INTO racing (make, model, year, price)
VALUES ('Nissan', 'Stanza', '1990', '2000'),
('Dodge', 'Neon', '1995', '800'),
('Dodge', 'Neon', '1998', '2500'),
('Dodge', 'Neon', '1999', '3000'),
('Ford', 'Mustang', '2001', '1000'),
('Ford', 'Mustang', '2005', '2000'),
('Subaru', 'Impreza', '1997', '1000'),
('Mazda', 'Miata', '2001', '5000'),
('Mazda', 'Miata', '2001', '3000'),
('Mazda', 'Miata', '2001', '2500'),
('Mazda', 'Miata', '2002', '5500'),
('Opel', 'GT', '1972', '1500'),
('Opel', 'GT', '1969', '7500'),
('Opel', 'Cadet', '1973', '500');