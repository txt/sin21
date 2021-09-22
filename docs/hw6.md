<a name=top>
<a  href="https://git.io/sin21"><img  width=400 src="/docs/img/sin1.png"></a>       
<hr>
<p>
&nbsp;<a href="https://git.io/sin21">home</a> ::
<a href="https://github.com/txt/sin21/blob/master/docs/syllabus.md#top">syllabus</a> ::
<a href="https://github.com/txt/sin21/blob/master/docs/syllabus.md#timetable">timetable</a> ::
<a href="https://docs.google.com/spreadsheets/d/1n0zHiZlVYkLAEg5Lj1CVaLSEaeNy8iYjw8IMWYWs4Tk/edit?usp=sharing">groups</a> ::
moodle(<a href="https://moodle-courses2122.wolfware.ncsu.edu/course/view.php?id=3211">591</a>,
<a href="https://moodle-courses2122.wolfware.ncsu.edu/course/view.php?id=3211">791</a>) ::
video <a href="https://ncsu.hosted.panopto.com/Panopto/Pages/Sessions/List.aspx#folderID=a5998f03-01df-4c6c-91c1-ad80003f3c7c">tbd</a> ::
<a href="https://github.com/txt/sin21/blob/master/LICENSE.md#top">&copy; 2021</a>
<br>
<hr>

# HW6: Build an  FFT forest

In today's exciting episode you will learn how to generate a succinct, understandable rule that selects from best/worst regions in
a multi-objective space.

As a side-effect, you will build N models that throw themselves around the output space _N_ random times


## Review

Recall that at each level of the FFT we build a leaf and a sub-tree.
- A "1" leaf exits to the target
- A "0" leaf exists to NOT the target

E.g. here's a 0,1,1,1,0 tree:

```
if      cob <= 4 then false   # 0
else if rfc > 32 then true    # 1
else if dam > 0 then true     # 1
else if amc < 32.25 then true # 1
else    false                 # 0
```

Recall that a  tree of depth 4 is one member of a  forest of 2<sup>4</sup>=16 trees

Here's how to build one FFT tree. In the following, pay special addition to the word "leaf" and "tree":

- Score the ranges found in hw5 
  - Q1: how to model a  range? See below
  - Q2: how to score a range? See below.
- Sort the ranges, find the best and worst
- For a "1" tree, 
  - Build a "1" leaf from the _best_ range; i.e. find all the rows that match the _best_ range
  - Build a tree; i.e. a `Sample` for everything that is not _best_
  - Recurse on that Sample
- For a "0" tree
  - Build a leaf from the _worst_ range; i.e. find all the rows that match the _worst_ range
  - Build a tree; i.e. a `Sample` for everything that is not _worst_
  - Recurse on that Sample
- When recursing, if the current Sample has less than (say) 2\* sqrt(n) of the original tree
  - Build a 0 or 1 leaf as above 
  - Build a 1 or 1 leaf for the remaining  of the data (not note that this leaf is the opposite of the one before)

To build a forest of FFT trees

- Carry around an output list for all the trees
- As you go down the tree, carry with you the branch generated from the root to you
- At each level, 
   - Copy the branch generated from the root then recurse to build a "1" tree
   - Copy the branch generated from the root then recurse to build a "0" tree
- At the end, add the current branch to the output list.

