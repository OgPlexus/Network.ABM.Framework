# ***Other pieces***

## Initializing the network

The simplest case of network creation involves executing the node creation network event a number of times then the edge creation network event a number of times.

More complex networks can be constructed using conditional or specific edge or node creation. For example, choose two nodes from the set that has a certain attribute and create an edge between them.

## Running the model (sim runner)

The sim runner is a program which creates a network, runs for a number of timesteps, then displays information about the network.

## Getting information from the network

The network class may have functions which print or return information about the network. This information is the useful 'output' of the simulation.

The node class may also have similar functions, but will most likely only be useful for debugging.

