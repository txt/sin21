[home](/README.md)


## Hw3
Your task:

- Extend your csv reader from last week 
- Create  a `Sample` class
  - Sample = rows,cols where columns summarize data in rows.


To define the columns, take a look at row1 of
[weather](../data/weather.csv):
and  
[POM3a](../data/pom3a.csv) 
and 
[auto93](../data/auto93.csv). Note that:

- Some column headers contain ?
  -  all such columns should be ignored.
- Some column headers contain "!"
  -  This is the klass goal, if it exists.
- Some column headers start with upper case. 
  - This denotes columns of `Num`eric values
  - And all other columns are `Sym`bolic.
- Some column headers include "+" or "-". 
  0 This denotes goals whose values we want to maximize or minimize.

```lua
function isKlass(s)  return s:find("!") end
function isGoal(s)   return s:find("+") or s:find("-") or isKlass(s) end
function isNum(s)    return s:sub(1,1):match("[A-Z]") end
function isWeight(s) return s:find("-") and -1 or 1 end
function isSkip(s)   return s:find("?") end
```

So you need at least  4 classes: `Sample`, `Num`, `Sym`, and `Skip`  each with the method `:add(x)`.

- `Skip`'s `add` method does nothing.
- `Sym`'s `add` method updates counts of symbols seen so far, as well as tracking the `mode` (most frequent symbols).
- `Num`'s `add` method updates means and standard deviations
- `Sample`'s `add` method calls `add` on the columns (one add for each column).
   Note that when `add`ing to a `Sample`, there are two cases:
  - We are reading row1 (with all the names), so we must create the columns
  - We are reading subsequent rows, so we must update the column sumamriies (and store the new row).


