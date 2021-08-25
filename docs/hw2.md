[home](/README.md)

# Hw2

## Goal:
To learn enough about data miners so that you can mash up your own, in creative ways.

Your task is to generate the (e) the contrast sets between (d) the regression trees learned from 
(c) discretized data (supervised, of course) taken from (b) a table of data read from (a) comma-separated data.

Note that such contrast sets satisfy many of the demands of this subject. They are succinct (human readable) and 
context-aware. The results are highly actionable (since they tell you how much or little you need to do to achieve some goal).
 So by coding this, you are building something that very few other people on the planet can access. Go WolfPack!

Note that I mention LUA code below- but don’t presume that you will write in LUA. Just treat the LUA code as something to read and review.


## Details

Rome was not built in a day. We will step slowly towards our goal.
If you kill this problem, then  go on to [hw3](hw3.md).

First, we read CSV files (Python people, please, no PANDA).

Given a [disk file like this](../data/weather.csv):


```
Outlook, Temp, ?Humidity, Windy,Wins+,Play-
sunny,85,85,FALSE,10,20
sunny,80,90,TRUE, 12,40
overcast,83,86,FALSE,40,40
rainy,70,96,FALSE,40,50
rainy,68,80,FALSE,
       50,30
rainy,65,70,TRUE,4,10
overcast,64,65,TRUE,30,60
sunny,72,95,FALSE,7,20 #adsas
sunny,69,70,FALSE,70,70
rainy,75,80,FALSE,80,40
sunny,75,70,TRUE,30,50
overcast,72,90,TRUE,60,50
overcast,81,75,FALSE,30,60
rainy,71, 91, TRUE ,50,40
```

Read each line, kill whitespace and anything after comment characters (#), break each line on comma.
Ignore any funny characters on line1. 

Read rows into a list of lists (one list per row), converting strings to numbers where appropriate.

Your code should contain checks for bad lines (and bad lines should be skipped over); i.e. symbols 
where numbers should be and wrong number of cells (we will say that row1 has the “right” length).

## What to hand in:

- Your repo, in the class spreadsheet with a directory /docs with a file /docs/hw2.md.
- Report runtimes loading in [POM3a](../data/pom3a.csv)
- For POM3a, add in many bad rows and have the code print out error messages from those lines


