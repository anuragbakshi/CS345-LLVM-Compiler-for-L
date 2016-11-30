fun f with x =
    if x = 0 then 1 else x * (f (x - 1))
in

(f 10)
