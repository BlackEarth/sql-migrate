#!/bin/bash

cd `dirname $0`
PACKAGE_PATH=`pwd`
source $PACKAGE_PATH/venv

# cleanup tests/var
rm -rf $PACKAGE_PATH/tests/var/*

# run the tests
nosetests -w $PACKAGE_PATH/tests \
 --with-doctest \
 --with-coverage \
 --cover-package=... \
 --cover-inclusive \
 --cover-erase \
 --cover-branches \
 --cover-html \
 --cover-html-dir="$PACKAGE_PATH/tests/coverage" \
 $@

