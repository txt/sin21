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

# Discretization

Cluster, sort the leaves by their value, discretize the data to 
find the difference between the best and worst cluster.

What to hand in: code that handles all the TODO items listed below.

## Clustering

TODO : Generate this output using auto93.csv
(and your results may differm slightly, due to random number differences).

```
|..  n=398 c=0.71
|.. |..  n=199 c=0.53
|.. |.. |..  n=99 c=0.42
|.. |.. |.. |..  n=49 c=0.25
|.. |.. |.. |.. |..  n=24 c=0.15
|.. |.. |.. |.. |.. |..  n=12    goals=[3264.0, 16.5, 20.0]
|.. |.. |.. |.. |.. |..  n=12    goals=[3139.0, 15.5, 20.0]
|.. |.. |.. |.. |..  n=25 c=0.27
|.. |.. |.. |.. |.. |..  n=12    goals=[2472.0, 15.5, 20.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[2401.0, 16.5, 20.0]
|.. |.. |.. |..  n=50 c=0.31
|.. |.. |.. |.. |..  n=25 c=0.19
|.. |.. |.. |.. |.. |..  n=12    goals=[3381.0, 18.2, 20.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[3233.0, 17.6, 20.0]
|.. |.. |.. |.. |..  n=25 c=0.38
|.. |.. |.. |.. |.. |..  n=12    goals=[3415.0, 15.8, 20.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[3035.0, 16.7, 20.0]
|.. |.. |..  n=100 c=0.35
|.. |.. |.. |..  n=50 c=0.22
|.. |.. |.. |.. |..  n=25 c=0.18
|.. |.. |.. |.. |.. |..  n=12    goals=[4140.0, 13.7, 20.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[3840.0, 13.9, 20.0]
|.. |.. |.. |.. |..  n=25 c=0.12
|.. |.. |.. |.. |.. |..  n=12    goals=[4380.0, 13.2, 10.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[4082.0, 13.5, 10.0]
|.. |.. |.. |..  n=50 c=0.25
|.. |.. |.. |.. |..  n=25 c=0.14
|.. |.. |.. |.. |.. |..  n=12    goals=[4456.0, 13.0, 10.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[3892.0, 12.5, 20.0]
|.. |.. |.. |.. |..  n=25 c=0.19
|.. |.. |.. |.. |.. |..  n=12    goals=[4464.0, 12.0, 10.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[4422.0, 11.0, 10.0]
|.. |..  n=199 c=0.58
|.. |.. |..  n=99 c=0.48
|.. |.. |.. |..  n=49 c=0.16
|.. |.. |.. |.. |..  n=24 c=0.08
|.. |.. |.. |.. |.. |..  n=12    goals=[2420.0, 15.0, 30.0]
|.. |.. |.. |.. |.. |..  n=12    goals=[1985.0, 16.9, 40.0]
|.. |.. |.. |.. |..  n=25 c=0.27
|.. |.. |.. |.. |.. |..  n=12    goals=[2515.0, 14.7, 30.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[2020.0, 18.2, 30.0]
|.. |.. |.. |..  n=50 c=0.2
|.. |.. |.. |.. |..  n=25 c=0.17
|.. |.. |.. |.. |.. |..  n=12    goals=[2164.0, 15.9, 30.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[2670.0, 15.5, 30.0]
|.. |.. |.. |.. |..  n=25 c=0.09
|.. |.. |.. |.. |.. |..  n=12    goals=[2490.0, 17.3, 30.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[2635.0, 16.0, 30.0]
|.. |.. |..  n=100 c=0.54
|.. |.. |.. |..  n=50 c=0.5
|.. |.. |.. |.. |..  n=25 c=0.25
|.. |.. |.. |.. |.. |..  n=12    goals=[2003.0, 17.5, 30.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[2489.0, 15.5, 20.0]
|.. |.. |.. |.. |..  n=25 c=0.46
|.. |.. |.. |.. |.. |..  n=12    goals=[2130.0, 17.5, 30.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[2265.0, 15.5, 20.0]
|.. |.. |.. |..  n=50 c=0.29
|.. |.. |.. |.. |..  n=25 c=0.16
|.. |.. |.. |.. |.. |..  n=12    goals=[2694.0, 15.5, 20.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[1963.0, 15.5, 30.0]
|.. |.. |.. |.. |..  n=25 c=0.31
|.. |.. |.. |.. |.. |..  n=12    goals=[2950.0, 15.9, 30.0]
|.. |.. |.. |.. |.. |..  n=13    goals=[2130.0, 15.8, 40.0]
```

