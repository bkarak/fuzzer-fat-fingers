import math
def zigzag(n):
    indexorder = sorted(((x,y) for x in range(n) for y in range(n)),
                    key = lambda (x,y): (x+y, -y if (x+y) % 2 else y) )
    return dict((index,n) for n,index in enumerate(indexorder))
    # or, in Python 3: return {index: n for n,index in enumerate(indexorder)}
def printzz(myarray):
    n = math.round(math.sqrt(len(myarray)))
    for x in range(n):
        for y in range(n):
                print "%2i" % myarray[(x,y)],
        print
 
printzz(zigzag(5))