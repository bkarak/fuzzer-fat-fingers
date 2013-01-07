out = 0
max_out = -1
max_times = []
 
for job in open('mlijobs.txt'):
    if "OUT" in job:
        out += 1
    else:
        out -= 1
    if out > max_out:
        max_out = out
        max_times = []
    if out == max_out:
        max_times.append(job.split()[3])
 
print "Maximum simultaneous license use is", max_out, "at the following times:"
for time in max_times:
    print " ", time