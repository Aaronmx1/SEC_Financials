-- Disable commits and foreign key checks to minimize import errors.  These are set back at the end of DDL import.
set foreign_key_checks=0;
set autocommit=0;

-- Drop existing tables to re-create tables
drop table if exists pre;
drop table if exists tag;
drop table if exists sub;
drop table if exists num;

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
    aciks TEXT COMMENT 'Additional CIKs, if any, as a delimited string.',

    UNIQUE KEY uq_sub_adsh(adsh)
);

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
    negating BOOLEAN NOT NULL DEFAULT 0 COMMENT 'Flag indicating if the value should be negated (1 for true, 0 for false).',

    foreign key (adsh) references sub(adsh)
);

-- Create Numbers table
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
    footnote TEXT NULL COMMENT 'Footnote text associated with the value.',

    FOREIGN KEY (adsh) references sub(adsh)
);

-- Enable commit and foreign key checks to catch errors
set foreign_key_checks=1;
commit;