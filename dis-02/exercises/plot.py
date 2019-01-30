import sys
import csv
from matplotlib import pyplot as plt


def usage():
    print("Usage: python plot.py <CSV_FILE>")


def parse(path):
    xs = []
    ys = []
    with open(path) as infile:
        for row in csv.reader(infile):
            xs.append(float(row[0]))
            ys.append(float(row[1]))
    return (xs, ys)


def plot(xs, ys):
    plt.plot(xs, ys)
    plt.xlabel('x')
    plt.ylabel('f(x)')
    plt.show()


if __name__ == "__main__":
    try:
        xs, ys = parse(sys.argv[1])
        plot(xs, ys)
    except Exception:
        usage()
