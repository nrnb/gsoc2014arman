#!/bin/bash

RESOLVE_LINK=`readlink -f $0`

SBF_CONVERTER_HOME=`dirname ${RESOLVE_LINK}`


${SBF_CONVERTER_HOME}/sbfConverter.sh SBMLModel SbmlToSbgnML $1


