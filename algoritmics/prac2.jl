function fastpow(a, n) #n какое-то натуральное + 0 a - действительное
    # b^k * p = a^n
    #b0, k0, p = a, n, 1
    #конец цикла при k = 0

    b, k, p = a, n, one(T)
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

    while t > e || 1/a > z || z > a
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


r = fastlog(1/2,4, 0.001)
R = Residue(123)