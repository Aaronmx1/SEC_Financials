-- Disable commits and foreign key checks to minimize import errors.  These are set back at the end of DDL import.
set foreign_key_checks=0;
set autocommit=0;

-- Drop existing tables to re-create tables
drop table if exists pre;

/*-------------------------------------------
*               CREATE tables
*/-------------------------------------------
-- Create Presentation of Statements
CREATE TABLE pre (
    -- Primary key for the table
    presentationId INT AUTO_INCREMENT PRIMARY KEY,

    -- Foreign key linking to the 'sub' (submission) table
    adsh VARCHAR(20) NOT NULL COMMENT 'Accession Number. Links to the parent submission.',

    -- Report and Line Item Details
    report INT NOT NULL COMMENT 'An integer that uniquely identifies the report within the submission.',
    line INT NOT NULL COMMENT 'The line number for the specific data point in the report.',
    stmt VARCHAR(4) NOT NULL COMMENT 'The financial statement code (e.g., BS, IS, CF, EQ, CI).',
    inpth BOOLEAN COMMENT 'Flag indicating if the item is part of the interactive data path.',
    rfile CHAR(1) NOT NULL COMMENT 'The file type of the report (H for HTML, X for XML).',

    -- XBRL Tag Information
    tag VARCHAR(255) NOT NULL COMMENT 'The XBRL tag from the taxonomy (e.g., us-gaap:Assets).',
    version VARCHAR(50) NOT NULL COMMENT 'The XBRL taxonomy version used for the filing (e.g., us-gaap/2023).',
    plabel VARCHAR(512) COMMENT 'The human-readable label for the tag as it appears in the report.',

    -- Value attribute
    negating BOOLEAN NOT NULL DEFAULT 0 COMMENT 'Flag indicating if the value should be negated (1 for true, 0 for false).'
);

-- Enable commit and foreign key checks to catch errors
set foreign_key_checks=1;
commit;