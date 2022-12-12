# ece385
Audiovisualizer 

This is our ECE385 final project. We made a audiovisualizer that reads on board memory that stores audio files, performs an FFT on the samples and visualizes the frequency
spectrum on to a barchart.We also setup the FPGA to play audio out of it's built in CODEC. We utilised Intel's quartus software suite, and programmed on the de10 lite fpga.

How to run our project on the DE-10Lite FPGA

1. After opening up Quartus, run the start compilation command to compile the project
2. Hit the programmer button, selecting the connected device hit start to progam the board
3. Start the Eclipse program on Quartus and Generate BSP 
3. Build the project on Eclipse
4. If you want to change what audio is being played, create a mif file and flash the memory(file will likely need to be very small)

Requirements
Quartus Software
FPGA

made by Deniz Caglar and Deepak Nair
