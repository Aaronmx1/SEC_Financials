-- Disable commits and foreign key checks to minimize import errors.  These are set back at the end of DDL import.
set foreign_key_checks=0;
set autocommit=0;

-- Drop existing tables to re-create tables
drop table if exists sub;

/*-------------------------------------------
*               CREATE tables
*/-------------------------------------------
-- Create Submissions table
CREATE TABLE sub (
    -- Primary key for the table
    subId INT AUTO_INCREMENT PRIMARY KEY,

    -- Core Submission Information
    adsh VARCHAR(20) NOT NULL COMMENT 'Accession Number. A unique identifier for the submission.',
    cik INT NOT NULL COMMENT 'Central Index Key. A unique identifier for the registrant.',
    name VARCHAR(150) NOT NULL COMMENT 'Name of the registrant.',
    sic INT(11) COMMENT 'Standard Industrial Classification code.',

    -- Business Address
    countryba VARCHAR(2) COMMENT 'Business address country code.',
    stprba VARCHAR(2) COMMENT 'Business address state or province.',
    cityba VARCHAR(30) COMMENT 'Business address city.',
    zipba VARCHAR(10) COMMENT 'Business address ZIP or postal code.',
    bas1 VARCHAR(40) COMMENT 'Business address street line 1.',
    bas2 VARCHAR(40) COMMENT 'Business address street line 2.',
    baph VARCHAR(20) COMMENT 'Business address phone number.',

    -- Mailing Address
    countryma VARCHAR(2) COMMENT 'Mailing address country code.',
    stprma VARCHAR(2) COMMENT 'Mailing address state or province.',
    cityma VARCHAR(30) COMMENT 'Mailing address city.',
    zipma VARCHAR(10) COMMENT 'Mailing address ZIP or postal code.',
    mas1 VARCHAR(40) COMMENT 'Mailing address street line 1.',
    mas2 VARCHAR(40) COMMENT 'Mailing address street line 2.',

    -- Incorporation Information
    countryinc VARCHAR(2) COMMENT 'Country of incorporation.',
    stprinc VARCHAR(2) COMMENT 'State or province of incorporation.',

    -- Entity and Filing Details
    ein INT COMMENT 'Employer Identification Number.',
    former VARCHAR(150) COMMENT 'Former name of the entity.',
    changed INT(11) COMMENT 'Date of name change (YYYYMMDD).',
    afs VARCHAR(5) COMMENT 'Accountant firm status.',
    wksi BOOLEAN NOT NULL COMMENT 'Well-Known Seasoned Issuer status.',
    fye INT(4) COMMENT 'Fiscal Year End (MMDD).',
    form VARCHAR(10) NOT NULL COMMENT 'Submission form type (e.g., 10-K).',
    period INT COMMENT 'End date of the reporting period (YYYYMMDD).',
    fy INT(11) COMMENT 'Fiscal Year.',
    fp VARCHAR(2) COMMENT 'Fiscal Period (e.g., Q1, FY).',
    filed INT(11) NOT NULL COMMENT 'Filing date (YYYYMMDD).',
    accepted DATETIME NOT NULL COMMENT 'Date and time of SEC acceptance.',
    prevrpt BOOLEAN NOT NULL COMMENT 'Indicates if this is a previous report.',
    detail BOOLEAN NOT NULL COMMENT 'Detail flag.',
    instance VARCHAR(50) NOT NULL COMMENT 'Instance file name.',
    nciks INT(11) NOT NULL COMMENT 'Number of CIKs in the filing.',
    aciks TEXT COMMENT 'Additional CIKs, if any, as a delimited string.'
);

-- Enable commit and foreign key checks to catch errors
set foreign_key_checks=1;
commit;