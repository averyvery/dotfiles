#!/bin/sh
curl -s -F js=@$1 http://jslint.webvm.net/ |
sed 's,^,'"$1:"','
