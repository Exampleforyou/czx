library("lmtest")
library("GGally")
library("car")

data = attitude

help(attitude)
summary(data)
ggpairs(data)
# ВАРИАНТ 30
# Объясняемая переменная rating 
# Регрессоры learning complaints privileges

premodel  = lm(privileges~complaints+learning, data) 
summary(premodel) 
#R2 0.3035 - небольшой, линейная зависимость небольшая
premodel2 = lm(complaints~privileges+learning, data)
summary(premodel2) 
# R2 0.4073 - средний,слабая линейная зависимость есть, самый большой R2 из всех регрессоров
premodel3 = lm(learning~privileges+complaints, data)
summary(premodel3) 
#R2 0.3484 - небольшой, линейная зависимость небольшая


model = lm(rating~complaints+privileges+learning, data)
vif(model)
summary(model)
# Adjusted R-squared:  0.6821 - модель достаточно хорошая, но можно лучше

# регрессоры privileges плохо, learning чуть лучше объясняет переменную rating 
# у обоих регрессоров p статистика высока, звёздочек нет, у learning только точка

# регрессор complaints хорошо объясняет переменную rating (имеет низкую p-статистику и ***) 


model2 = lm(rating~complaints+learning, data)
vif(model2)
summary(model2)
# Adjusted R-squared:  0.6864 коэффициент повысился модель улучшилась после исключения 
# регрессора privileges, также он имел значимую линейную зависимость по отношению к другим переменным, оставим эту модель

#=========ЗАДАНИЕ 2.3======================================
# Пытаемся ввести в модель логарифмы регрессоров

data$log_learning = log(data$learning)
data$log_complaints = log(data$complaints)
data$log_privileges = log(data$privileges)

test_model = lm(rating~complaints+learning+log_learning, data)
vif(test_model)
summary(test_model)
# vif высокий (линейная зависимость между регрессорами)
test_model = lm(rating~complaints+log_learning, data)
vif(test_model)
summary(test_model)
# vif низкий Adjusted R-squared:  0.6798 ухудшился по сравнению с оригинальной моделью
# р-статистика log_learning высокая

test_model = lm(rating~complaints+learning+log_complaints, data)
vif(test_model)
summary(test_model)
# vif опять высокий (линейная зависимость между регрессорами)
test_model = lm(rating~learning+log_complaints, data)
vif(test_model)
summary(test_model)
#vif низкий, модель не сильно отличается от оригинальной Adjusted R-squared 0.6828 (немного ухудшился)

test_model = lm(rating~complaints+learning+log_privileges, data)
vif(test_model)
summary(test_model)
#vif низкий, модель не сильно отличается от оригинальной Adjusted R-squared 0.6793 (немного ухудшился)

#=====================================================================================
# Введение логарифмов бессмысленно, так как либо возрастает vif, либо уменьшается r^2
# Оставим изначальную модель model2
#=====================================================================================

model2 = lm(rating~complaints+learning, data)
vif(model2)
summary(model2)

#=========ЗАДАНИЕ 2.4======================================
# Пытаемся ввести в модель произведения регрессоров

# Проверяем модель с всевозможными произведениями с регрессором complaints
multiplication_test_model = lm(rating~complaints+learning+I(complaints*learning), data)
vif(multiplication_test_model)
summary(multiplication_test_model)
# vif высокий (линейная зависимость между регрессорами)

multiplication_test_model = lm(rating~+learning+I(complaints*learning), data)
vif(multiplication_test_model)
summary(multiplication_test_model)
# vif средний (линейная зависимость между регрессорами)

multiplication_test_model = lm(rating~complaints+I(complaints*learning), data)
vif(multiplication_test_model)
summary(multiplication_test_model)
# vif средний (линейная зависимость между регрессорами)


multiplication_test_model = lm(rating~complaints+learning+I(complaints^2), data)
vif(multiplication_test_model)
summary(multiplication_test_model)
# vif высокий (линейная зависимость между регрессорами)

multiplication_test_model = lm(rating~learning+I(complaints^2), data)
vif(multiplication_test_model)
summary(multiplication_test_model)
# vif низкий, регрессор I(complaints^2) заменил complaints и чуть ухудшил Adjusted R-squared:  0.6735 

multiplication_test_model = lm(rating~complaints+learning+I(complaints*privileges), data)
vif(multiplication_test_model)
summary(multiplication_test_model)
# vif низкий, Adjusted R-squared:  0.6837 - чуть хуже оригинальной, у произведения 
# p-статистика высокая


# Проверяем модель с оставшимися всевозможными произведениями
multiplication_test_model = lm(rating~complaints+learning+I(learning*privileges), data)
vif(multiplication_test_model)
summary(multiplication_test_model)
# vif средний (линейная зависимость между регрессорами есть) R^2 0.6801 чуть уменьшился

multiplication_test_model = lm(rating~complaints+learning+I(learning^2), data)
vif(multiplication_test_model)
summary(multiplication_test_model)
# vif высокий (линейная зависимость между регрессорами)

#========================================================================
lucky_model = lm(rating~complaints+I(learning^2), data)
vif(lucky_model)
summary(lucky_model)
# vif низкий, Adjusted R-squared:  0.6919 чуть возрос по сравнению с model2 
#========================================================================

multiplication_test_model = lm(rating~complaints+learning+I(privileges^2), data)
vif(multiplication_test_model)
summary(multiplication_test_model)
# vif низкий, Adjusted R-squared:  0.6846 чуть хуже чем в model2

multiplication_test_model = lm(rating~complaints+I(learning^2)+I(privileges^2), data)
vif(multiplication_test_model)
summary(multiplication_test_model)
# vif низкий, Adjusted R-squared:  0.691 лучше чем в model2, но хуже чем в lucky_model

# Вводим улучшенную модель lucky_model, как основную


# Задание 2.1.1 

lucky_model = lm(rating~complaints+I(learning^2), data)
vif(lucky_model)
summary(lucky_model)
plot(lucky_model)
# 27 степеней свободы - 2 переменные = 25

t_critical = qt(0.975, df = 25)
t_critical # 2.059539

# [b - error*t_critical , b + error*t_critical].


b_comp = 0.635954
error_comp = 0.116560   
interval_comp = c(b_comp - error_comp*t_critical, b_comp + error_comp*t_critical)
interval_comp # [0.3958942, 0.8760138]
# b = 0 не попадает в доверительный интервал на уровне значимости 5%, регрессор сильно влияет на модель


# learning^2 = ls
b_ls = 0.002031   
error_ls = 0.001174      
interval_ls = c(b_ls - error_ls*t_critical, b_ls + error_ls*t_critical)
interval_ls # [-0.0003868983,  0.0044488983]
# b = 0 попадает в доверительный интервал, также этот интервал очень маленький, из чего можно
# сделать вывод, что регрессор практически не влияет на переменную

new.data = data.frame(complaints = mean(data$complaints), learning = mean(data$learning))
predict(lucky_model, new.data, interval = "confidence")
#  fit      lwr      upr
#  64.36285 61.81133 66.91438

# Доверительный интервал набора достаточно маленький, следовательно переменная хорошо объяснена моделью для данных значений

