; <a name=top>
; <a  href="https://git.io/sin21"><img  width=400 src="/docs/img/sin1.png"></a>       
; <hr>
; <p>
; &nbsp;<a href="https://git.io/sin21">home</a> ::
; <a href="https://github.com/txt/sin21/blob/master/docs/syllabus.md#top">syllabus</a> ::
; <a href="https://github.com/txt/sin21/blob/master/docs/syllabus.md#timetable">timetable</a> ::
; <a href="https://docs.google.com/spreadsheets/d/1n0zHiZlVYkLAEg5Lj1CVaLSEaeNy8iYjw8IMWYWs4Tk/edit?usp=sharing">groups</a> ::
; moodle(<a href="https://moodle-courses2122.wolfware.ncsu.edu/course/view.php?id=3211">591</a>,
; <a href="https://moodle-courses2122.wolfware.ncsu.edu/course/view.php?id=3211">791</a>) ::
; video <a href="https://ncsu.hosted.panopto.com/Panopto/Pages/Sessions/List.aspx#folderID=a5998f03-01df-4c6c-91c1-ad80003f3c7c">tbd</a> ::
; <a href="https://github.com/txt/sin21/blob/master/LICENSE.md#top">&copy; 2021</a>
; <br>
; <hr>
; 


;





--  ## String Stuff
-- Formatting strings
function fmt(...) return string.format(...) end
-- **showr(t:tbl) :str**     
-- Return table as string. Print table in sorted keys
-- order. For simple arrays (with contiguous numeric keys). don't
-- show the keys.
local function show(t,     u,mt,pre,ks)
  u,ks = {},{}
  for k,_ in pairs(t) do if k:sub(1,1)~="_" then ks[1+#ks]=k end end
  table.sort(ks)
  for _,k in pairs(ks) do 
    s= tostring(t[k])
    u[1+#u]= #t>0 and s or k.."="..s end 
  pre = (getmetatable(t) or {})._name or ""
  return pre.. "("..table.concat(u,", ")..")" end
-- ## OO Stuff
-- **klass(name:str):tbl**   
-- Create a constructor `klass()` (and store a print `name`).
local function klass(s,up,   k) 
  k = {_name=is, __tostring=show}; return setmetatable(k,up) end
-- **isa(klass:tbl, ?new:tbl, ?also:tbl):tbl**    
-- Delegate calls to `new` to `klass`. If `also` exists, add those slots.
local function isa(self,    new,also, super)
  new = new or {}
  self.__index = self
  for k,v in pairs(also or {}) do new[k]=v end
  return setmetatable(new, self) end
-- **Obj:new():Obt**  
local Obj=klass("Obj")
function Obj:new() return isa(Obj) end
-- ## List stuff
-- Sorting lists.
local function order(t) table.sort(t); return t  end
-- First few items ina  list
local function top(t,n,     u)
  u={}; for i=1,n do u[i]=t[i] end
  return u end
-- Randomizing order or list
local function shuffle(t,the,     j)
  for i = #t, 2, -1 do
    j = the.rand:int(1,i)
    t[i], t[j] = t[j], t[i] end
  return t end
-- ## File Stuff
-- Reading csv files (each line read as one table)/
function csv(file,      split,stream,tmp)
  stream = file and io.input(file) or io.input()
  tmp    = io.read()
  return function(       t)
    if tmp then
      t,tmp = {},tmp:gsub("[\t\r ]*",""):gsub("#.*","")
      for y in string.gmatch(tmp, "([^,]+)") do t[#t+1]=y end
      tmp = io.read()
      if  #t > 0 
      then for j,x in pairs(t) do t[j] = tonumber(x) or x end
           return t end
    else io.close(stream) end end end
-- ## Random Stuff
local Rand={}
-- Random seeds.
function rand:new(seed)   return obj(rand,{seed=seed or 10014})  end
-- Random integers
function rand:int(lo,hi); return math.floor(0.5 + self:next(lo,hi)) end
-- Random floats
function rand:next(lo,hi) 
  lo, hi = lo or 0, hi or 1
  self.seed = (16807 * self.seed) % 2147483647 
  return lo + (hi-lo) * self.seed / 2147483647 end 
return {show=show, klass=klass, isa=isa, order=order,
        top=top, shuffle=shuffle, Rand=Rand}
