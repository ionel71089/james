#!/bin/zsh

saxon -s:input.chlsx -xsl:transform.xslt -o:output.xml
cat output.xml | xq . > output.json

# saxon -s:input.chlsx -xsl:transform.xslt | xq . > output.json