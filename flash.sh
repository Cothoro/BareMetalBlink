#!/bin/bash
set -xe

st-flash write build/main.bin 0x08000000
