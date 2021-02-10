#!/bin/bash

which clickhouse-client; e=$?
if [ "0" != "$e" ]; then
    which clickhouse; e=$?
    if [ "0" = "$e" ]; then
        alias clickhouse-client="clickhouse client"
    fi
    alias ch="clickhouse-client"
fi
