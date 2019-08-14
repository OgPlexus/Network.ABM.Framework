# defined network class
import network

# progress bars
from tqdm import tqdm

def main():

    # a network with 1000 nodes and 1000 edges
    sim = network.Network(1000,1000)

    # run for 10 years, assuming each timestep is a day
    for _ in tqdm(range(3650)):
        sim.doTimestep()

    # at the end, print results
    sim.printResults()

if __name__ == "__main__":
    main()