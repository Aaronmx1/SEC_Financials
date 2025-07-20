import pandas as pd
import os

# Ingest CSV df files
def ingest_data():
    base_directory = '/home/aaron/secFinancials/datasets/'
    #file_name = 'num.csv'
    #file_name = 'pre.csv'
    file_name = 'sub.csv'
    #file_name = 'tag.csv'
    full_path = os.path.join(base_directory, file_name)
    return pd.read_csv(full_path, sep='\t')

def assign_data_num_types(df):
    # Convert data types
    df['ddate'] = pd.to_datetime(df['ddate'], format='%Y%m%d').dt.strftime('%Y-%m-%d')                 # string conversion
    df['value'] = pd.to_numeric(df['value'], errors='coerce').fillna(0)
    df['footnote'] = df['footnote'].astype(str)

    # Replace all remaining NaN values accross dataframe with None
    # Database driver understands None and will convert to SQL NULL
    df = df.where(pd.notna(df), None)

    return df

def assign_data_pre_types(df):
    # Replace all remaining NaN values accross dataframe with None
    # Database driver understands None and will convert to SQL NULL
    df = df.where(pd.notna(df), None)

    return df

def assign_data_sub_types(df):
    # Convert data types
    for col in ['sic', 'cik', 'ein', 'changed', 'fye', 'period', 'fy', 'filed', 'nciks']:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors='coerce').astype('Int64')

    # Replace all remaining NaN values accross dataframe with None
    # Database driver understands None and will convert to SQL NULL
    df = df.replace({pd.NA: None}).where(pd.notna(df), None)

    return df

def assign_data_tag_types(df):
    # Replace all remaining NaN values accross dataframe with None
    # Database driver understands None and will convert to SQL NULL
    df = df.where(pd.notna(df), None)

    return df

if __name__ == '__main__':
    DF = ingest_data()
    print(DF.info())