import sys

if len(sys.argv) == 1:
    print 'usage: python getRunTime.py [filename]+'
    exit()

files = []
for idx in range(1,len(sys.argv)):
    files.append(open(sys.argv[idx], 'r'))

# Trim high and low 1/3 outliers
trimSize = len(files)/3

# Skip header
for f in files:
    header = f.readline()

print header.strip() + ',' + ',cumulative,rate'

unmodTotal = 0
cuml = 0.0
inputCount = 0
for line in files[0].readlines():
    inputCount += 1
    res = line.strip().split(',')[0]

    res = [float(res)]
    for i in range(1, len(files)):
        temp = files[i].readline().strip().split(',')[0]
        res.append(float(temp))

    # Remove lowest and highest
    filtered = sorted(res)[trimSize:len(files) - trimSize]

    orig = sum(filtered)/len(filtered)

    cuml += orig

    runningRate = inputCount / cuml
    
    print str(orig) + ',' + str(cuml) + ',' + str(runningRate)


print 'Total interesting inputs: ' + str(unmodTotal)