# Soal 1
# 1a
selisih <- c(22, 20, 3, 13, 20, 18, 11, 16, 23)
stdev <- sd(selisih)
stdev

# 1b. nilai t (p-value)
# t-test untuk mencari nilai t(p-value)
x <- c(78,75,67,77,70,72,78,74,77)
y <- c(100,95,70,90,90,90,89,90,100)

mean1 <- mean(x)
mean2 <- mean(y)

sd1 <- sd(x)
sd2 <- sd(y)

var1 <- sd1 ^ 2
var2 <- sd2 ^ 2

t_pvalue<- abs(mean2 - mean1) / sqrt((var1/9) + (var2/9))
t_pvalue

# 1c. 
t.test(x, y)


# Soal 2
install.packages("BSDA")
library(BSDA)
# 2a
# 2b
tsum.test(mean.x=23500, sd(3900), n.x=100)
# 2c


# Soal 3
# 3a
# H0 dan H1

bandung <- list("saham" = 19, "mean" = 3.64, "sd" = 1.67)
bali <- list("saham" = 27, "mean" = 2.79, "sd" = 1.32)

tsum.test(
  n.x = bandung$saham,
  n.y = bali$saham,
  mean.x = bandung$mean,
  mean.y = bali$mean,
  s.x = bandung$sd,
  s.y = bali$sd,
  var.equal = TRUE,
  alternative = "two.sided",
)

# 3b. Sampel statistik
tsum.test(mean.x=3.64, s.x = 1.67, n.x = 19, 
          mean.y =2.79 , s.y = 1.32, n.y = 27, 
          alternative = "greater", var.equal = TRUE)

# 3c. Uji Statistik df = 2
install.packages("mosaic")
library(mosaic)

plotDist(dist='t', df=2, col="blue")

# 3d. Nilai Critical
qchisq(p = 0.05, df = 2, lower.tail=FALSE)

# 3e

# 3f


#soal4
data4 <- read.table(url("https://rstatisticsandresearch.weebly.com/uploads/1/0/2/6/1026585/onewayanova.txt"),header = TRUE, check.names = TRUE)
byGroup <- split(data4, data4$Group)
group1 <- byGroup$`1`
group2 <- byGroup$`2`
group3 <- byGroup$`3`

hist(group1$Length, xlim = c(16, 20))
hist(group2$Length, xlim = c(16, 20))
hist(group3$Length, xlim = c(16, 20))

bartlett.test(data4$Length, data4$Group)


model1 <- lm(data4$Length~data4$Group)
summary(model1)

av <- aov(Length ~ factor(Group), data = data4)
TukeyHSD(av)

ggplot(data4, mapping = aes(x = Group, y = Length, group = 1)) +  geom_boxplot()

# Soal 5
# Soal 5a
install.packages("multcompView")
library(readr)
library(ggplot2)
library(multcompView)
library(dplyr)

GTL <- read_csv("GTL.csv")
head(GTL)

str(GTL)

qplot(x = Temp, y = Light, geom = "point", data = GTL) +
  facet_grid(.~Glass, labeller = label_both)

# Soal 5b
GTL$Glass <- as.factor(GTL$Glass)
GTL$Temp_Factor <- as.factor(GTL$Temp)
str(GTL)

anova <- aov(Light ~ Glass*Temp_Factor, data = GTL)
summary(anova)

# Soal 5c
data_summary <- group_by(GTL, Glass, Temp) %>%
  summarise(mean=mean(Light), sd=sd(Light)) %>%
  arrange(desc(mean))
print(data_summary)

# Soal 5d
tukey <- TukeyHSD(anova)
print(tukey)

# Soal 5e
tukey.cld <- multcompLetters4(anova, tukey)
print(tukey.cld)

cld <- as.data.frame.list(tukey.cld$`Glass:Temp_Factor`)
data_summary$Tukey <- cld$Letters
print(data_summary)

write.csv("GTL_summary.csv")
