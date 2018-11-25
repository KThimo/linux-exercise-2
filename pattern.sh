#! /bin/bash

# PART 1

# 1. Downloads the fasta file

wget http://139.91.162.50/bioinf2018/fasta.fa

# 2. Counts how many sequences have at least an indel (i.e. at least a single '-')
# We use -c flag to count anything not starting with '>' and has at least one '-'
# We could also use -v flag instead without the NOT (^[]), but it also counts the empty lines,
# and we would then have to reduce egrep -cv '[ACTGactg-]' fasta.fa lines from our result

egrep -c '^[^>].*-{1,}' fasta.fa

# 3. Counts how many sequences have at least two continuous indels (i.e. '--')
# Same command with 2., but we now want at least two '-'

egrep -c '^[^>].*-{2,}' fasta.fa

# 4. Counts how many sequences have a pattern that looks like that N_N_N, where N can be any nucleotide
# We use -i so characters that differ only in case match each other, and pipe to combine egrep results

egrep -i 'A-A-A' fasta.fa | egrep -i 'G-G-G' | egrep -i 'T-T-T' | egrep -ci 'C-C-C'

# 5. Counts how many sequences have no '-'
# -v flag inverts the sense of matching, to select non-matching lines and -e flag is --regexp,
# which also removes the lines that have only '-'

egrep '^[^>]' fasta.fa | egrep -cve '-.*'

# 6. Extracts all motifs that are three 'G's then a pyrimidine and then a purine.
# We use -o flag to extract the motifs, then we sort them, use uniq command to get only the different motifs,
# and -i to do so case insensitively, also -c counts them, and then we sort them again in a reversed order
# (i.e. declining order) as human numeric readable (with -h) (meaning reading 1 < 2 < 3 < 4 and so on) 

egrep -o 'G{3}[TUCtuc][AGag]' fasta.fa | sort | uniq -ic | sort -rh
