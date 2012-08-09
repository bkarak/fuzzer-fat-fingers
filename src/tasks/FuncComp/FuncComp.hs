let compose f g x = f (g x)
let sin_asin = compose sin asin
sin_asin 0.5
