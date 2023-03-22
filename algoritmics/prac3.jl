function eyler(n)
    s = 1.0
    f = 1.0
    for k in 1:n
        f *= k
        # if l == Inf
        #     return s
        # end
        s += 1/f
    end
    return s
end

function sin_(x, e)
    s = 0
    a = x
    k = 2
    if e != 0
        while abs(a) > e
            s += a
            a *= -x*x / (k*(k+1))
            k += 2
        end
    else
        while s + a != s
            s += a
            a *= -x*x / (k*(k+1))
            k += 2
        end
    end
    return s
end

function exp_(x, e=0)
    s = 1; a = 1; k = 1
    if e != 0
        while abs(a) > e
            s += a
            k += 1
            a *= x/k
        end
    else
        while s + a != s
            s += a
            k += 1
            a *= x/k
        end
    end
    return s
end


println(sin_(3.14/2, 0.001))
# println(sin_(3.14/2))


println(eyler(1337))

println(exp_(1))
println(" моя ф-ия = $(exp_(2)) встроенная exp = $(exp(2))")
