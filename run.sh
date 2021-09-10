#!/bin/bash
saxon_file_dir=saxon
input_dir=input_html
output_dir=output_html
volume=10
issue=2


for i in `seq 1 1 10`;
do
	rm -rf $output_dir/naer_${volume}_${issue}_$i
	mkdir -p $output_dir/naer_${volume}_${issue}_$i
	echo `grep 'https://typeset-prod-media-server.s3.amazonaws.com/' $input_dir/$i.html | grep src | cut -d'"' -f2 ` > fig_tmp.txt
	cat fig_tmp.txt | uniq > figures.txt
	for url in `cat figures.txt`
	do
		figname=`echo $url | cut -d/ -f7`
		wget -O $output_dir/naer_${volume}_${issue}_$i/${figname} $url
	done

	java -jar $saxon_file_dir/saxon-9.1.0.8.jar -s:$input_dir/$i.html -xsl:naer_converter.xsl -o:$output_dir/naer_${volume}_${issue}_$i/naer_${volume}_${issue}_$i.html
done
