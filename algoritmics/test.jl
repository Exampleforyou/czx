struct s1{T}
    a::T
    s1{T}(a::T) where T = new(a)
end

struct Rsidue{T, M}

    a::T

    Rsidue{T, M}(a::T) where {T, M} = new(a) 
end

struct s2{T}
    b::T
    s2{T}(b::T) where T = new(b)
end

a = 2.0
println("=============================================")
b = eps(a)
println(a,  " \n " , b)
bitstring(a)
bitstring(b)
println("b |")
