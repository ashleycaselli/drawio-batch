#!/bin/bash

set -e
set -x

rm -r img || true

# check general conversion
node drawio-batch.js ./drawio/src/main/webapp/templates/uml/uml_1.xml pdf test
file img/test.pdf | grep 'PDF document'
rm img/test.pdf

# check diagram id handling
node drawio-batch.js ./test/multipleSheets.xml pdf test
pdftotext img/test.pdf - | grep BoxOnSheetOne
rm img/test.pdf

node drawio-batch.js -d 0 ./test/multipleSheets.xml pdf test
pdftotext img/test.pdf - | grep BoxOnSheetOne
rm img/test.pdf

node drawio-batch.js -d 1 ./test/multipleSheets.xml pdf test
pdftotext img/test.pdf - | grep BoxOnSheetTwo
rm img/test.pdf

rm -r img/
