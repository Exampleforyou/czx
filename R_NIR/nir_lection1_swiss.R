library("lmtest")
library("GGally")
library("car")

data = swiss
help(swiss)

data
summary(data)

ggpairs(data)

modele1 = lm(Fertility~Education, data)
modele1
summary(modele1)

modele2 = lm(Fertility~Examination, data)
modele2
summary(modele2)

modelc = lm(Fertility~Catholic, data)
modelc
summary(modelc)

modela = lm(Fertility~Agriculture, data)
modela
summary(modela)

model_if = lm(Fertility~Infant.Mortality, data)
model_if
summary(model_if)

model_ex_agr = lm(Examination~Agriculture, data)
model_ex_agr
summary(model_ex_agr)

model_ed_agr = lm(Education~Agriculture, data)
model_ed_agr
summary(model_ed_agr)

