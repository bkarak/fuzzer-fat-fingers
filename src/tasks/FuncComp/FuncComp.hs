compose f g x = f (g x)
sin_asin = compose sin asin

main = print $ sin_asin 0.5
