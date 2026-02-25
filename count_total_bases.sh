for i in `find *.fq.gz`; do echo -n $i; printf " "; zcat $i | awk 'NR%4==2 {sum += length($0)} END {print sum}' ; done

echo "all done"
