find . -name .report | xargs rm
find . -name stdout | xargs rm
find . -name .stdout | xargs rm
find . -name checks.out | xargs rm
find . -name .cache | xargs rm -rf
find . -name '.nextflow*' | xargs rm -rf  
find . -name '.node-nextflow*' | xargs rm -rf  
find . -name 'work' | xargs rm -rf
find . -name 'my-results' | xargs rm -rf 