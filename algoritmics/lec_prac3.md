# Вычисление элементарных ф-ий
# Мы умеем xn, log_a(x)
# Хотим уметь nsqrt(x)

# f(y) = -x + y^n = 0 (метод Ньютона)

$$
x = a^y=a^{\tilde y - \Delta} =a^{\tilde y}a^{-\Delta}=a^{\tilde y}z^t
$$
где $z^t=a^{-\Delta}$, $z, \ t$ - две новые переменные, значения котрых потребуется выбрать такими, чтобы обеспечить требование $|\Delta|\le \varepsilon$.

$$
F_n = \frac{1}{\sqrt 5}\Bigg(\Big(\frac{1+\sqrt 5}{2}\Big)^n-\Big(\frac{1-\sqrt 5}{2}\Big)^n\Bigg)
$$

$$
x^a = e^{a*ln x}
$$
$e^n = \sum{\frac{1}{k!}}$

```julia
# Функция вычисления e
function eyler(n)
    s = 0, f = 1
    for k = 1:n
        f *= k
        s += 1/f
    end
    return s
end

# функция вычисления sin(x) с заданной погрешностью
function sin_(x, e)
    s = 0
    a = x
    k = 2
    while abs(a) > e
        s += a
        a *= -x*x / (k*(k+1))
        k += 2
    end
end
```
$
Вычисление \space e^x
$
$$
\frac{a_{k+1}}{a_k} = \frac{x}{k+1}
$$

# Метод Жордано-Гаусса решения СЛАУ
 