# ***General Implementation Checklist***

## Node class

- Node attributes as instance variables.
- A constructor which sets attributes to values supplied as arguments. Some values may always be initialized the same way (age = 0; isDead = False).
- The node events per timestep function.
- Node event functions with mostly no arguments and void return. They should be idempotent if applicable.
- Helper functions for edge and network events as needed. They may just provide information or modify attributes.
- Optionally, a debug function to print node information.

## Network class

- Ordered list of nodes.
- Ordered list of edges. Each edge is an unordered two-item set containing the indices of the nodes linked by the edge.
- A constructor populates lists of nodes and edges.
- Network and edge events per timestep function.
- Network event functions with mostly no arguments and void return. These will mostly not be idempotent.
- Edge event functions with mostly no arguments and void return.
- Function to print useful results and/or debug information

## Sim runner class

- The main/driver function, which:
  - Instantiates a network object.
  - Calls the timestep function of the network a number of times.
  - Displays results.

## Probabilities class or file

- Named variables for each probability needed in the model.
