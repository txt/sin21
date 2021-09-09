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

# Ranges

Avoid spurious distinctions!   
Build simpler models!     
Explain complex ideas, easier! Make models more ethical!     
Discretize!

<img  src="https://www.saedsayad.com/images/Binning_1.png">

Discretization offers volumes, regions, where conclusions  hold.  

- So you can say where your conclusions stop working
- Very useful or decision making    <br><img src="http://www.fao.org/3/w4343e/w4343e2r.gif" width=400>


e.g. can we divide `age` into thirds? (Q: why "3"? A: engineering judgement; i.e. guess).

     id age  dead?
     1  1    n
     2  10   n
     3  20   n
     -------------------- 1/3 rd
     4  40   y
     5  50   n
     6  60   n
     -------------------- 2/3 rd
     7  70   y
     8  80   y
     9  90   y
   
Some of the  thirds don't seem to matter.    

- unsupervised discretiation: 
  - equal frequency: percentile chops on N numbers (e.g. sqrt(N) of the numbers)
  - Cohen cuts:  small effect = .3\*standard deviation 
  - equal width: _(max - min)/B_ 
    - but how  to set _B_?
    - in the above  B=3).
- supervised:
  - sort the x-column
  - divide  top-down  (e.g. Fayyad-Irani) or combine bottom-up (chi-merge)
  - Fayyad-Irani (see [section 3.3](http://ai.stanford.edu/~ronnyk/disc.pdf))
    -  for all x, divides data in two (_V1,V2=above, below_),
    - compute variability in y-column in (_V1,V2=above,below_)
    - find the x point that  maximizes out certainty in  y (i.e. minimizes variability)
      - if y is numeric, use standard deviation sqrt(&sum;(x.i = mean(x)) / (N-1))
        - measures the "wriggle" around the mean
      - if y is symbolic, and symbols occur at frequency  f.1, f.2,...use entropy
        - -&sum; (f.i/N \* log2(f.i/N))
        - measures the work required to recreate the signal 
          -  _f.i/N_ = probability we want to find that  symbol
          - _log2(f.i/N)_ = effort to find "it" (using binary chop)
      - that cut point needs to minimize the expected value of variability _V_  before and  after
split: _V1,V2_
        - V1\*N1/N  +  V2\*N2/N
    - [Chi-merge](https://www.aaai.org/Papers/AAAI/1992/AAAI92-019.pdf) (ish)`
      - used unsupervised discretization to divide the data
        - me: divide on sqrt(N), ignore splits with less than .3\*standard deviation
      - combine adjacent splits, if combining them does not reduce variability
      - if  any  combinations, recurse 

For simple data sets Figure1 of [Douygherty et al. 1995](http://ai.stanford.edu/~ronnyk/disc.pdf)
  says that discretization can be very effective.

Zaidi  et al. offers rules about [when  it works](https://link.springer.com/content/pdf/10.1007/s10994-008-5083-5.pdf) :

- "Theorem 1 assures us that so long as the attribute independence assumption holds, and (other technical issues)
     discretization will result in naive-Bayes classifiers delivering the same probability estimates as would be obtained if the correct probability density function were employed."

Very effective: e.g..   [Fig3 of  the FFT  paper](https://arxiv.org/pdf/1803.05067.pdf)  was generated using
discretization.

Improve signal-to-noise ratio
-  Fitting a model to bins reduces the impact that small fluctuates in the data has on the model
-  Often small fluctuates are just noise. 
- Each bin "smooths" out the fluctuates/noises in sections of the data.

Discretization tells us what to ignore, lets us  ignore spurious  distinctions <br>
<img src="https://www.researchgate.net/profile/Wolfram-Schulte/publication/236644419/figure/fig2/AS:299463827574814@1448409148947/Results-of-discreting-the-diabetes-data-set-from-the-UCI-repository-see-Black-and-gray_W640.jpg">

Takes us  to some very simple, very effective inference loops
- discretize data into ranges
- score each  range
  - apply best range, recurse on surviving data . See [Fig.3](https://arxiv.org/pdf/1803.05067.pdf)
  - or, repeat, combine  the better  ranges into composite ranges . See [Fig.11](https://research.cs.queensu.ca/home/ahmed/home/teaching/CISC880/F10/papers/which_ASEJournal2010.pdf).

## Code (Chi-merge, ish)

Aside: I've coded a lot of discretizers and the following is the  simplest, most useful.

**ranges(xys :{{num,str}}, tiny :num=self:var()\*.3, ?enough :num=sqrt(N)): {range}**      

Make a new range when       

(1) there is enough left for at least one more range; and           
(2) the lo,hi delta in current range is not tiny; and     
(3) there are enough x values in this range; and        
(4) there is natural split here    

```lua
function ranges(xys, tiny, enough,         now,out,x,y)
   while width <4 and width<#xy/2 do width=1.2*width end --grow small widths
   now = Nums:new()
   out = {now}
   for j,xy in pairs(sort(xys,"x")) do
      x,y = xy[1],xy[2]
      if j < #xys - enough then -- (1)
         if x ~= xys[j+1][1] then -- (2)
             if now.n > enough then -- (3)
                if now.hi - now.lo > tiny then -- (4)
                     now=Nums:new()
                     out[ 1+#out ] = now end end end end
      now.xs.add(x)
      now.ys.add(y) end
   return prune(out) end
```

**prune(b4 :{{xs:Num,ys:Sym}}) :{{xs:Num,ys:Sym}}**       

Return a smaller version of `b4` (by subsuming ranges
that do not change the class distributions seen in `ys`)

```lua
function prune(b4,             j,tmp,n,a,b,cy)
   j, n, tmp = 1, #b4, {}
   while j<=n do
      a= b4[j]
      if j < n-1 then
         b= b4[j+1]
         cy= merge(a.ys, b.ys)
         if cy:var() <= (a.ys:var()*a.ys.n + b.ys:val()*b.ys.n) / cy.n then
             a= Nums(a.xs:merge(b.xs),   cy)
             j = j + 1 end end
      tmp[1+#tmp] = a
      j = j + 1
   end
   return #tmp==#b4 and tmp or prune(tmp) end
```
 
Symbol

```lua
function Sym:new(at, name)  
  return obj(self,"Sym",{
    n=0, name=name or "", at=at or 0,
    has={},mode=0,_most=0}) end

function Sym:var(     e,p,w)
  e= 0
  for _,v in pairs(self.has) do 
     p= v/self.n      -- probability of wanting it
     w= math.log(p,2) -- how hard to find it (via binary chop)
     e= e - p*w end
  return e end

function Sym:add(x, n)
  if x ~= "?" then
    n = n or 1
    self.n = self.n+ n
    self.has[x] = n + (self.has[x] or 0)
    if self.has[x] > self._most  then
      self._most, self.mode = self.has[x], x end end end

function Sym:merge(other)
  new = lst.copy(self)
  for k,n in pairs(other.has) do new:add(k,n) end
  return new end
```

Number

```lua
function Num:new(at, name)
   name= name or ""
   return obj(self,"Num",
      {some=Some:new(), name=name or "",at=at or 0, 
      n=0, mu=0, _m2=0, sd=0,
      lo= 1E32, hi= -1E32,
      w=name:find("-") and -1 or 1}) end

function Num:var() return self.sd end

function Num:add(x,      d)
   if x ~= "?" then
      self.some:add(x)
      self.n   = self.n + 1
      d          = x - self.mu
      self.mu = self.mu + d/self.n
      self._m2 = self._m2 + d*(x - self.mu)
      self.sd = (self._m2<0 or self.n<2) and 0 or (
                     (self._m2/(self.n-1))^0.5)
      self.lo = math.min(x, self.lo)
      self.hi = math.max(x, self.hi)   end end

function Num:merge(lst,         new)
   new = copy(self)
   for _,x in pairs(lst._all) do new:add(x) end
   return new end
```

```lua


