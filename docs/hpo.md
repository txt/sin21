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


# Hyperparameter Optimisation

Supervised learners try to build some function `f` that can map `x` into `y`

     y = f(x)

- `x` can be one or more values that may be numeric or symbolic
- For regression and classification, `y` is a single value (numeric or symbolic, respectively).
- For multi-objective optimization, `y` can have multiple values.

The learner can have multiple control parameters, called hyper-parameters:

- For example, if learning a classification from the k-th nearest  neighbors...
- ... we make conclusions by combining (somehow) the `k`-the nearest items (where `near` is defined by some distance function) so the hyper-parameter are 
- `k` (obviously) 
- the combination function (mean? mode? weight closer items more than those furtger away? etc)
- the distance function. E.g. Euclidan distances    
  d=(&sum; (x-y)<sup>2</sup>)<sup>1/2</sup>  generalizes to      
  d=(&sum; (x-y)<sup>p</sup>)<sup>1/p</sup>      
   where `p` is a hyper-parameter 
  - p=1: Manhattan (city block) distance
  - p=2: standard Euclidean distance
  - p goes to &infty; is the  Chebyshev distance  (the distance between anything is the distance of the greatest separation of any attribute) 
     
![image](https://user-images.githubusercontent.com/29195/134363838-694ffcab-1951-4e1b-983a-820d0ceb466a.png)

[Aggawral etc al.] argue that the _larger_ the dimensions, the _smaller_ you want p (e.g. p=1)
- Strangely, I've found cases where [p=3](https://github.com/timm/lean/blob/master/src/knn.lua#L76-L77) was best. Go figure. 
- Guess you have to run experiments to work out what works best for your own data.

Warning: 
searching for the right hyper-parameters can take  a long search. 

- [Section 3](http://menzies.us/pdf/11teak.pdf) 
  lists more than 17,000 ways to configure nearest neighbor seen in the recent SE literature.
- When you combine all the learner options with all the pre-processing options (how many bins? What _iotoa_ is enough to distinguish two ranges? etc)
  then you can be faced with billions (or more) options.
  (see  [Table1](https://arxiv.org/pdf/1902.01838.pdf)  lists the

## Hyperparameter Optimization: Grid Search

For each option add a nested for loop to spin over the option space.

Benefits:

- Grid search is simple to implement and parallelization is trivial;
- Grid search (with access to a compute cluster) typically finds a better model
- Grid search is reliable in low dimensional spaces (e.g., 1-d, 2-d).
- Implemented in many tools (e.g.t eh CARET package)

Warning: when dealing with more than 2 dimensions

- Really slow
- Can be [surprisingly ineffective](https://www.jmlr.org/papers/volume13/bergstra12a/bergstra12a.pdf).
  -  looking at several relatively similar data sets (from different distributions) shows us that different data sets need very different hyperparameters
  -  A grid with sufficient granularity to optimizing hyper-parameters for all data sets must consequently be inefficient for each individual data set because of the curse of dimensionality
     - the number of wasted grid search trials is exponential in the number of search dimensions that turn out to be irrelevant for a particular data set

## Hyperparameter Optimization: Random Search

If we want near-optimal (as apposed to the-optimal) then a few random probes can be remarkably effective.

What does "near-optimum" mean? When is some number indistinguishably  close  to "optimum"?

- [Rosenthal et al.](https://www.google.com/books/edition/The_Handbook_of_Research_Synthesis/p-aFAwAAQBAJ?hl=en&gbpv=1&pg=PA231&printsec=frontcover)
- discuss different methods for asserting that
one result is with some small effect of another (i.e. it is “close to”). 
- They list
dozens of effect size tests that divide into two groups: 
  - the `r` group 
based on the Pearson correlation coefficient; 
  - or the `d` family that is based on
absolute differences normalized by (e.g.) the size of the standard deviation.
    - e.g. two numbers are essentially the same if they differ by less than &delta;\*&sigma; (the standard deviation)

Since 
[Rosenthal et al.](https://www.google.com/books/edition/The_Handbook_of_Research_Synthesis/p-aFAwAAQBAJ?hl=en&gbpv=1&pg=PA231&printsec=frontcover)
 comment that “none is intrinsically better than the other”, lets just use the simplest:

- The [Sawilowsky](https://digitalcommons.wayne.edu/cgi/viewcontent.cgi?article=1536&context=jmasm)
  paper from  2009 has 1100 citations.
- They asserts that “small” and “medium” effects can be measured using &delta;=0.2 and &delta;=0.5 (respectively). 
- Splitting the difference, we will analyze this data looking for differences larger than &delta; = (0.5 + 0.2)/2 = 0.35.

Now a normal curve effectively runs &plusmn; 3 standard deviations covers 99% of the space. That is all normal curves are 6 standard deviations wide
which, using Sawilowsky's rule, divides into about 6/.35=17 distinguishable regions.

<img width=400 src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Standard_deviation_diagram.svg/1200px-Standard_deviation_diagram.svg.png">

Turning now to sampling theory:

- If something happens at probability `p` (e.g. we find our optimal solution using random search at probability 1/17=0.058)
- Then it does not happen at probability `1-p`
- So after `n` random samples, it does not happen at proability `(1 - p)<sub>n</sup>`
- So can see it  at confidence `C(n,p) = 1 - (1 - p)<sub>n</sup>`
- Which rearranges to `n(C,p) =log(1-C)/log(1-p)`

So:

|p| C=Confidence | n(C,0.058)| notes|
|---|-----------=|=----------|----|
|0.058| 0.9         |  39       | The above Sawilowsky recommendation.a|
|0.058--| 0.95        |  52       | |
|.058--| 0.99        |  78       ||
|0.058--| 0.999       | 116       ||
|0.058--| 0.9999      | 154       ||
|0.029  | 0.9          | 78  |making the  target twice as  hard to find|
|0.029  | 0.95  |  101 ||
|0.029  | 0.99  |  156 ||
|0.029  | 0.999 | 234  ||
|0.029 | 0.9999 | 312||
|0.2   | 0.95   | 14 | the FFT case, discussed below|


In summary, 
- In theory: if you can relax a little, 50 to 100 random samples does pretty good.
- In practice: 

e.g. at each level of the FFT trees we are building, 

- our leaves can either exit to the target or its opposite
- So all tree of high `d` is really `2<sup>d</sup>` random probes around the output space.
