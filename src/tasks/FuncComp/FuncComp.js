function compose(f, g) {
  return function(x) { return f(g(x)) }
}
 
var id = compose(Math.sin, Math.asin)
print id(0.5)   //  0.5