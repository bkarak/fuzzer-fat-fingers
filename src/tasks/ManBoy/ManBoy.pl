sub A($k is copy, &x1, &x2, &x3, &x4, &x5) {
    sub B { A(--$k, &B, &x1, &x2, &x3, &x4) }
    if $k <= 0 { x4() + x5() } else { B() }
};
 
say A(10, {1}, {-1}, {-1}, {1}, {0});