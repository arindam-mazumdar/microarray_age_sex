#!/bin/bash

count=0  # Initialize a variable to keep track of the number of files downloaded

# Read the file line by line
while IFS= read -r link
do
    # Use wget to download each file
    wget "$link"
    ((count++))  # Increment the count after each successful download
done < cel_links.txt

# Output the number of files downloaded as a comment
echo "Number of files downloaded: $count"