## Example of an FFT forst
From auto93. Recall from before that the best results in auto93 were found in one small cluster. 
- Here, the 11110 tree (line3-line7) fails to find it since its first division eats up half the data, leaving worst stuff for later reasoning
- But the 00001 tree (line95-line99) finds i
```
     1  
     2  0
     3   1      if Cylndrs <= 4.0 then [2245.0, 16.2, 30.0] (208)
     4   1  elseif Cylndrs <= 6.0 then [3193.0, 16.2, 20.0] (87)
     5   1  elseif 73.0 <= Model <= 77.0 then [4220.0, 13.0, 10.0] (48)
     6   1  elseif Model >= 72.0 then [3955.0, 13.5, 20.0] (30)
     7   0  else   [4209.0, 11.5, 10.0] (25)
     8  
     9  1
    10   1      if Cylndrs <= 4.0 then [2245.0, 16.2, 30.0] (208)
    11   1  elseif Cylndrs <= 6.0 then [3193.0, 16.2, 20.0] (87)
    12   1  elseif 73.0 <= Model <= 77.0 then [4220.0, 13.0, 10.0] (48)
    13   0  elseif Hp >= 165.0 then [4382.0, 11.5, 10.0] (21)
    14   1  else   [3840.0, 13.5, 20.0] (34)
    15  
    16  2
    17   1      if Cylndrs <= 4.0 then [2245.0, 16.2, 30.0] (208)
    18   1  elseif Cylndrs <= 6.0 then [3193.0, 16.2, 20.0] (87)
    19   0  elseif Model <= 71.0 then [4209.0, 11.5, 10.0] (25)
    20   1  elseif 75.0 <= Model <= 78.0 then [4080.0, 13.2, 20.0] (29)
    21   1  elseif Model >= 73.0 then [4100.0, 13.2, 10.0] (36)
    22   0  else   [4274.0, 13.0, 10.0] (13)
    23  
    24  3
    25   1      if Cylndrs <= 4.0 then [2245.0, 16.2, 30.0] (208)
    26   1  elseif Cylndrs <= 6.0 then [3193.0, 16.2, 20.0] (87)
    27   0  elseif Model <= 71.0 then [4209.0, 11.5, 10.0] (25)
    28   1  elseif 75.0 <= Model <= 78.0 then [4080.0, 13.2, 20.0] (29)
    29   0  elseif Hp >= 155.0 then [4456.0, 12.5, 10.0] (18)
    30   1  else   [4042.0, 14.0, 20.0] (31)
    31  
    32  4
    33   1      if Cylndrs <= 4.0 then [2245.0, 16.2, 30.0] (208)
    34   1  elseif Cylndrs <= 6.0 then [3193.0, 16.2, 20.0] (87)
    35   0  elseif Model <= 71.0 then [4209.0, 11.5, 10.0] (25)
    36   0  elseif Model <= 73.0 then [4274.0, 12.5, 10.0] (33)
    37   1  elseif Model >= 76.0 then [3955.0, 13.7, 20.0] (34)
    38   0  else   [4457.0, 14.0, 10.0] (11)
    39  
    40  5
    41   1      if Cylndrs <= 4.0 then [2245.0, 16.2, 30.0] (208)
    42   1  elseif Cylndrs <= 6.0 then [3193.0, 16.2, 20.0] (87)
    43   0  elseif Model <= 71.0 then [4209.0, 11.5, 10.0] (25)
    44   0  elseif Model <= 73.0 then [4274.0, 12.5, 10.0] (33)
    45   0  elseif Model <= 76.0 then [4215.0, 13.5, 10.0] (20)
    46   1  else   [3900.0, 13.7, 20.0] (25)
    47  
    48  6
    49   1      if Cylndrs <= 4.0 then [2245.0, 16.2, 30.0] (208)
    50   0  elseif Cylndrs >= 6.0 then [3651.0, 14.3, 20.0] (187)
    51   1  else   [2950.0, 19.9, 30.0] (3)
    52  
    53  7
    54   0      if origin == 1 then [3365.0, 15.0, 20.0] (249)
    55   1  elseif origin == 3 then [2155.0, 16.4, 30.0] (79)
    56   1  elseif Hp <= 88.0 then [2188.0, 16.5, 30.0] (51)
    57   0  else   [2694.0, 14.5, 20.0] (19)
    58  
    59  8
    60   0      if origin == 1 then [3365.0, 15.0, 20.0] (249)
    61   1  elseif origin == 3 then [2155.0, 16.4, 30.0] (79)
    62   0  elseif Hp >= 88.0 then [2694.0, 15.5, 20.0] (24)
    63   1  elseif Dsplcemnt <= 97.0 then [2000.0, 16.0, 30.0] (28)
    64   0  else   [2511.0, 17.5, 30.0] (18)
    65  
    66  9
    67   0      if origin == 1 then [3365.0, 15.0, 20.0] (249)
    68   1  elseif origin == 3 then [2155.0, 16.4, 30.0] (79)
    69   0  elseif Hp >= 88.0 then [2694.0, 15.5, 20.0] (24)
    70   0  elseif Dsplcemnt >= 97.0 then [2220.0, 17.5, 30.0] (28)
    71   1  else   [2000.0, 16.0, 30.0] (18)
    72  
    73  10
    74   0      if origin == 1 then [3365.0, 15.0, 20.0] (249)
    75   0  elseif origin == 2 then [2246.0, 15.7, 30.0] (70)
    76   1  elseif 72.0 <= Model <= 77.0 then [2265.0, 16.5, 30.0] (29)
    77   1  elseif Model >= 78.0 then [2145.0, 16.2, 30.0] (44)
    78   0  else   [2130.0, 15.0, 30.0] (6)
    79  
    80  11
    81   0      if origin == 1 then [3365.0, 15.0, 20.0] (249)
    82   0  elseif origin == 2 then [2246.0, 15.7, 30.0] (70)
    83   1  elseif 72.0 <= Model <= 77.0 then [2265.0, 16.5, 30.0] (29)
    84   0  elseif Hp >= 88.0 then [2434.0, 14.5, 30.0] (17)
    85   1  else   [2020.0, 17.0, 30.0] (33)
    86  
    87  12
    88   0      if origin == 1 then [3365.0, 15.0, 20.0] (249)
    89   0  elseif origin == 2 then [2246.0, 15.7, 30.0] (70)
    90   0  elseif Model >= 80.0 then [2160.0, 16.2, 30.0] (34)
    91   1  elseif Dsplcemnt <= 85.0 then [1990.0, 18.6, 30.0] (14)
    92   0  else   [2279.0, 15.5, 30.0] (31)
    93  
    94  13
    95   0      if origin == 1 then [3365.0, 15.0, 20.0] (249)
    96   0  elseif origin == 2 then [2246.0, 15.7, 30.0] (70)
    97   0  elseif Model >= 80.0 then [2160.0, 16.2, 30.0] (34)
    98   0  elseif Dsplcemnt >= 97.0 then [2300.0, 15.5, 30.0] (27)
    99   1  else   [1975.0, 17.5, 30.0] (18)
```

