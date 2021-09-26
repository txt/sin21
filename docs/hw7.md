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

Control the world

# HW7: Control the World

According to [Villalobos'20](https://dl.acm.org/doi/abs/10.1145/3416508.3417121),
60 random probes across the hyperparameter space does as good as anything
else (for effort estimation). Does that work for car design (auto93)?

Step1: write down your hyperparameters
- Your FFT policy
  - write a binary to integer convertir (in Python3, its `int('11101',2)=29`
  - Now you can express your FFT branching policies as one number
- Write down all your other Hyperparameters. FYI, mine look like the following
  but only some of them actual change  my code

```
CONFIG = dict(
 bins = (float,.5,   "min bin size is n**bin"),
 cohen= (float,.35,  "ignore differences less than cohen*sd"),
 depth= (int,  5,    "dendogram depth"),
 end  = (int,  4,    "stopping criteria"),
 far  = (float,.9,   "where to find far samples"),
 rule = (str,  "plan","assessment rule for a bin"),
 loud = (bool, False,"loud mode: print stacktrace on error"),
 max  = (int,  500,  "max samples held  by `Nums`"),
 p    = (int,  2,    "co-efficient on distance equation"),
 seed = (int,  10014,  "random number seed"),
 support=(int, 2,    "use x**support to score a range"),
 todo = (str,  "",   "todo: function (to be run at start-up)"),
 Todo = (str, False, "list available items for -t"),
 verbose=(str,False, "enable verbose prints")
 )
```

Step2: control your Hyperparameters
- Remove your Hyperparameters from your globals
- Add them to a dictionary that you carry around the code.

Step3: build a mutator for each hyperparameter
- Define its range. e.g. cohen might go .1 to .5 (any anything outside
  that range can just crash the code.
- Write a function that picks a parameter, at random, from that range.

Step4: make your code crash reliant
- When you run this rig, your code will crash.
- Bury your top-level call inside a `try:except:` (in Lua: `pcall`)
  and if the code crashes, log the hyperparameter setting causing
  the crash to a file.
- Check the params causing the errors
  - If they are real bugs, fix them
  - If they are silly, out-of-scope errors, adjust your parameter mutator
    so they do not happen.

Step5: adjust the FFT code. 
- Report not just Weight-,Mpg+,Acc+ but also the size of each leaf N,
  which we want to maximize (why?). So we are really optimizing for
  Weight-,Mpg+,Acc+,N+
- For one branching policy, report the best leaf (the one that zitler says is
  best for Weight-,Mpg+,Acc+,N+). So know FFT does not print multiple
  rules, just one best leaf per rule
- Do not generate the forest. Just generate one tree at random
  (so anything at all  between and 1 tree and a (say) 111110 tree).

Step6: Random stagger
- Run your FFT code r=(30,60,125,250,500,1000) times, each time generating
  the forest of many trees.
- Build six  new data sets, for each _r_,
  same syntax as auto93 but the x-columns
  are all the Hyperparameter and the y-columns are 
  Weight-,Mpg+,Acc+,N+. 

Step7: learn a good policy
- Run your FFT trees from hw6 on these six data sets (separately).
  - Just use the defaults we used from last week    
    (and that is an odd thing to do... why?)
- Report the best hyperparameters and their associated y-values for
  each r


Step8: Write  a (tiny) report. half page of text. Answer
these questions:
- What were the run times of your optimizer as you increased _r_?
- Does Hyperparameter optimization change a learner's behavior?
- Does Hyperparameter optimization improve a learner's behavior?
- Does the Villabos hypothesis hold for car design? 
  - If not, how many random staggers do you suggest?
