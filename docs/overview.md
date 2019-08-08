% Network-Based ABM Framework

# ***Conceptual Overview***

## Nodes

A node represents one agent in the model. This can be anything representable by data. Commonly, nodes in a network-based ABM represent people, animals, or computers (hosts).

Nodes have attributes. An attribute is something that can vary between nodes and represents something meaningfully different among individual nodes. For a human in a disease-related model, some attributes might be isInfected (a boolean), age (an integer), or chanceToInfectWhenInteractingWithAnotherPerson (a real number \[0,1]). Prefer descriptive adjective phrases when naming attributes.

Nodes also have events, which will be described later.

## The Network

The network represents the sets of nodes and edge and how nodes interact. Networks can have various shapes and details, handled when initializing the network. Global information such as time is also stored by the network.

Networks have two types of events (network and edge).

## Events

Each timestep (which can represent any unit of time), some events may happen according to defined probabilities.

The order of event execution per timestep is node (for each node), network, edge. Within these types, execution order is random.

#### Node events

Node events are events that affect a single node, executed by that node. Node events may have indirect effects across the entire network, but may not directly modify the attributes of the network or of other nodes. Some examples of node events in a model of disease among people who share needles are spontaneousHostClearance, needleClearance (representing a needle exchange program), and death.

Each event has a probability (0,1] of it occuring each timestep. Events may have preconditions that must be met for the event to execute (e.g. a node must have a disease to die of that disease, a node must be alive to use a needle exchange program).

Events within each node are executed in a random order. The order in which nodes are processed is arbitrary because node events may not affect other nodes.

#### Edge events

Edge events are events that affect or require information from exactly two nodes. Edge events may modify the attributes of only the affected nodes. Some examples of edge events are shareInformation, giveItem, and infectOther. Edge events may be symmetric or asymmetric (i.e. affecting both nodes in the same way (two-way transfer of information) or different ways (an item is taken from one node to give to the other)). Asymmetric events don't necessarily need to modify the attributes of both nodes, for example infectOther may not modify the 'infecting' node.

Edge events may also have probabilities and preconditions.

Both the order in which edges are processed and the order in which edge events are executed per edge are random.

#### Network events

Network events are events that change the sets of nodes and edges that make up the network. Network events may require information from nodes and may modify the attributes of nodes (but this most often can and should be avoided). Some examples of network events are nodeCreation, edgeCreation, and edgeRemoval. nodeRemoval (for example if the node is dead) should generally not be done as it removes useful information. Instead, make not being dead a precondition where needed.

Network events may also have probabilities and preconditions (such as a number of living nodes or total edges to aim for). If there are strict requirements, such as a constant number of edges, network events may be executed deterministically as needed.

The order in which network events are executed is random.

