import os
import glob
from typing import Optional, List

def find (directory: List[str], name: Optional[List[str]] = ['*'], type: Optional[str] = None, recursive: Optional[bool] = False) -> List[str]:
    for dir in directory:
        for n in name:
            pathname = os.path.join(dir, '**', n) if recursive else os.path.join(dir, n)
            paths = glob.glob(pathname, recursive=recursive)
    if type == 'f':
        return list(filter(lambda x: os.path.isfile(x), paths))
    elif type == 'd':
        return list(filter(lambda x: os.path.isdir(x), paths))

    return paths

if __name__ == "__main__": 
    print(find(['log'], name=['*.log'], recursive=True))
