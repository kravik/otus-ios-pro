#!/bin/bash

MODULE_SRC=OtusHomeWork/Modules/Networking/Sources/Networking/Generated
openapi-generator generate -i football.yaml -g swift5 -o api-mobile
rm -r $MODULE_SRC
mkdir $MODULE_SRC
cp -R api-mobile/OpenAPIClient/Classes/OpenAPIs/. $MODULE_SRC
rm -r api-mobile
