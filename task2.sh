#!/bin/bash

# Navigate to the dataset1 directory or exit if not found
cd dataset1 || { echo "Error: dataset1 directory does not exist."; exit 1; }

# Identify files containing "sample" and count occurrences of "CSC510" in each
grep -l "sample" * | \
xargs -I {} sh -c 'echo "{} $(grep -o "CSC510" {} | wc -l)"' | \
awk '$2 >= 3 {print $1, $2}' | \
while read -r file occurrence_count; do
    file_size=$(stat -f%z "$file")
    echo "$occurrence_count $file_size $file"
done | \
sort -k1,1nr -k2,2nr | \
awk '{print $3}' | \
sed 's/^file_/filtered_/'

