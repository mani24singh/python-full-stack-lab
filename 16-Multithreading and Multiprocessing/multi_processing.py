# Script 2: Multi-Processing

'''
When to use Multi-processing?
    1. Processes that run in parallel
    2. CPU-Bound Tasks: Tasks that are heavy on CPU usage.
        (eg. Mathematical Computations, data processing).
    3. Parallel Execution: Multiple cores of the CPU.
'''

import multiprocessing
from operator import mul
import time

def square_numbers():
    for i in range(5):
        time.sleep(1)
        print(f"Square: {i*i}")

def cube_numbers():
    for i in range(5):
        time.sleep(1.5)
        print(f"Cube: {i * i * i}")

if __name__ == '__main__':
    t = time.time()

    # Case1: Without multi-processing --> execution time (12.5 sec)
    # square_numbers()
    # cube_numbers()
    # finished_time=time.time() - t
    # print(finished_time)


    # Case2: using multiprocessing---> 7.68 seconds
    # create 2 processes
    p1=multiprocessing.Process(target=square_numbers)
    p2=multiprocessing.Process(target=cube_numbers)
    # start the process
    p1.start()
    p2.start()
    # wait for the process to complete
    p1.join()
    p2.join()

    finished_time=time.time()-t
    print(finished_time)
