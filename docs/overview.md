% Network-Based ABM Framework

# ***Conceptual Overview***

## Nodes

A node is an object representing one agent in the model. Examples are a person, animal, country, or computer.

Nodes have attributes. An attribute is a trait that varies among nodes, usually numerical or boolean. Examples are ageInDays, isDead, or chanceToInfect.

Nodes also have events, which are described in [a later section](#node-events).

## The Network

The network is an object representing the set of nodes in the model and how they interact. Global information such as time may also be stored by the network.

The network object stores the list of nodes and list of sets in the model.

Networks have two types of events, [network](#network-events) and [edge](#edge-events).

## Events

Each timestep (which can represent any unit of time), some events may happen according to defined probabilities.

All events may have preconditions that must be met for the event to occur.

Node events occur first, then network, then edge. Within these three types, order is random.

#### Node events

Node events affect exactly one node. When executing a node event, a node may not access or modify the attributes of other nodes.  Some examples of node events are clearInfection, injectDrug, or die.

Both the order in which nodes are processed and the order in which node events are executed per edge are random.

#### Edge events

Edge events modify and/or require information from exactly two nodes. Edge events do not have to modify both nodes in the same way, or modify both nodes at all. Some examples of edge events are shareInformation, giveItem, and infectOther.

Both the order in which edges are processed and the order in which edge events are executed per edge are random.

#### Network events

Network events modify the composition of the network by changing its sets of nodes and edges. Network events may require information from nodes and may modify the attributes of nodes, but this should be avoided if possible. Some examples of network events are nodeCreation, edgeCreation, and edgeRemoval.

Nodes should never be removed from the network. Instead, make not being dead (or the model's equivalent) a precondition as needed.

If there are strict requirements on the network, such as a constant number of edges or nodes, use network events with a probability of one and a precondition of not meeting the requirements.
