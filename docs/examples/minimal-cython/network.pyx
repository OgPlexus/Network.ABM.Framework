# built-in rng module
import random

# defined probabilities file
import probabilities

# defined node class
import node

cdef class Network:
    # ordered list of nodes
    cdef list nodes

    # ordered list of edges
    cdef list edges

    # constructor with number of nodes and edges
    def __init__(self, numNodes, numEdges):

        # start nodes/edges lists as empty
        self.nodes = []
        self.edges = []

        # create the network randomly
        for n in range(numNodes):
            self.nodeCreation()
        for e in range(numEdges):
            self.edgeCreation()

    # print results with some useful information
    def printResults(self):
        print("This is a network of " + str(len(self.nodes)) + " nodes and " + str(len(self.edges)) + " connections.")
        # count node stats
        healthyNodes   = sum(node.isLivingHealthy() for node in self.nodes)
        unhealthyNodes = sum(node.isLivingUnhealthy() for node in self.nodes)
        deadNodes      = sum(node.isDeadGet() for node in self.nodes)
        print("There are " + str(healthyNodes)  + " healthy (living) nodes.")
        print("There are " + str(unhealthyNodes)+ " unhealthy (living) nodes.")
        print("There are " + str(deadNodes)     + " dead nodes.")
    # network and edge events per timestep function
    cpdef doTimestep(self):

        # do node events for each node
        for node in self.nodes:
            node.doNodeTimestep()

        # clear events queue
        dailyEvents = []

        # various events with probabilities
        if random.random() < probabilities.DAILY_NODE_CREATION:
            dailyEvents.append(self.nodeCreation)
        if random.random() < probabilities.DAILY_EDGE_CREATION:
            dailyEvents.append(self.edgeCreation)
        if random.random() < probabilities.DAILY_EDGE_DEATH:
            dailyEvents.append(self.edgeDeath)
            
        # edge events
        for edgeInd in range(len(self.edges)):
            if random.random() < probabilities.EDGE_INTERACT:
                # append a tuple when the event takes arguments (all edge events)
                dailyEvents.append( (self.edgeInteract, self.edges[edgeInd]) )

        random.shuffle(dailyEvents)
        for event in dailyEvents:
            if type(event) == tuple:
                # execute the first item of the tuple with the second as an argument
                event[0](event[1])
            else:
                event()

        # edge death must be done last because edge events rely on edge inde


            
    # create a new node and add it to the network
    cpdef nodeCreation(self):

        # random attributes where applicable
        infChance = random.random()

        # create the node
        newNode = node.Node(infChance)

        # and add it
        self.nodes.append(newNode)

    cpdef edgeCreation(self):

        # try until ...
        while True:
            n1 = random.randrange(len(self.nodes))
            n2 = random.randrange(len(self.nodes))

            # we're not linking the node to itself
            # and the edge doesn't already exist
            if (n1 != n2) and ( {n1,n2} not in self.edges):
                # then add the edge and return
                self.edges.append({n1,n2})
                return

    # remove a random edge
    cpdef edgeDeath(self):
        # select a random edge
        popInd = random.randrange(len(self.edges))
        # and remove it
        self.edges.pop(popInd)

    cpdef edgeInteract(self, nodesSet):
        # get the indices of the interacting nodes as an ordered list
        interactingNodes = list(nodesSet)

        # if the first node will infect, infect the second
        if self.nodes[interactingNodes[0]].willInfect():
            self.nodes[interactingNodes[1]].infect()
            
        # and the other way around    
        if self.nodes[interactingNodes[0]].willInfect():
            self.nodes[interactingNodes[1]].infect()