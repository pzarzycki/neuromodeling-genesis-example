## neuromodeling-genesis-example
An example of simple visual cortex model in GENESIS 2.4

## Prerequisites
Install GENESIS 2.4 from: `https://github.com/genesis-sim/genesis-2.4`

You can install no XODUS version (without graphical UI) - **nxgenesis**.

Install GnuPlot:
`sudo apt-get install gnuplot mc emacs`

## The model
<img src="/doc/model.png" width="500">
<img src="/doc/stimuli.png" width="400">

## Run simulation
`nxgensis visual-net.g`

## Plot results
`gnuplot plot -p`

![Result-01](/doc/result-01.png)
![Result-02](/doc/result-02.png)


## References
References

[1] G. Wójcik, Modelowanie i eksploracja sieci neuronów biologicznych w GENESIS. II UMCS, Lublin, 2012

[2] J. Bower, D. Beeman, The Book of Genesis. James Bower and David Beeman, 2003
