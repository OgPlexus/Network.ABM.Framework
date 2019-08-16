# built-in rng module
import random

# defined probabilities file
import probabilities

# class definition and attributes
cdef class Node:
    cdef bint isHealthy
    cdef int ageDays
    cdef float infectionChance
    cdef bint isDead

    # constructor
    def __init__(self, infChance):
    
        # always start healthy, alive, and age 0
        self.isHealthy = True
        self.isDead    = False
        self.ageDays   = 0

        # nodes can have different probabilities of spreading disease
        self.infectionChance = infChance
        
    cpdef doNodeTimestep(self):
        # all events require the node to be alive
        if self.isDead:
            return

        # age is measured in timesteps, stops counting if node dies
        self.ageDays += 1

        # start with an empty list of events
        stepEvents = []

        # event with a probability and precondition
        if random.random() < probabilities.DIE_OF_DISEASE and not self.isHealthy:
            # add the function to the events of this step
            # note that this does not execute the function
            stepEvents.append(self.death)

        # a precondition is not needed because infection is idempotent
        if random.random() < probabilities.SPONTANEOUS_INFECTION:
            stepEvents.append(self.infect)

        # there can be as many events as needed
        if random.random() < probabilities.SPONTANEOUS_CLEARANCE:
            stepEvents.append(self.heal)

        # to ensure random execution order
        random.shuffle(stepEvents)

        # execute each event in the now-shuffled list..
        for event in stepEvents:
            # ...but stop early if the host dies
            if self.isDead:
                return
            event()

    # idempotent functions to heal, become infected, and die
    cpdef heal(self):
        self.isHealthy = True
        
    cpdef infect(self):
        self.isHealthy = False

    cpdef death(self):
        self.isDead = True

    # helper for edge interaction
    cpdef willInfect(self):
        # only infect if not healthy and rng meets the chance
        return (not self.isHealthy) and random.random() < self.infectionChance 

    # helpers for results
    cpdef isLivingUnhealthy(self):
        return (not self.isDead) and (not self.isHealthy)

    cpdef isLivingHealthy(self):
        return (not self.isDead) and (self.isHealthy)   

        # cython doesnt allow direct exposure of object variables
        # the function must be named differently than the variable
    cpdef isAlive(self):
        return not self.isDead
