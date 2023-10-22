CREATE TABLE IF NOT EXISTS history.cleaningchanges
(
    log_id        BIGSERIAL   NOT NULL,
    cleaning_id   INT         NOT NULL,
    employee_id   INT         NOT NULL,
    room_id       SMALLINT    NOT NULL,
    date_cleaning DATE        NOT NULL,
    ch_employee   INT         NOT NULL,
    dt_ch         TIMESTAMPTZ NOT NULL
) PARTITION BY RANGE (date_cleaning);

CREATE TABLE IF NOT EXISTS history.cleaningchanges_jan23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-01-01') TO ('2023-02-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_feb23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-02-01') TO ('2023-03-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_march23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-03-01') TO ('2023-04-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_april23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-04-01') TO ('2023-05-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_may23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-05-01') TO ('2023-06-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_june23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-06-01') TO ('2023-07-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_july23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-07-01') TO ('2023-08-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_aug23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-08-01') TO ('2023-09-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_sept23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-09-01') TO ('2023-10-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_oct23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-10-01') TO ('2023-11-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_nov23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-11-01') TO ('2023-12-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_dec23 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2023-12-01') TO ('2024-01-01');

CREATE TABLE IF NOT EXISTS history.cleaningchanges_jan24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_feb24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_march24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_april24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-04-01') TO ('2024-05-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_may24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-05-01') TO ('2024-06-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_june24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-06-01') TO ('2024-07-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_july24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-07-01') TO ('2024-08-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_aug24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-08-01') TO ('2024-09-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_sept24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-09-01') TO ('2024-10-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_oct24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-10-01') TO ('2024-11-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_nov24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-11-01') TO ('2024-12-01');
CREATE TABLE IF NOT EXISTS history.cleaningchanges_dec24 PARTITION OF history.cleaningchanges FOR VALUES FROM ('2024-12-01') TO ('2025-01-01');