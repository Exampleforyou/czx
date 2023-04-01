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

function sin_(x, e=0)
    s = 0; a = x; k = 2
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
    s = 1; a = x; k = 1
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

function solve_lin(A::Matrix{T}, B::Vector{T}) where T
    Ab = [A b]
    rang = reduce!(Ab) # Привести к ступенчатому виду
    if rang == n
        return solve_triangle(Ab)
    end
end

x = pi /5
println(sin(x))
println(sin_(x))

println(exp_(1))
n = 40
e = exp_(n)
println(" моя ф-ия = $e встроенная exp = $e машинный эпсилон e^$n = $(eps(e))")

p = eps(e)/3

(e + p) + p == e + (p + p)