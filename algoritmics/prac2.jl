function fastpow(a::T, n) where T #n какое-то натуральное + 0 a - действительное
    # b^k * p = a^n
    #b0, k0, p = a, n, 1
    #конец цикла при k = 0

    b, k, p = a, n, one(a)
    while k != 0
        # (b*b)^(k/2) * p = a^n
        if k % 2 == 0
            k /= 2
            b *= b
        else
        # b^(k-1) * p*b = a^n
            k -= 1
            p *= b

        end
    end
    return p
end

# function fastpow(a::T, n::Int) where T
#     if n < 0
#         return 1 / fastpow(a, -n::UInt)
#     else
#         return fastpow(a, n::UInt)
#     end
# end


function fibonachi(n)
    Basa_M = [1  1; 1  0]
    Small_M = [1; 0]

    # [F_n F_n-1] = [1 1; 1 0]^n * [1; 0] = Basa_M^n * Small_M

    Big_M = fastpow(Basa_M, n)
    M = Big_M * Small_M

    return M[1]



end


function fastlog(a, x, e)


    if a < 1
        return -fastlog(1/a, x, e)
    end

    # a > 1
    y, z, t = 0, x, 1

    # ИНВАРИАНТ a^y * z^t = x
    # |tlog_a(z)| < e
    # |t| < e , |log_a(z)| < 1 1/a < z < a

    while 1/a > z || z > a || t > e
        if 1/a > z
            y, z, t = y-t, z*a, t
        elseif  z > a
            y, z, t = y+t, z/a, t
        else
            y, z, t = y, z*z, t/2
        end
    end
    return y
end

function bisection(f::Function, a, b, epsilon=eps(b-a))
    @assert f(a)*f(b) < 0 
    @assert a < b
    f_a = f(a)
    #ИНВАРИАНТ: f_a*f(b) < 0
    while b-a > epsilon
        t = (a+b)/2
        f_t = f(t)
        if f_t == 0
            return t
        elseif f_a*f_t < 0
            b=t
        else
            a, f_a = t, f_t
        end
    return (a+b)/2, a, b
    end
end

function newton(r::Function, x; epsilon = 1e-8, num_max = 10)
    dx = r(x); x += dx; k=1
    while abs(dx) > epsilon && k < num_max
        dx = r(x); x += dx; k += 1
    end
    abs(dx) > epsilon && @warn("Требуемая точность не достигнута")
    return x
end

function f(x)
    return cos(x) - x
end

bisection(f, 0, pi, 0.001)



