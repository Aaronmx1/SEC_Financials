# Overview: Load dataset into mariadb

# Load libraries
import pandas as pd
import mariadb
from db_connector import get_sec_financials_db_connection
from reviewData import ingest_data, assign_data_num_types, assign_data_pre_types, assign_data_sub_types, assign_data_tag_types

def insert_location_data(dataset, batch_size=500):
    ''' Receives CSV containing location data and inserts into database. '''

    # Initiate database connection
    conn = get_sec_financials_db_connection()

    # Check connection
    if conn is not None:
        try:
            # Get cursor to provide interface for interacting with Server
            cur = conn.cursor()

            # Insert in batches
            for start in range(0, len(dataset), batch_size):
                end = start + batch_size
                batch = dataset.iloc[start:end]

                # Insert records into database - num table
                '''
                cur.executemany("INSERT INTO num (adsh, tag, version, ddate, qtrs, uom, segments, coreg, value, footnote) VALUES (?,?,?,?,?,?,?,?,?,?)", 
                                batch.values.tolist())
                '''

                # Insert records into database - pre table
                '''
                cur.executemany("INSERT INTO pre (adsh, report, line, stmt, inpth, rfile, tag, version, plabel, negating) VALUES (?,?,?,?,?,?,?,?,?,?)", 
                                batch.values.tolist())
                '''

                # Insert records into database - sub table
                
                cur.executemany("    INSERT INTO sub ( adsh, cik, name, sic, countryba, stprba, cityba, zipba, bas1, bas2, baph, countryma, stprma, cityma, zipma, mas1, mas2, countryinc, stprinc, ein, former, changed, afs, wksi, fye, form, period, fy, fp, filed, accepted, prevrpt, detail, instance, nciks, aciks) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
                                batch.values.tolist())
                
                
                '''
                # Insert records into database - tag table
                cur.executemany("INSERT INTO tag (tag, version, custom, abstract, datatype, iord, crdr, tlabel, doc) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", 
                                batch.values.tolist())
                '''    

                # Commit insertion into database
                conn.commit()
                print(f"Last Inserted ID: {cur.lastrowid}")

            print("All data inserted")
            return 1

        except mariadb.Error as e:
            print(f"Error: {e}")
            return 0
    else:
        print("Connection not established.")
        return 0

if __name__ == '__main__':
    # Read in dataset
    DF = ingest_data()
    #print("DF: ", DF.head())

    # Update data types - num table
    '''
    data = assign_data_num_types(DF)
    print("data: ", data.head())
    '''

    # Update data types - pre table
    '''
    data = assign_data_pre_types(DF)
    print("data: ", data.head())
    '''

    # Update data types - sub table
    
    data = assign_data_sub_types(DF)
    print("data: ", data.head())
    

    # Update data types - sub table
    '''
    data = assign_data_tag_types(DF)
    print(data.head())
    '''

    # Insert dataset into table
    if(insert_location_data(data)):
        print("Successful.")
    else:
        print("Failed.")
    