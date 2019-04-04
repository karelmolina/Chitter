ALTER TABLE peeps ADD COLUMN users integer NOT NULL REFERENCES users(id);
