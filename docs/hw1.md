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


<img align=right width=400 src="https://user-images.githubusercontent.com/29195/129835135-9ac4bb47-efdf-4189-8f2a-06bf14fbebd1.png">


## Hw1


Set up for coding. Your repo is your resume. Convince  me that  you are proud of your product.

- Add [bling](#bling)
- Add [the other things](#and-the-rest)

## Bling
Get yourself the bling. e.g. here's the bling on one of
my repos:

<img alt="Lua" src="https://img.shields.io/badge/lua-v5.4-blue">
<a href="https://github.com/timm/keys/blob/master/LICENSE.md"><img 
alt="License" src="https://img.shields.io/badge/license-unlicense-red"></a> <img 
src="https://img.shields.io/badge/purpose-ai%20,%20se-blueviolet"> <img 
alt="Platform" src="https://img.shields.io/badge/platform-osx%20,%20linux-lightgrey"> <a 
href="https://github.com/timm/keys/actions"><img 
src="https://github.com/timm/keys/actions/workflows/unit-test.yml/badge.svg"></a> 

### License

Give your self a [good LICENSE.md](https://choosealicense.com/).

### DOI

Make your code <a href="https://guides.github.com/activities/citable-code/">cite-able</a>.
<a href="https://zenodo.org/badge/latestdoi/318809834"><img src="https://zenodo.org/badge/318809834.svg"></a>

### Testable

Make your code auto-test every time you commit the repo. FYI, I use Github Actions but you can 
use anything:

- [tutorial](https://docs.github.com/en/actions)
- [code](https://github.com/timm/keys/blob/main/.github/workflows/unit-test.yml)
- [output](https://github.com/timm/keys/actions)

--------------------

## And the rest

### .gitignore

Grab the _.gitignore_\s that work for you
from [https://github.com/github/gitignore](https://github.com/github/gitignore).

### Install

Set up a _requirements.txt_ listing all the things you need for you code.

### Github pages

Find some way to pretty print source code into a `/docs`. 

#### Docco

For something simpler, that covers more languages, there is [docco](http://ashkenas.com/docco/)

- sample output: https://newyork-anthonyng.github.io/articles/deliberate_practice/002_docco/tutorial/docs/annotatedDocco.html

#### Pdoc3

For python, `pdoc3` is nice and has more features that docco.

-  E.g. [bnbad2](http://menzies.us/bnbad2/duo4.html).
   - pdoc3 -o ../docs --force --html --template-dir ../docs file 
  - With these templates:
    - [\_config.yml](https://github.com/timm/bnbad2/blob/main/docs/\_config.yml)
    - [config.mako](https://github.com/timm/bnbad2/blob/main/docs/config.mako)
    - [credits.mako](https://github.com/timm/bnbad2/blob/main/docs/credits.mako)
    - [logo.mako](https://github.com/timm/bnbad2/blob/main/docs/logo.mako)

After docco and pdoc3, there is an infinity of documentation tools of infinite complexity.  Be warned.

#### Roll your  own

Sometimes
I just say "screw it" and  write 10 lines of awk that builds markdown  files by:

- write markdown into the  comments
- wrap the code with fenced quotes 
- delete the  markdown  comment characters. 

Then I don't even  display  with GH papges and just show raw ".md" files.

- e.g. https://github.com/timm/lisp/blob/master/src/espy/README.md

