-- Disable commits and foreign key checks to minimize import errors.  These are set back at the end of DDL import.
set foreign_key_checks=0;
set autocommit=0;

-- Drop existing tables to re-create tables
drop table if exists num;

/*-------------------------------------------
*               CREATE tables
*/-------------------------------------------
-- Create Numbers table
create table num (
    numId int(11) AUTO_INCREMENT,
    adsh varchar(50),
    tag varchar(500),
    version varchar(50),
    ddate date,
    qtrs int(11),
    uom varchar(50),
    segments varchar(500),
    coreg varchar(200),
    value float(20, 4),
    footnote varchar(1000),
    primary key (numId)
);

CREATE TABLE num (
    -- Primary key for the table
    numericId INT AUTO_INCREMENT PRIMARY KEY,

    -- Foreign key linking to the 'sub' (submission) table
    adsh VARCHAR(20) NOT NULL COMMENT 'Accession Number. Links to the parent submission.',

    -- XBRL Tag Information (links to 'pre' table)
    tag VARCHAR(255) NOT NULL COMMENT 'The XBRL tag from the taxonomy (e.g., us-gaap:Assets).',
    version VARCHAR(50) NOT NULL COMMENT 'The XBRL taxonomy version used for the filing.',

    -- Core Fact Details
    ddate DATE NOT NULL COMMENT 'The end date for the data point (the "as of" date).',
    qtrs TINYINT NOT NULL COMMENT 'The number of quarters represented by the value (0 for instant, 1 for quarterly, etc.).',
    uom VARCHAR(20) NOT NULL COMMENT 'Unit of Measure (e.g., USD, EUR, shares).',
    value DECIMAL(28, 4) NULL COMMENT 'The numeric value of the fact. Can be NULL for certain tags.',

    -- Dimensional Information (Context)
    coreg VARCHAR(255) NULL COMMENT 'The specific co-registrant if the value belongs to one.',
    segments TEXT NULL COMMENT 'Stores dimensional data, often as a series of tag/value pairs, describing the business segment.',
    footnote TEXT NULL COMMENT 'Footnote text associated with the value.'
);

-- Enable commit and foreign key checks to catch errors
set foreign_key_checks=1;
commit;