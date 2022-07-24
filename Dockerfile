FROM continuumio/miniconda3
WORKDIR /adventsofcode
# WORKDIR /home/$SETUSER
# Create the environment:
COPY env.yml .

RUN conda env create -f env.yml || \
    conda env update -f env.yml

COPY . .

RUN read -p "set password: " password 
RUN hashcode=$(python ./work/maintenance/psswdgen.py $password)
# echo $hashcode

SHELL ["conda", "run", "-n", "jupyter-notebook", "--port=8889", "--NotebookApp.password=$hashcode", "--allow-root", "/bin/bash", "-c"] 