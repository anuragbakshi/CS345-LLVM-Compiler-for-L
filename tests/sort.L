fun isOneItem with list =
    (isNil #(!(list)))
in

fun cat with l1, l2 = 
    if (isNil l1) then 
        l2 
    else if (isOneItem l1) then
        l1@(cat Nil l2)
    else
        !l1@(cat #l1 l2)
in


fun filter with list, func =
    if (isNil list) then
        Nil
    else if (isOneItem list) then
        (func list list Nil)
    else 
        (func !list (!list)@(filter #list func) (filter #list func))
in

fun isLess with x, y, true, false =
    if (!y < !x) then true else false
in

fun isGreaterOrEq with x, y, true, false =
    if (!y >= !x) then true else false
in

fun quicksort with list = 
    if (isNil list) then
        Nil
    else if (isOneItem list) then
        list     
    else 
        (cat 
            (quicksort (filter #list (isGreaterOrEq !list)))
            (!list)@(quicksort (filter #list (isLess !list))))
in

let listy =((2@"a")@(7@"c")@(5@"r")@(4@"x")) in 
(quicksort listy)

