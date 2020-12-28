# covid19-navarra
A simple ETL to visualize the impact of covid-19 in Navarra from opendata official data source.

## Sources
Official Navarra government covid19 [web sources](https://gobiernoabierto.navarra.es/es/coronavirus/impacto-situacion) 

## Requirements
* A UNIX like operating system.
* Python >= 3.8

## Installation
* Create a new virtual environment

You can use virtualenv wrapper (mkvirtualenv):

```
mkvirtualenv -p $(which python3.8) covid19-navarra
```

Or default virtualenv:

```
cd ~/DEV_WORKSPACE/covid19-navarra
virtualenv -p $(which python3.8) covid19-navarra
```

* Activate project virtual environment

From project root path run if you chose mkvirtualenv:
```shell script
workon covid19-navarra
```

or 
```shell script
source covid19-navarra/bin/activate
```
in case you chose default virtualenv

* Install project dependencies

From project virtual environment:
```
pip install -r requirements.txt
```

## Execution
From project virtual environment

### Entire pipeline

```shell script
./run.sh
```

### Draw only the plot

By default, without params, `plot.py` will search, in the current directory, for a data file with the following filename structure:
`data_YYYY-mm-dd.csv`
```shell script
python plot.py
```

You can use the flag `-f` to indicate a specific filename with the structure explained above.
```shell script
python plot.py -f data_2020-12-27.csv
```
