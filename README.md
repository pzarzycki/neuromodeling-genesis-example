## neuromodeling-genesis-example
An example of simple visual cortex model in GENESIS 2.4

## Prerequisites
Install GENESIS 2.4 from: `https://github.com/genesis-sim/genesis-2.4`

You can install no XODUS version (without graphical UI) - **nxgenesis**.

Install GnuPlot:
`sudo apt-get install gnuplot mc emacs`

## The model
The model is a simple vision system model that contains: a) a retina, 10x10 cells, divided into 5x5 hypothetical reception fields; b) four cortical columns, 8x8x16 cells each. Each cell from a reception field is connected with 1% of every cell from associated cortical column. Cortical columns are not connected. Retina cells are not connected to each other. Cortical columns are connected within with a density of 1%. See Figure 1.

<img src="/doc/model.png" width="500">

To stimulate response by the network the stimuli is applied to the retina cells. The stimuli is a single random spike 1A 200Hz applied to retina cells in a “chessboard” pattern (Figure 2).

<img src="/doc/stimuli.png" width="250">

The model was built using GENESIS neural simulation environment (version 2.4) . Neuron model was taken from [1]. Network creation and connection scripts were also based on [1] and modified to achieve required architecture. Script visual-net.g is the main code for simulation, while functions.g contains helper functions.
Both retina and cortical column cells were constructed from the same cell template.


## Run simulation
`nxgensis visual-net.g`

Simulated period was 0.5 second with the step = 50μs. It took 155 cpu seconds to compute.

## Plot results
`gnuplot plot -p`

A single cell in each cortical column was picked to record its soma potential (same relative position in each column at last layer, i.e.: [1,5,16]). Figures 3 and 4 shows soma potential for these cells measured during simulation.

![Result-01](/doc/result-01.png)
![Result-02](/doc/result-02.png)


## References
References

[1] G. Wójcik, Modelowanie i eksploracja sieci neuronów biologicznych w GENESIS. II UMCS, Lublin, 2012

[2] J. Bower, D. Beeman, The Book of Genesis. James Bower and David Beeman, 2003
