import sys

if len(sys.argv) == 1:
    print 'usage: python getRunTime.py [filename]+'
    exit()
    
for idx in range(1,len(sys.argv)):
    f = open(sys.argv[idx], 'r')
    
    total = 0.0
    for line in f:
        parts = line.split(',')
        try:
            total += float(parts[0])
        except:
            continue
        
    print sys.argv[idx] + '\t' + str(total)
