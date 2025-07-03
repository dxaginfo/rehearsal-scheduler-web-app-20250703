-- Migration: Create tables for rehearsal scheduler
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255) UNIQUE NOT NULL,
  auth_provider VARCHAR(64),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE bands (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER REFERENCES users(id)
);

CREATE TABLE band_members (
  id SERIAL PRIMARY KEY,
  band_id INTEGER REFERENCES bands(id),
  user_id INTEGER REFERENCES users(id),
  join_date DATE,
  role VARCHAR(128)
);

CREATE TABLE rehearsals (
  id SERIAL PRIMARY KEY,
  band_id INTEGER REFERENCES bands(id),
  datetime TIMESTAMP,
  location VARCHAR(255),
  created_by INTEGER REFERENCES users(id),
  status VARCHAR(32)
);

CREATE TABLE attendance (
  id SERIAL PRIMARY KEY,
  rehearsal_id INTEGER REFERENCES rehearsals(id),
  member_id INTEGER REFERENCES band_members(id),
  status VARCHAR(32),
  checked_in_time TIMESTAMP
);

CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  message TEXT,
  sent_at TIMESTAMP
);

CREATE TABLE setlists (
  id SERIAL PRIMARY KEY,
  band_id INTEGER REFERENCES bands(id),
  rehearsal_id INTEGER REFERENCES rehearsals(id),
  content TEXT,
  updated_at TIMESTAMP
);