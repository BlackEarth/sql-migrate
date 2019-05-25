import os, json
from setuptools import setup, find_packages
from codecs import open

PATH = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(PATH, "setup.json"), encoding='utf-8') as f:
    CONFIG = json.load(f)

with open(os.path.join(PATH, 'README.md'), encoding='utf-8') as f:
    README = f.read()

if __name__ == '__main__':
    setup(
        long_description=README,
        packages=find_packages(exclude=['contrib', 'docs', 'tests']),
        **CONFIG)
