# built-in rng module
import random

# probabilities file defined later
import probabilities

# class definition and attributes
cdef class node:
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
        self.age += 1

        # start with an empty list of events
        stepEvents = []

        # event with a probability and precondition
        if random.random() < probabilities.DIE_OF_DISEASE and not self.isHealthy:
            # add the function to the events of this step
            # note that this does not execute the function
            stepEvents.append(self.death)

        # a precondition is not needed because infection is idempotent
        if random.random() < probabilities.SPONTANEOUS_INFECTION:
            stepEvents.append(self.infection)

        # there can be as many events as needed
        if random.random() < probabilities.SPONTANEOUS_CLEARANCE:
            stepEvents.append(self.heal)

        # to ensure random execution order
        random.shuffle(stepEvents)

        # execute each event in the now-shuffled list..
        for event in stepEvents:
            # ...but stop early if the host dies
            if self.dead:
                return
            event()
