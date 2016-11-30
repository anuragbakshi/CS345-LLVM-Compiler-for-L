fun f with x =
    if x = 0 then 1 else (f (x - 1))
in

let k = readInt in

(f k)
