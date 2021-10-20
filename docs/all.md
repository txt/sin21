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

# Everything

Before your very yes, a synthesis of data mining, optimization, and theorem proving. All from
one equation


   Y = F(X)

The rows of a spreadsheet are a `sample` of examples about some effect (which we call the function `F`). 
Some of those columns
are inputs `X` and outputs `Y` which are also called:

- the independent and dependent variables (for `X` and `Y` respectively);
- the observable and controllable (the `X` values) and their labels (the `Y` values).

Several  operations on the above are of interest: _generate_, _group_, _contrast_, _guide_:

## Generate

Generating `X` values is usually easier than getting the `Y` labels by e.g.:

- e.g. just go write down the coors of the car in the street outside.
- e.g. some randomized grammar-based generation (e.g. fuzzing, product-lines)

That said "easier" may not mean "easy":
-  If you generating from some grammar, need background knowledg4 on what are valid terms
- If taking ata from some pre-xisting log, there is much that is needed between getting the raw 
data and running the leaners; e.g. 
["model training" from Figure1](https://www.microsoft.com/en-us/research/uploads/prod/2019/03/amershi-icse-2019_Software_Engineering_for_Machine_Learning.pdf#page=2),  
you might spend four hours per week in "model training" and days per week in all the rest.
- If are you genereting form somace background kowledge with many cosntraints
  then special tools (e.g. theorem provers) may be needed to generate that data.

However hard it is to get `X` values, generating `Y` values can be even hard:

- e.g. you may know the color of cards but to know the mainance cost of differen  brands, you ahve to get access behind coproate firewalls to the private records of different car companeies 
- e.g. you may not how many lines of code are in a github project, but you may not know the cost of making changes to that code.

Worse yet, even if `y` vales are readily available, [they are often wrong](https://arxiv.org/pdf/2108.09847.pdf):

- We have [done work](https://arxiv.org/pdf/2108.09847.pdf)
manually reading and labelling 22,500+ commits n  large set of Github projects. That work required 175
person-hours (approximately nine weeks), including cross-checking
among labellers. 
- Due to the labor-intensive nature of the process,
researchers often reuse datasets labelled from previous studies. While this
practice allows researchers to rapidly test new methods, it leaves the
possibility for any labelling mistake to propagate to other related
works. In fact, iin some work explore technical debts identification, before reusing prior
work’s data, [Yu et al.](https://arxiv.org/abs/2002.11049) discovered that more than 98% of
the false positives were actually true positives, casting doubt on
work that used the original dataset. 

- Generate the `x,y` data;
- Group the sample into sub-regions (eg; clustering, decision, rule learning; naive bayes
  - E.g. cluster similar items together (using the `x` values;
  - E.g. divide the data according to some class value ;
  - E.g. sort the data using (say) the `Y` values, then break that sort into sub-regions (e.g
    the 10% ebst ad the 90% rest).
- Contrast (planning, anomaloy detection, optimziation)
- Guide (use model built so far to inform what to do next: actiev elarning,s equentioal model optimization)
- Reduce (focus on msot relevant data. Fayola, LACE. 
- TUne (hyperparameter optimziearion).


- **Divide** the sample into regions of interest:
  - When those decisions do not mention `Y`, that is called unsupervised learning, also
    known as clustering.
  - Supervised learning, predicts how certain `x` values can geneated partocular `y` values.
    - If `Y` is a symbol, this might be called classification.
    - If `Y` is some number, this might be called regression.
    - If `Y` is multiple numbers (i.e. we have multiple goals) this is called multi-regressions
  - Clustering and regression and classification algorithms tell you ``what is''
    - Planners and optimizers (discussed next) tell us ``what to do''
- **Find changes** that move you from one region to another
  - This is called optimization or planning
  - If we have preference knowledge about `y` (e.g. what to minimize or maximize) then
      this might become an optimziation problem 
      - Classifiers and regression algorthims predict "what is" and  optimziers  tell you "what to do" 
      - To say that another way, regression and classification mke predictions about points within the
        sample, while optitimzers
on the other hand, shows how what `x` values link to which `Y`
- 
- sample generation. This can be done many ways including
    logging some real-world pehnomina, or aking humans for examples, or
   running some model. 


commercial peole might spend four per week in 
in the domain.
BuBut running the model `f` can be slow 
Samples, by definition
do not cover all examples. Hence the bah viz our of `f` might be different on the `sampled` data
and any subsequent `test` data. So:

- Rule1: do not test `f` on the sample used to generate `f`.
- Rule2: rather, to check the generality of `f`, try assessing it on data from outside the sample.

For example, to perform 25 generality checks, use _cross-validation_.
Shuffle the sample (say) five times, each time dividing into
(say)five bins.  
Then learn `f`  on four of those bins (the _training_ data), 
then test on the fifth bin (the _test_ data).
If that is too slow, then try _temporal validation_. That is,
sort the sample, somehow (e.g. randomly; e.g. by the data generation date) then
walk over the sort, training on the first X% then testing on some fixed number of further examples.
However you do it:

- Rule3: do not test `f` on a single sample. 
- Rule4: apply statistical effect size and signinficance tests to check those results.

(Significance statistics check if two populations can are distinguishable.
Effect size statistics check if some is different by an "interesting" amount. E.g. the `cliffsDelta`
and `bootstrap`  below).

when looking at the results of that test, use distri

 over the sort training on all samples up this point, then testing for a fixed number  this fives us 25 experiments  of how 

- Rule2: check the performance _epsilon_ across different rain and test sets. Do not bother exploring
  so-called improvements that change performance by less than espislon.

clustering repeated structured. many x. manifold

notes on that material.
In this paper, data are tables with rows and columns.
Columns are also known as features, attributes, or variables.
Rows contain multiple X, Y features where X are the
independent variables (that can be observed, and sometimes
controlled) while Y are the dependent variables (e.g. number
of defects). When Y is absent, then unsupervised learners
seek mappings between the X values. For example, clustering algorithms find groupings of similar rows (i.e. rows with
similar X values).

Usually most rows have values for most X values. But
with text mining, the opposite is true. In principle, text
miners have one column for each work in text’s language.
Since not all documents use all words, these means that the
rows of a text mining data set are often “sparse”; i.e. has
mostly missing values.

- When `y` is present and there is only one of them (i.e.
`|y|` = 1) then supervised learners seek mappings from the X
features to the Y values. For example, logistic regression tries
to fit the X, Y mapping to a particular equation.
When there are many Y values (i.e. |Y | > 1), then
another array W stores a set of weights indicating what
we want to minimize or maximize (e.g. we would seek
to minimize Yi when Wi < 0). In this case, multi-objective
optimizers seek X values that most minimize or maximize
their associated Y values. So:

- Clustering algorithms find groups of rows;
• and Classifiers (and regression algorithms) find how those
groups relate to the target `Y` variables;
-  and Optimizers are tools that suggest “better” settings
for the X values (and, here, “better” means settings that
improve the expected value of the `Y` values).

Apart from `W`, `X`, `Y` , we add `Z`, the hyperparameter settings
that control how learners performs regression or clustering.
For example, a k-neighbors algorithm needs to know how
many nearby rows to use for its classification (in which case,
that `k ∈ Z)`. Usually the `Z` values are shared across all rows
(exception: some optimizers first cluster the data and use
different `Z` settings for different clusters).

Two important detail not discussed above are feature
engineering and how to select performance metrics. These algorithms are used to “massage” data
prior to clustering or classification or optimization. For
example, the LDA pre-processor is a text
mining pre-processor that finds topics; i.e. words that often
occur together within the same paragraph. Topics usually
occur at exponentially decreasing frequency; i.e. , a dozen
or so topics might cover most of the document space. Later
in this paper, we will (a) replace sparse raw text mining data
with a non-sparse “topics matrix” comprising one column
per topics and rows showing how much each document
matches each topic; then (b) run a simple learner over this
non-sparse matrix.

## Appendix

```lua
local same,cliffsDelta,bootstrap
local Num=require"num"

-- **cliffsDelta(xs:number+, ys:number+, the:table)**   
function same(xs,ys, the)
  if #xs > the.sames then xs = shuffle(xs, the.sames) end
  if #ys > the.sames then ys = shuffle(ys, the.sames) end
  return cliffsDelta(xs,ys,the) and bootstrap(xs,ys, the) end

-- **cliffsDelta(xs : number+, ys : number+, the : table)**    
-- Non parametric effect size test (i.e. are two distributions
-- different by more than a small amount). Slow for large lists
-- (hint: sub-sample large lists).  Thresholds here set from
t 
-- top of p14 of  https://bit.ly/3m9Q0pP .  0.147 (small), 0.33
-- (medium), and 0.474 (large)
function cliffsDelta(xs,ys,the,       lt,gt)
  lt,gt = 0,0
  for _,x in pairs(xs) do
    for _,y in pairs(ys) do
      if y > x then gt = gt + 1 end
      if y < x then lt = lt + 1 end end end
  return math.abs(gt - lt)/(#xs * #ys) <= the.cliffs end

-- **bootstrap(y0 : num+, z0 : num+, the : table)**    
-- Non parametric "significance"  test (i.e. is it possible to
-- distinguish if an item belongs to one population of
-- another).  Uses a sampling with replacement. Warning: very
-- slow for large populations. Consider sub-sampling  for large
-- lists. Also, test the effect size (and maybe shortcut the
-- test) before applying  this test.  From p220 to 223 of the
-- Efron text  'introduction to the boostrap'.
-- https://bit.ly/3iSJz8B Typically, conf=0.05 and b is 100s to
-- 1000s.
-- Translate both samples so that they have mean x, 
-- The re-sample each population separately.
function bootstrap(y0,z0,the,     x,y,z,xmu,ymu,zmu,yhat,zhat,tobs,n)
  x, y, z, yhat, zhat = Num:new(), Num:new(), Num:new(), {}, {}
  for _,y1 in pairs(y0) do x:add(y1); y:add(y1)           end
  for _,z1 in pairs(z0) do x:add(z1); z:add(z1)           end
  xmu, ymu, zmu = x.mu, y.mu, z.mu
  for _,y1 in pairs(y0) do yhat[1+#yhat] = y1 - ymu + xmu end
  for _,z1 in pairs(z0) do zhat[1+#zhat] = z1 - zmu + xmu end
  tobs = y:delta(z)
  n = 0
  for _= 1,the.bootstrap do
    if adds(samples(yhat)):delta(adds(samples(zhat))) > tobs 
    then n = n + 1 end end
  return n / the.bootstrap >= the.conf end

-- **function scottKnow(nums:_num+_, the:_options_)**   
-- Do a top-down division of the `Num`s  in `nums`.
-- Divide  at the cut that maximizes  the  difference between
--  the  mean before and  after the cut. Stop cutting if
-- the top halves are statistically indistinguishable. 
function scottKnot(nums,the,      all,cohen)
  local mid = function (z) return z.some:mid() end

  local function summary(i,j,    out)
    out = copy( nums[i] )
    for k = i+1, j do out = out:merge(nums[k]) end
    return out end 

  local function div(lo,hi,rank,b4,       cut,best,l,l1,r,r1,now)
    best = 0
    for j = lo,hi do
      if j < hi  then
        l   = summary(lo,  j)
        r   = summary(j+1, hi)
        now = (l.n*(mid(l) - mid(b4))^2 + r.n*(mid(r) - mid(b4))^2
              ) / (l.n + r.n)
        if now > best then
          if math.abs(mid(l) - mid(r)) >= cohen then
            cut, best, l1, r1 = j, now, copy(l), copy(r) 
    end end end end
    if cut and not l1:same(r1,the) then
      rank = div(lo,    cut, rank, l1) + 1
      rank = div(cut+1, hi,  rank, r1) 
    else
      for i = lo,hi do nums[i].rank = rank end end
    return rank end 

  table.sort(nums, function(x,y) return mid(x) < mid(y) end)
  all   = summary(1,#nums)
  cohen = all.sd * the.iota
  div(1, #nums, 1, all)
  return nums end

-- --------------
return {same=same, cliffsDelta=cliffsDelta, bootstrap=bootstrap} 

```
