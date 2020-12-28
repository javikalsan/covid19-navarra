import argparse
import traceback
import pandas as pd
from datetime import datetime
from matplotlib import pyplot


def current_data_file():
    now = datetime.now()
    return 'data_{}-{}-{}.csv'.format(now.year, now.strftime('%m'), now.strftime('%d'))


def configure_series(filename):
    series = pd.read_csv(filename, header=0, index_col=0, parse_dates=['date'], squeeze=False)
    series['MM(7) rolling mean of new positives'] = series['Last day variation new positives'].rolling(7).mean()
    return series


def draw_plot(series):
    legend_properties = {'weight': 'bold'}
    series.plot(color={'Last day variation new positives': '#8a0303',
                       'Last day variation new hospitalizations': '#897AB9',
                       'MM(7) rolling mean of new positives': '#99cc33'},
                linewidth=2,
                title="NAVARRA COVID-19",
                )
    pyplot.xlabel('date', fontweight='bold', labelpad=20)
    pyplot.ylabel('people', fontweight='bold', labelpad=30)
    pyplot.grid()
    pyplot.show()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--file', action='store', required=False, help='Data source file')
    args = parser.parse_args()
    filename = args.file
    try:
        if not filename:
            filename = current_data_file()
        draw_plot(configure_series(filename))
    except Exception as exc:
        print("Exception: {} {}".format(type(exc), exc))
        traceback.print_exc()


if __name__ == "__main__":
    main()
