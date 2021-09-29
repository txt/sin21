import random,math

def distribution(decay,buckets):
  "Return random numbers, sum noamrlzes 0..1"
  tmp=[random.random()]
  for _ in range(buckets-1): 
     old=tmp[-1]; 
     tmp += [old*decay]
  s=sum(tmp)
  return sorted([x/s for x in tmp])

def run(n=1000,decay=0.99,dimensions=10, buckets = 10):
  ds=[distribution(decay,buckets) for _ in range(dimensions)]
  print()
  [print(d) for d in ds]
  print()
  nums=[math.prod(random.choice(d) for d in ds) for _ in range(n)]
  return sorted(nums,reverse=True)

for x in run(decay=.9,dimensions=6,buckets=10,n=1000): print(x)
