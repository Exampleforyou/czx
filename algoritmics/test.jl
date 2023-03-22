struct Rsidue{T, M}

    a::T
    Rsidue{T, M}(a::T) where {T, M} = new(mod(a, M));

end

function zero(::Type{Rsidue{T, M}}) where {T, M}
    return Rsidue{T, M}(0)
end



