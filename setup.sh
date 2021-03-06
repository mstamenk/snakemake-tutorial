# BASH script to setup the working environment and to activate snakemake or not
# 
# Author: Marko Stamenkovic
# Site: https://mstamenk.github.io
# Mail: stamenkovim@gmail.com
#
# This is part of the Snakemake Tutorial for data analysts
# Please visit: https://mstamenk.github.io/2017/07/snakemake-tutorial-for-data-analysts.html
# for more informations

# The script can be used to set the snakemake environment or not
if [ "$1" = "snake" ]; then
    echo "Setup with snakemake using python3"
    source activate snake  
else 
    echo "Setup without snakemake using python2"
#    source scripts/setup_path.sh # Uncomment if you need other libraries or in order to set an environment with python2
fi
# Definition of various path in the architecture of the project

export MYROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export CPP=$MYROOT/cpp
export CPPSRC=$CPP/src

export TUTO=$MYROOT
export SCRIPTS=$MYROOT/scripts

export PYTHON=$MYROOT/python

export RESOURCE=$MYROOT/resource
export ROUTINES=$MYROOT/routines

export PLOTS=$MYROOT/plots


# User-sensitive way to define your project, define the folders that are not the same from one person to the other.
# Once the repertories updated with a git pull, every user should be able to run the full analysis
if [ "$USER" = "marko" ]
then
    export PLOTS=$HOME/Desktop/plots #Override the locations in a user sensitive way
elif [ "$USER" = "COMPLETE HERE" ]
then
    export PLOTS=$MYROOT/plots
else
    echo "Don't forget to compelte the paths in the setup.sh in order to run the scripts!"
fi

# In order to import python modules
export PYTHONPATH=$PYTHONPATH:$TUTO:$ROUTINES:$PYTHON

# Snakemake environment requires python3. In order to overcome this issue, you can store the path to python2 and use it in the shell commands of the Snakefile
#export PY2='/Users/marko/anaconda/bin/python2'
