# Comparing Azimuth data with ASCT+B reporter data

## Scripts

### ```R/extract_ct_from_ref.R```

#### Description
This script takes [reference files from Azimuth](https://azimuth.hubmapconsortium.org/references/)
and converts them into csv files that can be viewed in [the ASCT+B reporter](https://hubmapconsortium.github.io/ccf-asct-reporter/).
We also generate summaries for each organ to denote Cell-Type vs Number-of-cells.
A final summary of all organ-datasets processed from Azimuth reference data and ASCT+B master data, 
will also be available [here](https://hubmapconsortium.github.io/asctb-azimuth-data-comparison/).


#### Usage
```
Rscript R/extract_ct_from_ref.R
```

This script reads a JSON config file called ```organ_data.json``` in the
```data``` directory. Then, based on this config it extracts the data from the
required Rds files and stores them in ASCT+B table format. The structure of this
config file is as follows:

```json
{
  "references": [
    {
      "name": "<organ_name>",
      "url": "<azimuth_reference_data_download_url>",
      "cell_type_columns": [
        "<hierarchy_column-1>",
        "<hierarchy_column-2>",
        ...
        "<hierarchy_column-n>"
      ],
      "asctb_name": "<deployment_display_name>",
	  "asctb_master_url": "<asctb_master_data_download_url>"
    },
    {
      "name": "<organ_name>",
      "url": "<azimuth_reference_data_download_url>",
      "cell_type_columns": [
        "<hierarchy_column-1>",
        "<hierarchy_column-2>",
        ...
        "<hierarchy_column-n>"
      ],
	  "new_cell_type_files":[
		"<csv_file-1>",
		"<csv_file-2>",
		...
		"<csv_file-n>"
      "asctb_name": "<deployment_display_name>",
	  "asctb_master_url": "<asctb_master_data_download_url>"
    },
    {
      ...
    },
    ...
  ] 
}

```

```<azimuth_reference_data_download_url>``` is the URL for downloading the Azimuth 
reference file for ```<organ_name>```. Such download URLs can be found by 
clicking on the Zenodo URLs on the [the Azimuth references webpage](https://azimuth.hubmapconsortium.org/references/).
```<organ_name>``` is the name that is associated with its respective download URL.

```<hierarchy_column-n>``` are names of columns in the reference Rds files that
define the cell type hierarchy of a cell in the organ. These column names can be
found in the "Annotation Details" section of an organ on 
[the Azimuth references webpage](https://azimuth.hubmapconsortium.org/references/).
Columns higher in the cell type hierarchy should have a lower value of "n".

```<csv_files-n>``` are names of csv-files to be retrieved from the Azimuth Website backend,
that contain the cell-type hierarchy data of a cell in the organ.
These file names match with the annotations mentioned as per the above "hierarchy_col".
File-Names that are higher in the cell type hierarchy should have a lower value of "n".

```<asctb_master_data_download_url>``` is the URL for downloading the v1 Google Sheet 
for each ```<organ_name>```. These download URLs can be found on the [the CCF Master Tables page](https://hubmapconsortium.github.io/ccf-asct-reporter/).

```<deployment_display_name>``` is the string that is displayed on the final GitHub 
Pages website for the download link of the corresponding config.

Furthermore, this script also merges ontology ID and ontology label of every cell type
with the cell type data extracted from Azimuth's reference files. This data can be
found in a table on [the Azimuth references webpage](https://azimuth.hubmapconsortium.org/references/)
under the "Annotation Details" section for every available body organ. 

This ontology-data is retrieved by pulling and parsing files from [the Azimuth Website Repository](https://github.com/satijalab/azimuth_website).

The organ's final ASCT+B table format file is stored in ```data/asctb_tables``` 
directory as ```<organ_name>.csv```. 

The corresponding summary file is stored in ```data/summary_tables``` 
directory as ```<organ_name>.celltype_stats.csv```.

The overall summary file for ASCTB master data, and Azimuth reference data ingested 
is stored in ```data/summary_tables``` directory as ```<organ_name>.celltype_stats.csv```.



## Deployment

All available CSV files can be seen [here](https://hubmapconsortium.github.io/asctb-azimuth-data-comparison/).
Through GitHub Workflows every time a commit is pushed to main, the script 
```R/extract_ct_from_ref.R``` is run and resultant CSV files are deployed so that
they can be accessed through GitHub pages. This ensures latest ASCT+B CSV data and summaries
are always available on GitHub pages.