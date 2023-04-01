#вариант 28
#Задание 2.1
library("lmtest")
library("GGally")
library("car")

data = attitude
data
help(attitude)
summary(data)
ggpairs(data)

modele1_test1=lm(critical~learning, data) #R^2=0.01345 - линейная зависимость отсутствует
summary(modele1_test1)
modele1_test2=lm(critical~advance, data) #R^2=0.08028 - линейная зависимость отсутствует
summary(modele1_test2)
modele1_test3=lm(advance~learning, data) #R^2=0.2826 - зависимость небольшая
summary(modele1_test3)

modele1 = lm(rating~critical+learning+advance, data) 
summary(modele1)
#R^2(adjusted)=0.3902 - значение небольшое, следовательно, модель плохо объясняет переменную.
#p-значения регрессоров "critical" и "advance" велики и, следовательно, плохо объясняют переменную "rating".
#p-значение регрессора "learning" мало (также у регрессора стоит "***"), следовательно, он хорошо объясняет переменную.
#Значение vif мало, следовательно, регрессоры не зависят друг от друга линейно

modele2 = lm(rating~critical+log(critical, base=exp(1))+learning+advance, data)
summary(modele2) #p-статистика и значение R^2 улучшились
vif(modele2) #значение vif велико. Модель плохая.
modele3 = lm(rating~log(critical, base=exp(1))+learning+advance, data)
summary(modele3) #p-статистика и значение R^2 немного улучшились
vif(modele3) #Значение vif хорошое 
modele4 = lm(rating~critical+learning+log(learning, base=exp(1))+advance, data)
summary(modele4) #Качество модели ухудшилось
vif(modele4) #значение vif велико. Модель плохая.
modele5 = lm(rating~critical+log(learning, base=exp(1))+advance, data)
summary(modele5) #Качество модели ухудшилось
vif(modele5) #Значение vif хорошое 
modele6 = lm(rating~critical+learning+advance+log(advance, base=exp(1)), data)
summary(modele6) #Качество модели ухудшилось
vif(modele6) #значение vif велико. Модель плохая.
modele7 = lm(rating~critical+learning+log(advance, base=exp(1)), data)
summary(modele7) #Качество модели немного улучшилось
vif(modele7) #Значение vif хорошое.
modele8 = lm(rating~log(critical, base=exp(1))+learning+log(advance, base=exp(1)), data)
summary(modele8) #Качество модели ещё немного улучшилось
vif(modele8) #Значение vif хорошое.

summary(modele8)

#Берём modele8
modele8.1 = lm(rating~log(critical, base=exp(1))+I(log(critical, base=exp(1))*log(critical, base=exp(1)))+learning+log(advance, base=exp(1)), data)
vif(modele8.1) #vif слишком велик (присутствует лин зависимость)
modele8.2 = lm(rating~log(critical, base=exp(1))+I(log(critical, base=exp(1))*learning)+learning+log(advance, base=exp(1)), data)
vif(modele8.2) #vif слишком велик (присутствует лин зависимость)
modele8.3 = lm(rating~log(critical, base=exp(1))+I(log(critical, base=exp(1))*log(advance, base=exp(1)))+learning+log(advance, base=exp(1)), data)
vif(modele8.3) #vif слишком велик (присутствует лин зависимость)
modele8.4 = lm(rating~log(critical, base=exp(1))+learning+I(learning*learning)+log(advance, base=exp(1)), data)
vif(modele8.4) #vif слишком велик (присутствует лин зависимость)
modele8.5 = lm(rating~log(critical, base=exp(1))+learning+I(learning*log(advance, base=exp(1)))+log(advance, base=exp(1)), data)
vif(modele8.5) #vif слишком велик (присутствует лин зависимость)
modele8.5 = lm(rating~log(critical, base=exp(1))+learning+log(advance, base=exp(1))+I(log(advance, base=exp(1))*log(advance, base=exp(1))), data)
vif(modele8.5) #vif слишком велик (присутствует лин зависимость)

#Оставляем modele8
modele8 = lm(rating~log(critical, base=exp(1))+learning+log(advance, base=exp(1)), data)
summary(modele8) 

#Число степеней свободы = 26 (26 degrees of freedom) - 4 (коэффицента) = 22
t_critical = qt(0.975, df=22)
print(t_critical) #2.073873
BetaCritical = 16.7945 #Коффицент
BetaLearning = 0.8092 #Коффицент
BetaAdvance = -17.7983 #Коффицент
ErrorCritical = 12.7144 #Std. Error
ErrorLearning = 0.1753 #Std. Error
ErrorAdvance = 9.3583 #Std. Error
print(BetaCritical-t_critical*ErrorCritical)
print(BetaCritical+t_critical*ErrorCritical) 
#"0" попадает в интервал, следовательно, регрессор плохо объясняет переменную
print(BetaLearning-t_critical*ErrorLearning)
print(BetaLearning+t_critical*ErrorLearning)
#"0" не попадет в интервал, и сам интервал достаточно узок, следовательно значимость регрессора высока
print(BetaAdvance-t_critical*ErrorAdvance)
print(BetaAdvance+t_critical*ErrorAdvance)
#"0" попадает в интервал, следовательно, регрессор плохо объясняет переменную

new.data = data.frame(critical = 10, learning = 20, advance = 30)
predict(modele8, new.data, interval = "confidence")
#Доверительный интервал содержит "0", следовательно, маловероятно, что появиятся данный набор значений регрессоров
