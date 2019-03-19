#!/bin/sh

#Generate Data
echo 'Start Data Generation \n'
dataDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../data && pwd )
dataFile="$dataDIR/container_matrix_door_open.csv"
echo $dataFile
toolsDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../tools && pwd )
python $toolsDIR/generateData_door_open.py $dataFile
echo '\n Done Generating \n'

#Publish to Kafka 
echo 'Publish Kafka \n'
python3 containerProducer.py $dataFile
echo 'Kafka Done \n'

#Test the Model
echo 'Testing Model'
modelDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../predictiveModel && pwd )
jupyter nbconvert --to python "$modelDIR/predictMaintainence.ipynb"
data=pd.read_csv("$dataDIR/container_matrix_sensor_malfunction.csv", delimiter=",")
echo 'Model Tested'