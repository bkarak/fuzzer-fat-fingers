def list_powerset(lst):
    # the power set of the empty set has one element, the empty set
    result = [[]]
    for x in lst:
        # for every additional element in our set
        # the power set consists of the subsets that don't
        # contain this element (just take the previous power set)
        # plus the subsets that do contain the element (use list
        # comprehension to add [x] onto everything in the
        # previous power set)
        result.extend([subset + [x] for subset in result])
    return result
 
# the above function in one statement
def list_powerset2(lst):
    return reduce(lambda result, x: result + [subset + [x] for subset in result],
                  lst, [[]])
 
def powerset(s):
    return frozenset(map(frozenset, list_powerset(list(s))))

def powersetlist(s):
    r = [[]]
    for e in s:
        print "r: %-55r e: %r" % (r,e)
        r += [x+[e] for x in r]
    return r
 
s= [0,1,2,3]    
print "\npowersetlist(%r) =\n  %r" % (s, powersetlist(s))