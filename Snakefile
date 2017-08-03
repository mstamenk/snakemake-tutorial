# Snakefile script to organize the data architecture of the project
# 
# Author: Marko Stamenkovic
# Site: https://mstamenk.github.io
# Mail: stamenkovim@gmail.com
#
# This script is part of the Snakemake Tutorial for data analysts
# Please visit : https://mstamenk.github.io/2017/07/snakemake-tutorial-for-data-analysts.html
# for more informations

from routines.Analysis import loc, parseDatafiles

setup_path = loc.SCRIPTS + 'setup_path.sh'


configfile: "config.yml"

rule compile:
    input: 
        script = loc.CPPSRC + 'produce.cpp'
    output:
        exe    = loc.CPP + 'produce.out'
    shell:
        "echo 'g++ -std=c++11 {input.script} -o {output.exe}' &&"
        "g++ -std=c++11 {input.script} -o {output.exe}"


filename, c = parseDatafiles(config["mode"])
plotname = filename.replace('.dat','.pdf') 

rule process:
    input:
        exe = loc.CPP + 'produce.out',
        script = loc.PYTHON + 'process.py'
    output:
        dat = loc.RESOURCE + filename
    shell:
        "python {input.script} --mode {config[mode]} --start {config[start]} --end {config[end]}"
 
rule plot:
    input:
        script = loc.PYTHON + 'plot.py',
        dat = loc.RESOURCE + filename
    output:
        plot = loc.PLOTS + plotname
    shell:  
        "python {input.script} --mode {config[mode]}"

rule clean:
    params:
        cpp = loc.CPP,
        resource = loc.RESOURCE,
        plots = loc.PLOTS
    shell:
        "rm {params.cpp}/*.out && rm {params.resource}/*.dat && rm {params.plots}/*"
