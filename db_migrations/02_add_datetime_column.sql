Alter table peeps add column datetime timestamp DEFAULT date_trunc('minute', now())::timestamp(0);