## How to Model a Range

When I do discretization, I try to revurn all the information I need for subsequent processing  in a range object:

For example, here is some code from last week, extended for in that way:

```python
class Num
  def discretize(columnFromHere, sameColumnFromThere):
    i,j = columnFromHere, sameColumnFromThere
    ...
    best, rest = 1,0
    xys=[(good,best) for good in i._all] + [
         (bad, rest) for bad  in j._all]
    n1,n2 = len(i._all), len(j._all)
    iota = my.cohen * (i.var()*n1 + j.var()*n2) / (n1 + n2)
    bins = merge(unsuper(xys, len(xys)**my.bins, iota))
    if len(bins) > 1:
      for n,bin in enumerate(bins):
        yield o(at=i.at, name=i.txt, lo=bin.lo, hi=bin.hi, 
                best=  bin.y.has.get(best,0), bests = i.n,
                rest=  bin.y.has.get(rest,0), rests = j.n,
                first= n==0,                  last  = n==len(bins)-1)
```

Note the additional fields:
- _best_, _rest_ count how many rows are covered by one range 
- _bests_, _rests_ count the number of rows in here or there.
- _first_, _last_ tell is if these are the beginning or end of the ranges

Note also that first,last are not defined in Sym ranges:

```python
class Sym:
  def discretize(columnFromHere, sameColumnFromThere):
    i,j = columnFromHere, sameColumnFromThere
    for x in set(i.has | j.has): 
      yield o(at=i.at, name=i.txt, lo=x, hi=x, 
              best=i.has.get(x,0), bests=i.n,
              rest=j.has.get(x,0), rests=j.n,
              first=False,         last=False)
```
Here we set _lo_ to the same value as _hi_ and _first_a nd _last_ to False (cause they have no meaning).

