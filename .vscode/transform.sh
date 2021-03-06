#!/bin/zsh

gsed -i '/DOCTYPE/d' input.chlsx # remove DTD, otherwise saxon fails
saxon -s:input.chlsx -xsl:transform.xslt -o:output.xml
cat output.xml | xq . > output.json
./json-to-csv output.json output.csv

# saxon -s:input.chlsx -xsl:transform.xslt | xq . > output.json