# Fariness

## Goals

 

Well, so much disagreement, but some overlap:
-“Ethically-aligned design: A vision for prioritizing human well-begin
with autonomous and intelligence systems.” 2019.
-  “Ethics guidelines for trustworthy artificial intelligence.” 2018.
Available: https://ec.europa.eu/digital-single-market/en/news/
ethics-guidelines-trustworthy-ai
- “Microsoft AI principles,” 2019. [Online]. Available: http://tiny.cc/
Microsof

![image](https://user-images.githubusercontent.com/29195/130842113-93112640-9586-4ef0-9fbe-1b1f9974c229.png)

From the above I state that common concerns are for
 AI that is accountable, transparent, inclusive, can integrate with human agency, and allows human oversight

## methods 
We can Optimize for fairness, just ike anything else.


You now that learners adjsut their internal parameters e.g. Neural nets, gradient descent

<img width=400 src="https://user-images.githubusercontent.com/29195/130842332-f0aae335-edf3-4fce-925b-331a6d6bf4cc.png">

Symbolic rule learning

<img width=400 src="https://user-images.githubusercontent.com/29195/130842423-2649dbfb-cad9-4128-abd0-c13a6e285099.png">

<img width=400 src="https://user-images.githubusercontent.com/29195/130842528-f7820e05-d36b-4b1a-9e41-fef435de5283.png">

Tantithamthavorn, et al. “Automated parameter optimization of classification techniques for defect prediction models.” ICSE’16 

<img width=800 src="https://user-images.githubusercontent.com/29195/130847117-bb86a7cf-b657-462f-9480-219361e1325b.png">




Cruz, A. F., Saleiro, P., Belém, C., Soares, C., & Bizarro, P. (2021). Promoting Fairness through Hyperparameter Optimization. arXiv arXiv:2103.12715.

"Fairness" = Effects of different learner control parameters 
       (fairness = ratio of true positive rates across projected attributes)

![image](https://user-images.githubusercontent.com/29195/130842711-01c78419-c8d4-4b96-8064-2fba3c33d6c4.png)

Aaarg! so many blue dots. 

- Q: how to explore them all?
- A: epsilon domination

![image](https://user-images.githubusercontent.com/29195/130842896-2abde518-0abd-4a2b-a001-100520e4b1f3.png)

The output space of these learners actually "grids" into a small number of chunks.

![image](https://user-images.githubusercontent.com/29195/130842928-3ba01064-97ba-481d-af1c-3ab26448c7c9.png)

How to explore that grid:

- A1: a funky tabu search. Agrawal, A., Fu, W., Chen, D., Shen, X., & Menzies, T. (2019). How to" DODGE" Complex Software Analytics. IEEE TSE
- A2: something much simpler

## Case Study: Fast and Frudal trees

An accidental hyperparameter optimizer (with succinct rules)

![image](https://user-images.githubusercontent.com/29195/130843063-69732276-0e6a-4822-9955-fdd1a51b9699.png)

![image](https://user-images.githubusercontent.com/29195/130843184-373d50b2-3ace-4b0a-80e0-dff4bef4db31.png)

<img width=300 src="https://user-images.githubusercontent.com/29195/130843316-b3431e10-0e7e-476e-a73b-6e345a1e30e8.png"> <img width=280 src="https://user-images.githubusercontent.com/29195/130843349-95c07e1f-bb3e-4aa2-89d6-76ac1426321d.png"> <img width=260 src="https://user-images.githubusercontent.com/29195/130843390-4dd7441f-8f1b-42e9-a12b-e907d01bd38a.png">

![image](https://user-images.githubusercontent.com/29195/130843655-dea9bcd2-d6cf-4282-94fb-dcd4ecaf7a69.png)



<img width=300 src="https://user-images.githubusercontent.com/29195/130843498-7e9d0897-4e39-4333-a49e-802e8c42f51e.png">


 