(Asides: (1)`Samples` can be `cloned`; i.e. create a new `Sample` using the same row` as the original `Sample`.
(2) Don't make a `Row` class. Store rows as simple lists-- makes so much downstream processing so much simpler.)

Also, we are going to be sneaky and add in a non-parametric collector called `Some` that lets us do non-parametric
stuff. This a
[reservoir sampler](https://en.wikipedia.org/wiki/Reservoir_sampling) and is  great way to reasaon over 1,000,000s of numbers 
(just make the reservoir, say, 256 to 1024 and collect
a random sample).

## Details

Note the following is _pseudo code_ assembled from parts of my code. Not complete. May have errors.
And you'll have to work out instance creation and local attributes yourself (which is not hard).
For notes on  the language used here (Lua) see  [this cheat sheet](http://tylerneylon.com/a/learn-lua/).

```lua
function add(x,y)
  -- guess `y`  if value missing. do nothing if `x` is "don't care"
  if x ~= "?" then
    y = y or (type(x)=="number" and Num() or Sym())
    self.n = self.n + 1
    if self.some then self.some:add(x) end
    self:add1(x) end
  return y end

function adds(lst,y)
  -- return list, sumamrized into `y'.
  for _,x in pairs(lst) do y = add(x,y) end
  return y end
```

Here's `add` for `Skip`:

```lua
function Skip:add1(x) return x end
```

Here's `add` for `Num`:

```lua
function Num:add1(x       delta)
  if x < self.lo then self.lo = x end
  if x > self.hi then self.hi = x end
  delta = x - self.mu
  self.mu = self.mu + delta / self.n
  self.m2 = self.m2 + delta * (x - self.mu) 
  if self.n > 1 then 
    self.sd = (self.m2 / (self.n - 1))^0.5 end end  
```

Here's `add` for `Sym`:

```lua
function Sym:add1(x) 
  self.has[x] = 1 + (self.has[x] or 0)
  if self.has[x] > self.most  then
    self.most, self.mode = self.has[x], x end  end
```

Here's `add` for `Some`:

```lua
function Some:add1(x          pos) 
  -- if full, replace anything, picked at random
  if     #i._all < i.most     then pos=#i._all+1
  elseif rand() < #i._all/i.n then pos= math.floor(1+ rand()*#i._all) end 
  if pos then 
    #i._all[pos]=x
    i.sorted=false end end
```


Here's `add` for `Sample`:


```lua
function Sample:add(lst)
  if #(self.cols.names) > 0 then self:data(lst) else self:header(lst) end 
  return self
```

Note: Samples hold:
- all columns in `cols`, 
- the goals columns in `y` (and others in `x`)
- the klass column if it exists in `klass`,
- and the row1 stuff in `names`.
- Also, when we create columns, we tell them theircolumn name and position `at`.

```lua
function Sample:header(lst,       what,new,tmp)
  self.names=lst -- keep this around. Using for cloning
  for at,name in pairs(lst)  do
    what = isSkip(name) and Skip or (isNum(name) and Num or Sym)
    new  = what:new(at,name) 
    self.cols[1 + #self.cols] = new
    if not isSkip(name) then
      tmp= self[sGoal(name) and  "y" or "x"]
      tmp[ 1+#tmp ] = new
      if isKlass(name) then self.klass = new end end end 
  return lst end

function Sample:data(lst) 
  for _,col in pairs(self.cols) do 
    col:add(lst[col.at]) end -- update cols
  if self.keep then 
    self.rows[ 1 + #self.rows] = lst  end end -- new row

function Sample:read(f) 
  -- csv comes from hw1
  for row in csv(f) do self:add(row) end 
  return self end

function Sample:clone(inits)
  -- return a sample expecting the sample columns as receiver
  return adds(inits or {}, Sample:new():add(self.names))
```

--------------------------------

## Some support code tricks

### Non-parametric statistics

```lua
function Some:sd(p    a)
  return (self:per(.9) - self:per(.1)) / 2.56 end

function Some:per(p    a)
  -- percentile
  p= p or .5
  a= self:all()
  return a[math.max(1,math.floor(#a*p))] end

function Some:all()
  -- return the samples values, sorted
  if not i.sorted then table.sort(i._all) end
  i.sorted=true
  return i._all end


### Random Numbers

Is your random number generator platform independent? If not then
might I suggest soemthing simple like
the [Park-Miller randomization](http://www.cs.wm.edu/~va/software/park/park.html)?

```lua
Seed = 10013 -- beware. do not lose control of your seeds
function randi(lo,hi) return math.floor(rand(lo,hi)) end

function rand(lo,hi,     mult,mod)
  -- defaults to returning floats 0..1
  lo,hi = lo or 0, hi or 1
  mult, mod = 16807, 2147483647
  Seed = (mult * Seed) % mod 
  return lo + (hi-lo) * Seed / mod end 
```

### What to hand-in

To test all this, 

- add a `Sample` method called `fromFile(fileName)` that
reads 
[weather](../data/weather.csv):
and  
[POM3a](../data/pom3a.csv) 
and 
[auto93](../data/auto93.csv) 
and stores them in different `Sample`s.

Sort the rows of auto93.csv by the goal scores. Print the first and last 5 entries. This should print
something like the follow. Note that the first five cars weigh less, have more acceleration, and more
mpg than the last 5

```
"Cylinders"   "Displacement"   "Horsepower"   "Weight-"   "Acceleration+"   "Model"   "origin"   "Mpg+"}
{4             97               52             2130        24.6              82        2          40}
{4             90               48             2335        23.7              80        2          40}
{4             86               65             2110        17.9              80        3          50}
{4             90               48             1985        21.5              78        2          40}
{4             90               48             2085        21.7              80        2          40}

{8             454              220            4354        9                 70        1          10}
{8             440              215            4312        8.5               70        1          10}
{8             429              198            4952        11.5              73        1          10}
{8             383              180            4955        11.5              71        1          10}
{8             400              175            5140        12                71        1          10}
{8             455              225            4951        11                73        1          10}
```
For this to work, you need something that can sort on all the goals (in this case, weight, acceleration and mpg).
Welcome to the [Zitler](https://www.simonkuenzli.ch/docs/ZK04.pdf) continuous domination predicate:

```lua
function zitler(row1,row2,sample,     e,n,s1,s1,w,x,y,goals)
  goals = sample.y
  s1,s2,e,n = 0,0,2.71828,#goals
  for _,col in pairs(goals)  do
    w= col.weight -- -1 for minimize, +1 for maximize
    x= col:norm(row1[col.at]) -- normalize min..max to 0..1 
                             --  (so exponetiation dont explode)
    y= col:norm(row2[col.at]) -- btw, mu `Cols` know their column index
    s1 = s1 - e^(w * (x-y)/n) -- what-if #1: try going x to y
    s2 = s2 - e^(w * (y-x)/n) -- what-if $2: try going y to x
  end 
  return s1/n < s2/n end      -- row1 is better if it losses least.

```

