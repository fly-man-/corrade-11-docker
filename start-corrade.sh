#!/bin/bash
rm -rf /corrade/Cache/*
rm -rf /corrade/State/*
cd /corrade

# check if Configuration.xml exists, if yes, skip
test -f Configuration.xml && {
    echo "### Configuration.xml exists. Keeping it."
} || {
    echo "### Generating Configuration.xml with values from environment variables"
    echo "### If Corrade does not start as expected, make sure you have all these variables set:"
    echo "### FIRSTNAME, LASTNAME, PASSWORD, GRIDURL, GROUP, GROUPPW"
    PASSWORD=`echo -n "$PASSWORD" | md5sum | awk '{print $1}'`
    GROUPPW=`echo -n "$GROUPPW" | sha1sum | awk '{print $1}'`
    sed -i "s/##FIRSTNAME##/$FIRSTNAME/" Configuration.xml.template
    sed -i "s/##LASTNAME##/$LASTNAME/" Configuration.xml.template
    sed -i "s/##PASSWORD##/$PASSWORD/" Configuration.xml.template
    sed -i "S/##GRIDURL##/$GRIDURL/" Configuration.xml.template
    sed -i "s/##GROUP##/$GROUP/" Configuration.xml.template
    sed -i "s/##GROUPPW##/$GROUPPW/" Configuration.xml.template
    mv Configuration.xml.template Configuration.xml
    # change to config file name in 11.0.236.303
    cp Configuration.xml CorradeConfiguration.xml
    cp Nucleus.xml NucleusConfiguration.xml
}

# Start Corrade
./Corrade
