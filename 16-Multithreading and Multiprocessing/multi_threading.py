# Script 1: Multi-Threading

'''
when to use multi-threading??
    1. I/O-bound tasks: Tasks that spend more time waiting for operations.
    (eg. file operations, network requests).
    2. Concurrent execution: when we want to improve the throughput of our
    application by performing multiple operations concurrently.
'''

import threading
import time

def print_numbers():
    for i in range(5):
        time.sleep(2)
        print(f"Number: {i}")

def print_letter():
    for letter in 'abcde':
        time.sleep(2)
        print(f"Letter: {letter}")

t = time.time()

## case1: when we dont use multi-threads (20 seconds execution time)
# print_numbers()
# print_letter()
# finished_time=time.time()-t
# print(finished_time)

# -----------------------------------------

# Case2: Using Multi-threads

# Create 2 threads
t1=threading.Thread(target=print_numbers)
t2=threading.Thread(target=print_letter)

# Start the thread
t1.start()
t2.start()

# wait for the threads to complete
t1.join()
t2.join()

finished_time=time.time()-t
print(finished_time)