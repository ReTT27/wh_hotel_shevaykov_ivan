CREATE TABLE IF NOT EXISTS hotel.setitems
(
    set_id     SERIAL   NOT NULL,
    cart_id    SMALLINT NOT NULL,
    item_id    SMALLINT NOT NULL,
    item_count SMALLINT NOT NULL
);