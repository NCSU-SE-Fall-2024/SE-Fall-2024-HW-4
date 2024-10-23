#!/bin/bash

# Extract passengers from 2nd class who embarked at Southampton, replace male/female labels, and print them
awk -F, 'BEGIN {OFS = FS} 
NR == 1 {print; next} 
$3 == 2 && $NF ~ /S/ {
    gsub(/female/, "F", $6)
    gsub(/male/, "M", $6)
    print
}' titanic.csv

# Calculate the average age of 2nd class passengers who embarked at Southampton
awk -F, 'NR > 1 && $3 == 2 && $NF ~ /S/ {
    gsub(/"/, "", $7)   # Clean up age field
    gsub(/^[ \t]+|[ \t]+$/, "", $7)   # Trim whitespaces

    if ($7 ~ /^[0-9]+(\.[0-9]+)?$/) {  # Ensure age is a valid number
        total_age += $7; passenger_count++
    }
}
END {
    if (passenger_count > 0) 
        print "Average Age:", total_age/passenger_count
    else 
        print "No valid age data available"
}' titanic.csv
