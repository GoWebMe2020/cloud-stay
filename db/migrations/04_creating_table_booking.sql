CREATE TABLE booking(id SERIAL PRIMARY KEY, start_date DATE, end_date DATE, cloud_id INTEGER REFERENCES clouds (id));