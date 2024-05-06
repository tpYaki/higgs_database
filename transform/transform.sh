#!/bin/bash

# check
if [ $# -eq 0 ]; then
    echo "give num as window size"
    exit 1
fi

file=$1

#awk -v file=$file -v OFS='\t' 'BEGIN {print "track type=bedGraph name=\""file"\" description=\"BedGraph format\" visibility=full color=200,100,0 altColor=0,100,200 priority=20"} NR==1 {next} {gsub(/,/, OFS); for (i = 2; i <= NF; i++) printf "%s%s", $i, (i==NF ? "\n" : OFS)}' ${file}.csv > ${file}.bedgraph

# Process the CSV, extract the 3rd and 8th columns, and replace the delimiter with a tab
awk -F, -v OFS='\t' '{print $3, $8}' ${file}.csv |

# Sort to prepare for merging
sort |

# Use awk to merge rows, retaining the original number with the largest absolute value for the same first column
awk -v OFS='\t' 'function abs(v) {return v < 0 ? -v : v}
     {
         if ($1 != prev) {
             if (NR != 1) print prev, max_val;  # If the first column changes, print the previous max value
             prev = $1;  # Update previous key
             max_val = $2;  # Update current max value
             max_abs = abs($2);  # Update max absolute value
         } else {
             if (abs($2) > max_abs) {
                 max_val = $2;  # Update to new value if its absolute is larger
                 max_abs = abs($2);  # Update the max absolute value
             }
         }
     }
     END {
         print prev, max_val  # Print the last collected max value
     }' |

# Prepend "chr16" to each line and add new column with first column value incremented by 1
awk -v OFS='\t' '{print "chr16", $1, $1+1, $2}' |

# Add a custom first line to the final file
awk -v file=$file 'BEGIN {print "track type=bedGraph name=\"'file'\" description=\"BedGraph format\" visibility=full color=200,100,0 altColor=0,100,200 priority=20"} 1' > ${file}.bedgraph


echo "down, $file.bedgraph is generated"

