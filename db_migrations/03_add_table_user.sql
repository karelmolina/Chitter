create table users (
  id SERIAL PRIMARY KEY,
  username varchar(60) NOT NULL,
  email varchar(80) NOT NULL,
  password varchar(120) NOT NULL
);