### Notes

Shown above is a cluster tree (technically speaking, a "dendogram")
that you generated from last time. Recall that at each level, you found distant points
then seperated the data on the median distance between the points.

In this print out of the tree, for non-leaves, I show 

- `n` :the size of the rows and the distance
- `c` : the distance between the two distant points

Note that `c,n` decrease as I go down the tree (why?).


For the leaves, I also show the median performance scores (Lbs-, Acc+, Mpg+). In the above, where is the best
and worst cluster?

## Sorting the leaves

TODO : print out this sort order for the leaf clusters 
(and your results may differm slightly, due to random number differences).

```
#Lbs-,   Acc+, Mpg+


[3264.0, 16.5, 20.0]  <== worst end
[3139.0, 15.5, 20.0]
[2472.0, 15.5, 20.0]
[2401.0, 16.5, 20.0]
[3381.0, 18.2, 20.0]
[3233.0, 17.6, 20.0]
[3415.0, 15.8, 20.0]
[3035.0, 16.7, 20.0]
[4140.0, 13.7, 20.0]
[3840.0, 13.9, 20.0]
[4380.0, 13.2, 10.0]
[4082.0, 13.5, 10.0]
[4456.0, 13.0, 10.0]
[3892.0, 12.5, 20.0]
[4464.0, 12.0, 10.0]
[4422.0, 11.0, 10.0]
[2420.0, 15.0, 30.0]
[1985.0, 16.9, 40.0]
[2515.0, 14.7, 30.0]
[2020.0, 18.2, 30.0]
[2164.0, 15.9, 30.0]
[2670.0, 15.5, 30.0]
[2490.0, 17.3, 30.0]
[2635.0, 16.0, 30.0]
[2003.0, 17.5, 30.0]
[2489.0, 15.5, 20.0]
[2130.0, 17.5, 30.0]
[2265.0, 15.5, 20.0]
[2694.0, 15.5, 20.0]
[1963.0, 15.5, 30.0]
[2950.0, 15.9, 30.0]
[2130.0, 15.8, 40.0] <== best end
```

### Notes

Here is a sort of those leaves using something called the Zitler predicate. Note that the worse
leaves have most wieght and least acceleration and miles per hour,


The Zitler predicate is a way to trade off between competing concenrs.
When dealing with 1 goal, a 
simple &lt; function can rank     goal value.
 But for
 multiple-goal
reasoning, examples  must be   trade-off       across many goals values/

_Binary domination_  
says _x_ is better than _y_
 if _x_ has at least one better goal value 
 (and zero worse goal values) than _x_.
Note that to compute that, you need to know if we are minimizing or maximizng goals (which is what the
_w_ instance variable models: -1,1 = minimize, maximize).

For more three or more goals, binary domination
 has trouble
   distinguishing examples 
