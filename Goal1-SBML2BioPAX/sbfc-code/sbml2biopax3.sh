#!/bin/bash

## Example script to use the System Biology Format Converter to convert an SBML model into BioPAX level 3.
SBF_CONVERTER_HOME=`dirname $0`

${SBF_CONVERTER_HOME}/sbfConverter.sh SBMLModel SBML2BioPAX $1

