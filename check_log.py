import re
import sys

import find

logs = find.find(['log'], name=['*.log'], type='f', recursive=True)

errors = 0

for log in logs:
    f = open(log, encoding='utf-8', mode='r')
    head = f.readline()
    second = f.readline()
    if not re.search(r'^#\s.*vsim\s', head) is None and not re.search(r'^#\sStart\stime:\s\d+:\d+:\d+\s', second) is None:
        foot = f.readlines()[-1]
        m = re.search(r'^#\sErrors:\s(\d+),\sWarnings:\s(\d+)', foot)
        errors += int(m.group(1))

print(errors)
sys.exit(errors)
