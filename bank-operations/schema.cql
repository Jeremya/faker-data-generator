CREATE KEYSPACE bench WITH replication = {'class': 'NetworkTopologyStrategy', 'Search':3};

CREATE TABLE bench.bank_operations_by_iban (
    iban text,
    operation_id uuid,
    account_code text,
    label text,
    date_operation timestamp,
    date_validation timestamp,
    date_correction timestamp,
    amount float,
    original_operation_id uuid,
    PRIMARY KEY ((iban), operation_id)
);

CREATE SEARCH INDEX on bench.bank_operations_by_iban
