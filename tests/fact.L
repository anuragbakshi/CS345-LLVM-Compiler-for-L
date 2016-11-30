fun f with x =
    if x = 0 then 1 else x * (f (x - 1))
in

let k = readInt in

(f k)
