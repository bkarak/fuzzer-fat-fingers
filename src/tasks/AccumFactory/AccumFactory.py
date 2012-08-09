def accumulator(sum):
  def f(n):
    global s
    s += n
    return s
  return f

s = 0
x = accumulator(1)
x(5)
print(x(2.3))