As to matching or printing a range:

```python
   def match(i, bin, row):
    v=row.cells[bin.at]              # Q: where does `at` come from?
    if   v=="?"   : return True      # Q: what should we do for missing values
    elif bin.first: return v <= bin.hi
    elif bin.last : return v >= bin.lo
    else          : return bin.lo <= v <= bin.hi

  def show(i,bin):
    if   bin.lo == bin.hi: return f"{bin.name} == {bin.lo}"  # Q: how we detect symbolic ranges
    elif bin.first: return f"{bin.name} <= {bin.hi}"
    elif bin.last : return f"{bin.name} >= {bin.lo}"
    else          : return f"{bin.lo} <= {bin.name} <= {bin.hi}"
```

## Scoring

Given two spaces of size _bests_  and _rests_, the "best"
score maximizes for better things and the "worst" maximizes
for "other" things"

In the following, I raise the score to a power (_my.support=2_)
because of [rare events](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.365.9865&rep=rep1&type=pdf#page=6).

```python
  def value(i,rule, bin):
    s = i.my.support
    rules = o(plan    = lambda b,r: b**s/(b+r) if b>r else 0,  # good things to make you smile
              monitor = lambda b,r: r**s/(b+r) if r>b else 0,  # bad things to make your cry.
              novel   = lambda b,r: 1/(b+r))                   # Q: when would i select for "novel"?
    return rules[rule](bin.best/bin.bests, bin.rest/bin.rests)
  
  def values(i,rule,bins):
    bins = [(i.value(rule,bin), bin) for bin in bins]
    return sorted([(n,bin) for n,bin in bins if n > 0],key=first)
```

## Putting it all together

So in my FFT code, the "1" tree selects for the best _plan_ and the "0"  tree selects for the best _monitor_.

The following is called as follows

    branches=[]
    branch=[]
    FFt(sample,my,branch, branches) # "my" hilds all my config params
    return branches

And finally:

```python
class Fft(o):
  def __init__(i,all,my,branch,branches,stop = None, level=0):
    i.my       = my
    stop       = stop or 2*len(all.rows)**my.bins   # stopping coding
    # divide space in two, sort each half by the zitler score
    # so "best" is the better results
    best, rest = sorted([all.clone(rows) for rows in all.polarize()]) 
    # results of hw5's discretizations:
    bins       = [bin for xbest,xrest in zip(best.x, rest.x) 
                  for bin       in xbest.discretize(xrest,my)]
    bestIdea   = i.values("plan",   bins)[-1][1]  # best plan- thing to make us smile most
    worstIdea  = i.values("monitor",bins)[-1][1]  # best monitor- thing to make us cry most
    pre = "|.. " *level
    for yes,no,idea in [(1,0,bestIdea), (0,1,worstIdea)]: # build 2 trees
      leaf,tree = all.clone(), all.clone()
      for row in all.rows:
        (leaf if i.match(idea,row) else tree).add(row) # match the rows to leaf, tree
      branch1  = kopy(branch)  # Q: what happens if we do not copy the brach down to here?
      branch1 += [o(at=idea.at, lo=idea.lo, hi=idea.hi,
                          type=yes, txt="if "+i.show(idea)+" then", 
                          then=leaf.ys(), n=len(leaf.rows))]
      if len(tree.rows) <= stop:
        branch1  += [o(type=no, txt="  ",
                            then=tree.ys(), n= len(tree.rows))] # make a final leaf
        branches += [branch1]  # andd branch to bracnhes
      else:
        Fft(tree,my,branch1,branches,stop=stop,level=level+1)
```
