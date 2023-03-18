library("lmtest")

#1
# импортируем библетотеку и данные swiss
data = swiss
help(swiss)

#Oценка значений
M_InfMor = mean(swiss$Infant.Mortality)
V_InfMor = var(swiss$Infant.Mortality)
SKO_InfMor = sqrt(V_InfMor)
#Среднее значение гораздо больше СКО и немного больше дисперсии



M_Cat = mean(swiss$Catholic)
V_Cat= var(swiss$Catholic)
SKO_Cat = sqrt(V_Cat)
#Можем заметить, что СКО практически равно среднему значению, что
# СКО гораздо больше, чем в прошлом случае, как и дисперсия (относительно среднего значения)


M_Fer = mean(swiss$Fertility)
V_Fer= var(swiss$Fertility)
SKO_F = sqrt(V_Fer)
#В этом случае среднее значение больше СКО, но меньше дисперсии


#2 строим 2 зависимости вида y = k*x + b
model = lm(Infant.Mortality~Catholic, data)
model2 = lm(Infant.Mortality~Fertility, data)


#3 смотрим вывод и различные параметры, полученные из нашей модели
model
summary(model)
plot(swiss$Catholic, swiss$Infant.Mortality)

# Коеффициент Adjusted R-squared: 0.009261 - коеффициент R^2 очень низкий 0.9% < 30%
# Звёздочек тоже нет, p коеффициент высокий
# На графике вы видим что значения просто "прижимаются" к левой и правой части графика, зависимости тоже не видно

# Из полученных данных можно сделать вывод, что взаимосвязи между Infant.Mortality и Catholic нет


model2
summary(model2)
plot(swiss$Fertility, swiss$Infant.Mortality)

# Коеффициент Adjusted R-squared: 0.1552 - коеффициент R^2, 
#  хоть и больше чем в предыдущем случае но всё-равно слишком низок, наша модель плоха

# Кол-во звёздочек 2, взаимосвязь между регрессором и обЪяняемой переменной есть, но она не идеальна
# Параметр p низкий
# на графике основая зависимость видна от константы, т.к. k = 0.097, точки в среднем находятся посередине справа

# Из полученных данным от 2 модели делаем вывод, что модель требует доработки, т.к. r^2 низкий,
# но при этом зависимость Infant.Mortality от регрессора Fertility есть.




