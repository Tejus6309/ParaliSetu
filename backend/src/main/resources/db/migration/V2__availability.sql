ALTER TABLE listings
  ADD version BIGINT NOT NULL DEFAULT 0,
  ADD harvest_date DATE NOT NULL DEFAULT '2000-01-01',
  ADD available_from DATE NOT NULL DEFAULT '2000-01-01',
  ADD available_until DATE NOT NULL DEFAULT '9999-12-31',
  ADD CONSTRAINT valid_listing_window CHECK (harvest_date <= available_from AND available_from <= available_until);
