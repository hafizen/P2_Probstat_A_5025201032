# Penyelesaian

## Soal 1

### 1a
selisih untuk menyimpan data selisih<br>

dapatkan standar deviasi dengan `sd()`
```r
selisih <- c(22, 20, 3, 13, 20, 18, 11, 16, 23)
stdev <- sd(selisih)
stdev
```

![image](https://user-images.githubusercontent.com/99454377/170878860-4dd973fd-6dd6-45be-94e0-3f2d8721b9a1.png)

### 1b
Mendapatkan t(p-value) dengan selisih mean data 1 dan data 2 dibagi dengan akar penjumlahan variansi 1 dan 2 dibagi sejumlah n sample <br>
```r
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
```
![image](https://user-images.githubusercontent.com/99454377/170879244-c4354e74-04dc-4d45-9747-270d12c26e73.png)

### 1c
Uji hipotesis dengan `t.test()`
```r
t.test(x, y)
```
![image](https://user-images.githubusercontent.com/99454377/170879587-50877d9c-1c59-46fc-b620-0bf03eaab32c.png)

## Soal 2
### 2a
Setuju

### 2b
```r
tsum.test(mean.x=23500, sd(3900), n.x=100)
```
![image](https://user-images.githubusercontent.com/99454377/170879765-fde996f2-6f2b-4309-8f2e-300b010eeb67.png)
Diketahui n = 100, Rata-Rata (X̄) = 23500, dan standar deviasi(σ) = 3900 Maka null hipotesis adalah
```r
H0 : μ = 20000
```
Alternatif hipotesis
```r
H0 : μ > 20000
```

### 2c

## Soal 3
### 3a
Null hipotesis
```r
H0 : "Tidak ada perbedaan rata - rata antara Bandung dan Bali"
```
Alternatif hipotesis
```r
H1 : "Ada perbedaan rata - rata antara Bandung dan Bali"
```
### 3b
```r
tsum.test(mean.x=3.64, s.x = 1.67, n.x = 19, 
          mean.y =2.79 , s.y = 1.32, n.y = 27, 
          alternative = "greater", var.equal = TRUE)
```
![image](https://user-images.githubusercontent.com/99454377/170880445-44b85708-fd99-4d75-b5ba-5173191eb255.png)

### 3c
Lakukan Uji Statistik (df =2)
```r
plotDist(dist='t', df=2, col="blue")
```
![image](https://user-images.githubusercontent.com/99454377/170880937-6c28ace5-021c-4322-a22e-607658a774dd.png)


### 3d
Nilai kritikal Adapun untuk mendapatkan nilai kritikal bisa menggunakan `qchisq` dengan `df=2` sesuai soal sebelumnya
```r
qchisq(p = 0.05, df = 2, lower.tail=FALSE)
```


### 3e
Keputusan dapat dibuat dengan t.test

### 3f
Kesimpulan Kesimpulan yang didapatkan yaitu perbedaan rata-rata yang terjadi tidak ada jika dilihat dari uji statistik dan akan ada tetapi tidak signifikan jika dipengaruhi nilai kritikal.

## Soal 4
### 4a
Lihat data grafik
```r
myFile  <- read.table(url("https://rstatisticsandresearch.weebly.com/uploads/1/0/2/6/1026585/onewayanova.txt"))
dim(myFile)
head(myFile)
attach(myFile)

myFile$V1 <- as.factor(myFile$V1)
myFile$V1 = factor(myFile$V1,labels = c("Kucing Oren","Kucing Hitam","Kucing Putih","Kucing Oren"))

class(myFile$V1)

group1 <- subset(myFile, V1=="Kucing Oren")
group2 <- subset(myFile, V1=="Kucing Hitam")
group3 <- subset(myFile, V1=="Kucing Putih")
```

## 4b
```r
bartlett.test(Length~V1, data=dataoneway)

## 4c
```r
qqnorm(group1$Length)
qqline(group1$Length)

## 4d
Dari Hasil Poin C, Berapakah nilai-p ? , Apa yang dapat Anda simpulkan dari H0? Setelah di jalankan maka nilai p-value = 0.8054

## 4e
```r
model1 <- lm(Length~Group, data=myFile)

anova(model1)

TukeyHSD(aov(model1))
```
## 4f
```r
library(ggplot2)
ggplot(dataoneway, aes(x = Group, y = Length)) + geom_boxplot(fill = "grey80", colour = "black") + 
  scale_x_discrete() + xlab("Treatment Group") +  ylab("Length (cm)")
 ```
 
 ## Soal 5
 
 ### 5a
```r
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

```
![image](https://user-images.githubusercontent.com/99454377/170881849-332808cb-c369-4f93-87c2-8ee583a48432.png)

### 5b
```r
GTL$Glass <- as.factor(GTL$Glass)
GTL$Temp_Factor <- as.factor(GTL$Temp)
str(GTL)

anova <- aov(Light ~ Glass*Temp_Factor, data = GTL)
summary(anova)
```
![image](https://user-images.githubusercontent.com/99454377/170881921-736e86fb-309a-42a2-920e-452467f53223.png)

![image](https://user-images.githubusercontent.com/99454377/170881936-ead6e3ec-5bdb-43bd-8fd8-fe34dbfca19a.png)


## 5c
```r
data_summary <- group_by(GTL, Glass, Temp) %>%
  summarise(mean=mean(Light), sd=sd(Light)) %>%
  arrange(desc(mean))
print(data_summary)
```
![image](https://user-images.githubusercontent.com/99454377/170881799-4acf198c-cd4f-404a-b61e-6a94b251ea0a.png)


## 5d
```r
tukey <- TukeyHSD(anova)
print(tukey)
```
![image](https://user-images.githubusercontent.com/99454377/170881750-6983d868-b400-4e48-af73-399ab2be3d3f.png)

## 5e
```r
tukey.cld <- multcompLetters4(anova, tukey)
print(tukey.cld)

cld <- as.data.frame.list(tukey.cld$`Glass:Temp_Factor`)
data_summary$Tukey <- cld$Letters
print(data_summary)

write.csv("GTL_summary.csv")
```
![image](https://user-images.githubusercontent.com/99454377/170881688-c41c8118-9ce4-4f18-bb55-07fa29cd7e72.png)

![image](https://user-images.githubusercontent.com/99454377/170881714-3e42dbce-394f-47e0-be38-26f3b107dc23.png)