[as shown in this link's Table8](https://fada.birzeit.edu/bitstream/20.500.11889/4528/1/dcb6eddbdac1c26b605ce3dff62e27167848.pdf)
In that case,
  Zitler's [continuous domination predicate~\cite{zitzler2004indicator}  is recommended.

  Continuous domination extends
binary domination by summing 
  the actual difference in   goal scores.  

For rows _i,j_ have _n_  goals variables (each of which has been normalized
 0..1, min..max
 Zilter says one individual is better than the other
 if 

- the mean loss moving from one to the other
- is less than the mean loss moving from the other to you:

```python
class Row(o):
  "Data: store rows"
  def __init__(i,lst,sample): 
     i.sample,i.cells, i.ranges = sample, lst,[None]*len(lst)

  def __lt__(i,j):
    "Does row1 win over row2?"
    loss1, loss2, n = 0, 0, len(i.sample.y)
    for col in i.sample.y:
      a   = col.norm(i.cells[col.at])
      b   = col.norm(i.cells[col.at])
      loss1 -= math.e**(col.w * (a - b) / n)
      loss2 -= math.e**(col.w * (b - a) / n)
    return loss1 / n < loss2 / n
```

I implement Zilter and a sort function on a `Row` object. That means that I can sort the leaves by:

- Finding the mid values for each leaf;
- Building one fake row per mid
- Sorting the leaves by sorting the mids:

```python
class Sample(o):
  "Data: store rows and columns"
  def __init__(i,my, inits=[]): 
    "Creation"
    i.cols, i.rows, i.x, i.y, i.my = [],[],[],[], my
    [i.row(init) for init in inits]

  def __lt__(i,j):
    "Sort tables by their mid values."
    return  Row(i.mid(),i) < Row(j.mid(), j)
```

## Discretization

TODO : generate something like the following
(and your results may differ slightly, due to random number differences).

Suppose we cluster down to some small size (say, a dozen items or so per cluster).
Now we 
seek the difference between the _best_ and rorst cluster (called _rest_).
We will only endorse
nuneric ranges that change the distribution of  _best,rest_. 

At the end of each print out I show the counts of each _best_ and _rests_. Please
confirm that the _best_,_rest_ numbers change (a lot) as I jump ranges).


```
{:at 1, :name Dsplcemnt, :lo 85.0, :hi 91.0, :best 4, :rest 0}
{:at 1, :name Dsplcemnt, :lo 97.0, :hi 171.0, :best 3, :rest 1}
{:at 1, :name Dsplcemnt, :lo 198.0, :hi 231.0, :best 0, :rest 5}

{:at 2, :name Hp, :lo 65.0, :hi 67.0, :best 4, :rest 0}
{:at 2, :name Hp, :lo 67.0, :hi 95.0, :best 3, :rest 2}
{:at 2, :name Hp, :lo 95.0, :hi 110.0, :best 0, :rest 4}

{:at 5, :name Model, :lo 74.0, :hi 75.0, :best 0, :rest 5}
{:at 5, :name Model, :lo 75.0, :hi 80.0, :best 7, :rest 1}

{:at 6, :name origin, :lo 1, :hi 1, :best 0, :rest 6}
{:at 6, :name origin, :lo 3, :hi 3, :best 7, :rest 0}
```

(Aside: cylinders does not appear here. Why?)

As a sanity check, I printed out some values from _best,rest_ and confirmed
the counts seen above (TODO : you need to do the same).

```
best [4.0, 86.0, 65.0, 2110.0, 17.9, 80.0, '3', 50.0]
best [4.0, 86.0, 65.0, 2019.0, 16.4, 80.0, '3', 40.0]
best [4.0, 91.0, 67.0, 1850.0, 13.8, 80.0, '3', 40.0]
best [4.0, 97.0, 67.0, 2145.0, 18.0, 80.0, '3', 30.0]
best [4.0, 85.0, 65.0, 2020.0, 19.2, 79.0, '3', 30.0]
best [4.0, 107.0, 72.0, 2290.0, 17.0, 80.0, '3', 30.0]
best [4.0, 108.0, 75.0, 2265.0, 15.2, 80.0, '3', 30.0]

rest [6.0, 171.0, 97.0, 2984.0, 14.5, 75.0, '1', 20.0]
rest [6.0, 198.0, 95.0, 3102.0, 16.5, 74.0, '1', 20.0]
rest [6.0, 225.0, 95.0, 3785.0, 19.0, 75.0, '1', 20.0]
rest [6.0, 225.0, 95.0, 3264.0, 16.0, 75.0, '1', 20.0]
rest [6.0, 231.0, 110.0, 3039.0, 15.0, 75.0, '1', 20.0]
rest [6.0, 225.0, 105.0, 3613.0, 16.5, 74.0, '1', 20.0]
```

### Notes:

This was done via 

- unsupervised discretization (that divided the columns into chunsk of size _sqrt(N)_
- supervised merging (that combined ranges that do not change  class variability--- and note that our "classes"
  here are _best,rest_)


Discretizing symbolic ranges (like "origin") is simple. In the following
code, we assume some disctinary storing symbol counts.
e.g. 3 apples and 2 graphs becomes 

     i.has = dict(apples=3,grapes=2)


In the following, we assume that leaves are expressed as `Samples`,
samples have columns, and we seek the delta between _i=column[n]_ in _best_ and 
_j=column[n]_ in _rest_. Also, we only discertize the `x` columns (why)?



```python

def demo():
  s=Sample(my).load(f)
  clusters = sorted(s.cluster())
  worst, best = clusters[0], clusters[-1] # as done above
  #------------------------------------
  # now explore x-columns with same index in good,bad
  for good,bad in zip(best.x,worst.x): 
    for d in  good.discretize(bad, my):
       print(d)

class Sym:
   def discretize(i,j,_):
    "Query: `Return values seen in  i` is good and `j` is bad"
    for x in set(i.has | j.has): # for each key in either group
      yield o(at=i.at, name=i.txt, lo=x, hi=x, 
                best= i.has.get(x,0), rest=j.has.get(x,0))

class o:
  """`o` is just a class that can print itself (hiding "private" keys)
  and which can hold methods."""
  def __init__(i, **d)  : i.__dict__.update(d)
  def __repr__(i) : return "{"+ ', '.join( 
    [f":{k} {v}" for k, v in i.__dict__.items() if  k[0] != "_"])+"}"

```
(Aside: we will need merge later. Lets just skip over that for now).

Discretizing numbers is a little trickier:

```python
  def discretize(i,j, my):
    "Query: `Return values seen in  i` is good and `j` is bad"
    best, rest = 1,0
    # list of (number, class)
    xys=[(good,best) for good in i._all] + [ (bad, rest) for bad  in j._all]
    #
    # find a minimum break span (.3 * expected value of standard deivation)
    n1,n2 = len(i._all), len(j._all)
    iota = my.cohen * (i.var()*n1 + j.var()*n2) / (n1 + n2)
    #
    # all the real work is in unsuper and merge... which is your problem
    ranges = merge(unsuper(xys, len(xys)**my.bins, iota))
    # 
    if len(ranges) > 1:  
      for r in ranges:
        yield o(at=i.at, name=i.txt, lo=r.lo, hi=r.hi, 
                best= r.y.has.get(best,0), rest=r.y.has.get(rest,0))
```
In the above code:

-  What is the point of `len(ranges)>1`?
   - Hint: this conditional is why `Cylinders` did not appear in the above print outs.
- The final line's call to e.g. `r.y.has.get(best,0)` is a little arcane
   - The intent here, which you can code differently, 

<img align=right width=300 
        src="https://miro.medium.com/max/1400/1*IZ2II2HYKeoMrdLU5jW6Dw.png">
By the way, in the above `.var()` computes the standard deviation of a sorted
list.
    As well know,  plus or minus (1,2) sd is (66%,95%) of the area 
    under the normal curve.  Another number of interest is that  plus or 
    minus 1.28 sd is 90% of the mass.  This means that one standard 
    deviation is 90% of the mass divided by (1.28*2)=2.56. Hence,
    to compute something analogous to sd from any distribution, 
    sort it and look at the 90th and 10th percentile. <br clear=all>

```
def var(i): return (i.per(.9) - i.per(.1)) / 2.56
```

What you have to write is `unsuper` and `merge`

- Notes on `Unsuper` 
  - It cannot break ranges uness the i-th+1 value is different to the i-th value
  - It cannot  break unless the break contains more than `iota` items
  - It cannot break unless the max and min value in that break differ by more than `sqrt(N)`
    of all the items.
  - It cannot break unless there are enough items (`sqrt(N)`) after the break (so we can break
    some more, latter)
- Notes on `merge`
  - Merge looks at _item[n]_ and _item[n+1]_ in the ranges found by _unsuper_
  - If these two adhacent items are "dull" then we merge then, and jump on to look at _n+2_ and _n+3_.
  - If they are not dull, then _item[n]_ gets added to a _tmp_ output list and we jump on to look
    at _n+1_ and _n+2_
  - If any merges are made, then we call _merge(tmp)_ to see if the merged ranges can be further merged.
  - Else, we return the original ranges.

As to what "dull" means, if the variability of a merge is about the same as before the merge,
then we combine the two items:

```python
  a = b4[j]
  if j < len(b4) - 1:
    b = b4[j+1]
    cy = a.y.merge(b.y)
    if cy.var()*.95 <= (a.y.var()*a.n + b.y.var()*b.n)/(a.n + b.n):
       # then merge a,b
```

Note that I use a `Sym` instance to count the symbols and computer the variance
and do the merging (which explans the  arcane code shown above).

```python
class Sym:
  def merge(i,j):
    "Copy: merge two symbol counters"
    k = Sym(n=i.at, s=i.txt)
    for x,n in i.has.items(): k.add(x,n)
    for x,n in j.has.items(): k.add(x,n)
    return k

  def var(i):
    "Query: variability"
    return - sum(v/i.n * math.log2(v/i.n) for v in i.has.values())
```

