# Overview
This repository contains Quarterly &amp; Yearly SEC filed financials of publicly listed companies.  Datasets represented in this were pulled from data.gov for 2025-Q2.  

The purpose of this repository is to perform analysis on multiple entities to determine whether their financial records move in sync with their stock trading price over time.  This repository will continue to grow as new data sources of data are integrated to help identify trends and other factors which influence deviations or alignment between financials and stock ticker pricing.

# ETL process
**Data source:** Datasets come from data.gov and are downloaded as a text file which is tab delimited and converts to CSV.

**ETL:** Retrieves CSV files, transforms dates, handles NULL values, and updates data types to fit database tables.

**Schema:** Tables created to hold 4 unique datasets and their relationships are shown in the diagram.

# Schema
![SEC_schema drawio](https://github.com/user-attachments/assets/d41fe420-1d12-40a8-832f-f0767966c539)

## Details of Schema:
·          SUB – Submission data set; this includes one record for each XBRL submission with amounts rendered by the Commission in the primary financial statements. The set includes fields of information pertinent to the submission and the filing entity. Information is extracted from the SEC’s EDGAR system and the filings submitted to the SEC by registrants.

·          NUM – Number data set; this includes one row for each distinct amount appearing on the primary financial statements rendered by the Commission from each submission included in the SUB data set.

·          TAG – Tag data set; includes defining information about each numerical tag.  Information includes tag descriptions (documentation labels), taxonomy version information and other tag attributes.

·          PRE – Presentation data set; this provides information about how the tags and numbers were presented in the primary financial statements as rendered by the Commission.

# Data Dictionary
Each table below has an overview of it's purpose and data type.

**SUB (Submissions)** 
<img width="1065" height="1113" alt="image" src="https://github.com/user-attachments/assets/5e558734-89e1-4596-84d3-cbbce7d3c09d" />

**TAG (Tags)**
<img width="1065" height="321" alt="image" src="https://github.com/user-attachments/assets/d8df3622-6610-4302-9c4e-2a0f4883eceb" />

**NUM (Numbers)**
<img width="1066" height="326" alt="image" src="https://github.com/user-attachments/assets/56809a03-a3f7-4fd5-a532-cf3079352f81" />

**PRE (Presentation of Statements)**
<img width="1065" height="461" alt="image" src="https://github.com/user-attachments/assets/a67c5b56-69ae-4537-8205-c86bac4e4a0b" />
