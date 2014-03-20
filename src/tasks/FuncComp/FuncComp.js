function compose(f, g) {
  return function(x) { return f(g(x)) }
}
 
var id = compose(Math.sin, Math.asin)
document.write(id(0.5));
