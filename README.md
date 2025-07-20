# Overview
This repository contains Quarterly &amp; Yearly SEC filed financials of publicly listed companies.  Datasets represented in this were pulled from data.gov for 2025-Q2.  

The purpose of this repository is to perform analysis on multiple entities to determine whether their financial records move in sync with their stock trading price over time.  This repository will continue to grow as new data sources of data are integrated to help identify trends and other factors which influence deviations or alignment between financials and stock ticker pricing.

# Schema
![SEC_schema drawio](https://github.com/user-attachments/assets/d41fe420-1d12-40a8-832f-f0767966c539)

## Details of Schema:
·          SUB – Submission data set; this includes one record for each XBRL submission with amounts rendered by the Commission in the primary financial statements. The set includes fields of information pertinent to the submission and the filing entity. Information is extracted from the SEC’s EDGAR system and the filings submitted to the SEC by registrants.

·          NUM – Number data set; this includes one row for each distinct amount appearing on the primary financial statements rendered by the Commission from each submission included in the SUB data set.

·          TAG – Tag data set; includes defining information about each numerical tag.  Information includes tag descriptions (documentation labels), taxonomy version information and other tag attributes.

·          PRE – Presentation data set; this provides information about how the tags and numbers were presented in the primary financial statements as rendered by the Commission.
