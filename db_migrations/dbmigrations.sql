create table peeps (
  id SERIAL PRIMARY KEY,
  content varchar(250) NOT NULL
);

Alter table peeps add column datetime timestamp DEFAULT date_trunc('minute', now())::timestamp(0);

create table users (
  id SERIAL PRIMARY KEY,
  username varchar(60) NOT NULL,
  email varchar(80) NOT NULL,
  password varchar(120) NOT NULL
);

ALTER TABLE peeps ADD COLUMN users integer NOT NULL REFERENCES users(id);
