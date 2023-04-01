#=
function gcd_(a::T,b::T) where T
    while b>0
        a,b=b,mod(a,b)
    end
    return a
end

function gcdx_(a::T,b::T) where T
    u1,v1=1,0
    u2,v2=0,1
    while b>0
        k=div(a,b)
        a,b=b,a-k*b
        u1,v1,u2,v2=u2,v2,u1-k*u2,v1-k*v2
    end
    if a<0
        return a,u1,v1
    end
    return a, u1, v1
end

struct Residue{T, M} 
    a::T
    Residue{T, M}(a::T) where {T, M} = new(mod(a,M))
end 

function Base. +(z1::Residue{T, M}, z2::Residue{T, M}) where {T, M}
    return Residue{T, M}(z1.a+z2.a)
end

function Base. *(z1::Residue{T, M}, z2::Residue{T, M}) where {T, M}
    return Residue{T, M}(z1.a*z2.a)
end

function Base. -(z1::Residue{T, M}, z2::Residue{T, M}) where {T, M}
    return Residue{T, M}(z1.a-z2.a)
end

function Base. -(z1::Residue{T, M}) where {T, M}
    return Residue{T, M}(-z1.a)
end

function Base. ^(z1::Residue{T, M}, p::Real) where {T, M}
    return Residue{T, M}(z1.a^p)
end

function inverse(z::Residue{T, M}) where {T, M}
    a,b=gcdx_(z.a, M)
    if a==1
        return Residue{T, M}(b)
    else
        return zero(T)
    end
end

function Base. display(z::Residue{T,M}) where {T,M}
    println(z.a)
end

print(inverse(Residue{Int, 9}(4)))

struct Polynomials{T}
    coeffs::Vector{T}
end

function Base.convert(::Type{Residue{T, M}}, x::T) where {T, M}
    Residue{T,M}(x)
end

function ord(p::Polynomials)
    return length(p.coeffs)
end

function Base. +(pl1::Polynomials{T}, pl2::Polynomials{T}) where T
    a,b=ord(p1), ord(p2)
    output = zeros(T, max(a,b))
    output[1:a] += p1.coeffs
    output[1:b] += p2.coeffs
    return Polynomials{T}(output)
end

function Base. *(p::Polynomials{T}, a::T) where T
    return p.coeffs.*a
end

print(Vector([1,2,3,4])*2)