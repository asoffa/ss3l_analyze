#!/bin/bash

echo $(dirname $(dirname $(readlink -f "$BASH_SOURCE")))
