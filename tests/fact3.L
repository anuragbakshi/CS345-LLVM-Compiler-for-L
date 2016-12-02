(lambda f. (f f)
    lambda fact.
        lambda n.
            if n = 0 then 1 else n * (fact fact (n - 1)) 5)
