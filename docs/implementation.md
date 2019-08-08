# ***General Implementation Checklist***

## Node class

- Node attributes as instance variables
- The constructor sets attributes to supplied values. Some values may always be set the same way (age = 0; isDead = False).
- Node events timestep function
- Node event functions, mostly with no arguments and void return. Idempotent if applicable.
- Helper functions for edge and network events, may just provide information or modify attributes
- Some kind of toString or debug printing function

## Network class

- Lists/arrays of nodes and edges. If edges have weights, represent as a two-item array of \[edge, weight] in the edges list/array
- Store edges as unordered sets
- Constructor populates lists/arrays of nodes and edges
- Network and edge events timestep function
- Network event functions, mostly with no arguments and void return
- Edge event functions. Prefer calling per-node applier functions for anything that doesn't require both nodes
- Function to print useful results and/or debug information

## Sim runner class

- Has the `main` function
- Initializes a network object
- Calls the timestep function of the network a number of times
- Displays results

## Probabilities class or file

- Prefer to not use a class if possible
- Contains all probability values needed in one place for easy adjustment
