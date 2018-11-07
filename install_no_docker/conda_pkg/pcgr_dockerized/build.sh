#!/usr/bin/env bash

mkdir -p ${PREFIX}/bin
chmod +x ${SRC_DIR}/*.py
${SRC_DIR}/*.py ${PREFIX}/bin/
