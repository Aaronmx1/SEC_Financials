-- Disable commits and foreign key checks to minimize import errors.  These are set back at the end of DDL import.
set foreign_key_checks=0;
set autocommit=0;

-- Drop existing tables to re-create tables
drop table if exists tag;

/*-------------------------------------------
*               CREATE tables
*/-------------------------------------------
-- Create Tags table
CREATE TABLE tag (
    -- Primary key for the table
    tagId INT AUTO_INCREMENT PRIMARY KEY,

    -- Core Tag Information
    tag VARCHAR(255) NOT NULL COMMENT 'The XBRL tag from the taxonomy (e.g., us-gaap:Assets).',
    version VARCHAR(50) NOT NULL COMMENT 'The XBRL taxonomy version (e.g., us-gaap/2023).',

    -- Tag Properties
    custom BOOLEAN NOT NULL COMMENT 'Flag indicating if this is a custom tag specific to the filing.',
    abstract BOOLEAN NOT NULL COMMENT 'Flag indicating if this tag is an abstract grouping and not used for numeric facts.',
    datatype VARCHAR(50) NOT NULL COMMENT 'The data type of the tag (e.g., monetary, string, date).',
    iord CHAR(1) NOT NULL COMMENT 'Indicates if the tag represents an "Instant" (I) or a "Duration" (D).',
    crdr CHAR(1) NULL COMMENT 'The normal balance of the tag, either "Credit" (C) or "Debit" (D).',

    -- Descriptive Information
    tlabel VARCHAR(512) COMMENT 'The standard, human-readable label for the tag.',
    doc TEXT NULL COMMENT 'The official definition or documentation for the tag.'
);

-- Enable commit and foreign key checks to catch errors
set foreign_key_checks=1;
commit;