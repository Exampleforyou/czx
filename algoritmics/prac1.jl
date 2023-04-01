#1
function gcd_(a::T, b::T) where T
    #a0, b0 = b, a % b
    while b != zero(T)
        a, b = b, divrem(a, b)[1]
    end
    return a
end

#2
function gcdx_(a::T, b::T) where T
    u1, v2 = one(T)
    u2, v1 = zero(T)

    while b > 0
        
        q, r = divrem(a, b)
        a, b = b, r

        u1, u2 = u2, u1 - q*u2
        v1, v2 = v2, v1 - q*v2
        # println(a, b, u1,v1,u2,v2)
    end

    if isnegative(a)
        a,u1,v1 = -a,u1,v1
    end

    return a, u1, v1

end

isnegative(a::Integer)=(a < 0)



function invmod_(a::T, M::T) where T
    d, u = gcdx_(a, M)
    # println(d, u, mod(a*u, M))
    if d == one(T) && mod(a*u, M) == one(T)
        if u < Base.zero(T)
            u += M
        end
        return u
    end
    return nothing
end
# println(invmod_(4, 5))

function diaphant_solve(a::T, b::T, c::T) where T
    d, u, v = gcdx_(a, b)

    if c % d != 0
        return nothing
    end
    
    #     d    = a*u + b*v 
    # c = d*c' = a*x + b*y
    _c = c / d
    x = u*_c
    y = v*_c
    return x, y
end


struct Rsidue{T, M}

    a::T
    Rsidue{T, M}(a::T) where {T, M} = new(mod(a, M))

end

function Base. +(R1::Rsidue{T, M}, R2::Rsidue{T, M}) where {T, M}
    return Rsidue{T, M}(R1.a + R2.a)
end

function Base. -(R1::Rsidue{T, M}, R2::Rsidue{T, M}) where {T, M}
    return Rsidue{T, M}(R1.a - R2.a)
end

function Base. -(R1::Rsidue{T, M}) where {T, M}
    return Rsidue{T, M}(-R1.a)
end

function Base. *(R1::Rsidue{T, M}, R2::Rsidue{T, M}) where {T, M}
    return Rsidue{T, M}(R1.a * R2.a)
end

function Base. ^(R1::Rsidue{T, M},n::Int) where {T, M}
    return Rsidue{T, M}(R1.a^n)
end

function inverse(R::Rsidue{T, M}) where {T, M}
    d, u = gcdx_(R.a, M)
    if d == 1
        return u
    else
        return zero(T)
    end
end


function Base.show(io::IO, R::Rsidue{T, M}) where {T, M}
    print("$(R.a) mod($M)" )
end

function Base.zero(::Type{Rsidue{T, M}}) where {T, M}
    return Rsidue{T, M}(0)
end

function Base.one(::Type{Rsidue{T ,M}}) where {T, M}
    return Rsidue{T, M}(1)
end

# function Base.mod(R1::Rsidue{T, M}, R2::Rsidue{T, M}) where {T, M}
#     return Rsidue{T, M}(mod(R1.a, R2.a))
# end



struct Plolynom{T}

    #<1, t, t^2 ... t^n>
    coefs::Vector{T}
    Plolynom{T}(coefs::Vector{T}) where T = new(coefs)

end

function Base.zero(::Type{Plolynom{T}}) where {T}
    return Plolynom{T}([0])
end

function Base.one(::Type{Plolynom{T}}) where {T}
    return Plolynom{T}([1])
end


function Base. +(p1::Plolynom{T}, p2::Plolynom{T}) where T
    v1 = p1.coefs
    v2 = p2.coefs

    diflen = length(v1) - length(v2)
    a = Base.zeros(T, abs(diflen))

    if diflen > 0
        append!(v2, a)
    else
        append!(v1, a)
    end

    return Plolynom{T}(v1+v2)
end

function Base.divrem(p::Plolynom{T}, q::Plolynom{T}) where T
    if length(p.coefs) < length(q.coefs)
        return zero(p), p
    end

    div_coef = p.coefs[end] / q.coefs[end]
    div = Plolynom{T}([div_coef])
    rem = p - div * q

    if length(rem.coefs) < length(q.coefs)
        return div, rem
    end

    div2, rem2 = divrem(rem, q)
    div += Plolynom{T}([0, div2.coefs])
    rem = rem2
    return div, rem
end

function Base.show(io::IO, p::Plolynom{T}) where T
    print(p.coefs)
end


R1 = Rsidue{Int, 6}(5)
R2 = Rsidue{Int, 6}(4)
R3 = Rsidue{Int, 6}(3)

p1 = Plolynom{Real}([1,2,3,4])
p2 = Plolynom{Real}([1,2,3,4,5, 6])

# println(R1 + R2)
# println(p1 + p2)

PlRs1 = Plolynom{Rsidue{Int, 6}}([R1, R2, R3])
PlRs2 = Plolynom{Rsidue{Int, 6}}([R2, R3])

println(PlRs1)

println(PlRs1 + PlRs2)

# RsPl1 = Rsidue{Plolynom{Int}, p1}(p2)
# RsPl2 = Rsidue{Plolynom{Int}, p2.coefs}(p1)

divrem(p1, p1)

# println(gcd_(p1, p2))


