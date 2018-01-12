-- On WHOVIAN, I do this:
-- psql -U databasemaker -h whovian
-- create database testHint;
-- grant all privileges on database testHint to trenatest;
-- set Role trenatest;

-- On bdds-rds.globusgenomics.org, I do this (and change the user from trenatest to ben in the create table statements):

-- psql bdds --host=bdds-rds.globusgenomics.org --port=5432 --username=ben
-- create database testhint;
-- grant all privileges on database testHint to ben;
-- grant all privileges on database testHint to sjung;

\connect testhint;

drop table regions;
drop table hits;

create table regions(loc varchar primary key,
                     chrom varchar,
                     start int,
                     endpos int);

grant all on table "regions" to trenatest;

create table hits(loc varchar,
                  type varchar,
                  name varchar,
                  length int,
                  strand char(1),
                  sample_id varchar,
                  method varchar,
                  provenance varchar,
                  score1 real,
                  score2 real,
                  score3 real,
                  score4 real,
                  score5 real,
                  score6 real);

grant all on table "hits" to trenatest;