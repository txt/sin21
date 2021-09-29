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

 <em>Todo: state Timm's rule up front. include the skew results and conjuction of skew calculator</em>
 
# Ethical, Understandable, Audit-able

Is AI fundamentally inexplicable? Incomprehensible? 
The 
internal search space  of  options within an AI systems seems vast.
Well, lets look into that....

[Valerdi et al.](https://ieeexplore.ieee.org/document/5556044) reports experiences gained when experts review data.
 In that work, it took three rounds of 3 hour meetings
for  experts to agree on their interpretation (good bad, big, small, slow to build, fast to build) of a few dozen examples
(where those examples are expressed in terms of two dozen attributes).

So lets call that Valerdi's rule: to make something explicable, you can only show them more than two dozen attributes\*two dozen rows
per day.

 Of course, there are 
[impressive multi-dimensions explanation tools](https://scikit-learn.org/stable/modules/generated/sklearn.manifold.TSNE.html)
 that report to be able to let humans find important distinctions in
complex data spaces. 
- But on Tuesdays and Thursdays I fret that what is being shown there is more a quirk of that explanation system rather than a
a feature of the original data. 
- Also, on Mondays, Wednesdays and Fridays, I doubt if those extra tools are needed since I seem to be able
to reduce data to small spaces (see below). 
- And then on the weekends I think that the point is moot since I don't want to explain data, I want
to offer regions defining acceptable policies; i.e. I want to show rules generated from rules-- which humans can check with just
a Valerdi-level of effort.

Now lets look at ways to generate my kind of rules.

## Hyperparameter Optimization

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

[Aggawral et al.](https://bib.dbvis.de/uploadedFiles/155.pdf) argue that the _larger_ the dimensions, the _smaller_ you want p (e.g. p=1)
     
- Strangely, I've found cases where [p=3](https://github.com/timm/lean/blob/master/src/knn.lua#L76-L77) was best. Go figure. 
- Guess you have to run experiments to work out what works best for your own data.

Warning: 
searching for the right hyper-parameters can take  a long search. 

- [Section 3](http://menzies.us/pdf/11teak.pdf#page=6) lists more than 
  17,000 ways to configure nearest neighbor seen in the recent SE literature.
- When you combine all the learner options with all the pre-processing options (how many bins? What _iotoa_ is enough     to distinguish two ranges? etc)
  then you can be faced with billions of options, or more
  (see  [Table1](https://arxiv.org/pdf/1902.01838.pdf#apge=2) 

## Hyperparameter Optimization: Grid Search

For each option add a nested for loop to spin over the option space.

Benefits:

- Grid search is simple to implement and parallelization is trivial;
- Grid search (with access to a compute cluster) typically finds a better model
- Grid search is reliable in low dimensional spaces (e.g., 1-d, 2-d).
- Implemented in many tools (e.g.t he CARET package)

Warning: when dealing with more than 2 dimensions

- Really slow
- If you want to explain what  effects hold over a region of parameters, you need some secondary process.
  - e.g. to determine how much can you fiddle a parameter without losing "best";
  - e.g. when users ask you for a "policy"; i.e. some range of acceptable behavior
- Can be [surprisingly ineffective](https://www.jmlr.org/papers/volume13/bergstra12a/bergstra12a.pdf).
  -  looking at several relatively similar data sets (from different distributions) shows us that different data sets need very different hyperparameters
  -  A grid with sufficient granularity to optimizing hyper-parameters for all data sets must consequently be inefficient for each individual data set because of the curse of dimensionality
     - the number of wasted grid search trials is exponential in the number of search dimensions that turn out to be irrelevant for a particular data set

## Hyperparameter Optimization: Random Search



If we want near-optimal (as apposed to the-optimal) then a few random probes can be remarkably effective.
     
<img width=500 src="https://user-images.githubusercontent.com/29195/134368806-eaaddad3-a4a9-41dd-825c-2d741509685d.png">


What does "near-optimum" mean? When is some number indistinguishably  close  to "optimum"?

- [Rosenthal et al.](https://www.google.com/books/edition/The_Handbook_of_Research_Synthesis/p-aFAwAAQBAJ?hl=en&gbpv=1&pg=PA231&printsec=frontcover) discuss different methods for asserting that
one result is with some small effect of another (i.e. it is “close to”)_ 
- They list
dozens of effect size tests that divide into two groups: 
  - the `r` group 
based on the Pearson correlation coefficient;  or
  - the `d` family that is based on
absolute differences normalized by (e.g.) the size of the standard deviation.
    - e.g. two numbers are essentially the same if they differ by less than &delta;\*&sigma; (the standard deviation)

- Since 
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

- If something happens at probability _p_ (e.g. we find our optimal solution using random search at probability 1/17=0.058)
- Then it does not happen at probability _1-p_
- So after _n_ random samples, it does not happen at probability _(1 - p)<sup>n</sup>_
- So can see it  at confidence _C(n,p) = 1 - (1 - p)<sup>n</sup>_
- Which rearranges to _n(C,p) =log(1-C)/log(1-p)_

So:

|p    | C=Confidence | n(C,p) | notes|
|-----|--------------|-----------|------|
|0.058| 0.9          |  39       | The above Sawilowsky recommendation.|
|0.058| 0.95         |  52       |                                     |
|0.058| 0.99         |  78       |                                     |
|0.058| 0.999        | 116       |                                     |
|0.058| 0.9999       | 154       |                                     |
|0.029| 0.9          | 78        |making the  target twice as  hard to find|
|0.029| 0.95         |  101      |  |
|0.029| 0.99         |  156      | |
|0.029| 0.999        | 234       | |
|0.029| 0.9999       | 312       | |
|0.2  | 0.95          | 14       | the FFT case, discussed below|


In summary, 
- In theory: depending on how much you want to relax, a few dozen samples  does pretty good.
- In practice: [Villalobos-Arias et al.](https://dl.acm.org/doi/abs/10.1145/3475960.3475986) show that for effort estimation _n=60_
  samples does as well as anything else.

 Note: this is the case of one goal. What about N goals?
 
 ### Deb's Rule (Epsilon Dominaton)

 Every learner's performance  varies according to the trainin data.
- Run 20 experiements, each time using 90% of the training data (picked at random), you will get a _wriggle_ (call it epsilon &epsilon; 

<img src="https://camo.githubusercontent.com/123a3c476b56327442750f71c013596a4b379220c5dc83de213f58ddf340576f/68747470733a2f2f7777772e7265736561726368676174652e6e65742f70726f66696c652f5869616e672d4368656e2d32322f7075626c69636174696f6e2f3331393038383538372f6669677572652f666967332f41533a37313935333438383132363737313240313534383536313839323938302f5468652d726573756c742d6f662d53636f74742d4b6e6f74742d746573742d696e2d63726f73732d76616c69646174696f6e2d7363656e6172696f2e706e67" width=600>

 _Epsilon Domiantion_
 
 - If the eprformance differs by less than #epsilon;, ignore those differences
 
 ![image](https://user-images.githubusercontent.com/29195/135327076-a76b1b5e-f069-43ae-b675-be6fb18bb5cd.png)

 Kalyanmoy Deb, Manikanth Mohan, and Shikhar Mishra. 2005. Evaluating the ϵ-Domination Based Multi-Objective Evolutionary Algorithm for a Quick Computation of Pareto-Optimal Solutions. Evol. Comput. 13, 4 (December 2005), 501–525. DOI:https://doi-org.prox.lib.ncsu.edu/10.1162/106365605774666895



 
### Timm's RUle

We can compute &epsilon; as a function of learner _wriggle_.
 
Returning to stats again, hypotheses tests at the 95% level say that
  -  things are _not_ distinguishable if they overlap by more tha 5% of their probability mass. 
  - This occurs at &plusminus; 1.96 of the standard deviations 
 
That is:
 - if you are studying something with performance ranges 0..1 
 - which show a standard deviation in their behavior of 10%,
 - Then that device has distinguishable regions of size 1.96\*.1 &approx; 2
 - And  16 random probes  would be enough to get you 95% sure of finding something indistinguishable from the best value.
   - Evidence (see last line of above table)

### Timm's Rule and FFTs
 
Consider our FFT trees. Ata each level of   FFT trees:

- Our leaves can either exit to the target or its opposite
- So all tree of high `d` is really `2<sup>d</sup>` random probes around the output space.

Here are four trees that effectively sample across the two distnbutions: 
- Technically these are 1110, 1010, 0110, 0010 trees 
- Note two conventions:
  - Exits to the right are "1"
  - The second last decision is the bottom left
  - Which leaves only one decision for the last one (the negation of the second last).

<img width=700 src="https://user-images.githubusercontent.com/29195/134373379-efd03cfa-3ca2-4928-936c-9f62710a3882.png">
                                                                                                                      
Note that they throw themselves around the output space, effectively performing 16 random searchers. 
                                                                                                                      
- Look at the last line of
                                                                                                                      the above table
                                                                                                                      we note that an FFT tree of depth 4  
                                                                                                                      (which generates 2<sup>4</sup>=16 
  models) would be sufficient to be 95% confident that we can find things in a space that divides into distinguishable regions of size 0.2.
- Which explains certain surprising [recent successes (see Figure 3)](https://arxiv.org/pdf/1803.05067.pdf#page=8)  software analytics  
  - Here, FFT trees of depth 4 beat several supposedly better learners.    
                                                                                                                      

