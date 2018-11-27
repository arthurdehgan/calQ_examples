from joblib import Parallel, delayed
from itertools import product

# Define your constants here
ELEC_LIST = []
FREQ_LIST = []


def function(elec, freq):
    # Put your code here.
    pass  # Delete me I am just a placeholder for your code.


if __name__ == "__main__":
    Parallel(n_jobs=-1)(
        delayed(function)(elec, freq) for elec, freq in product(ELEC_LIST, FREQ_LIST)
    )
