 #Krlab/輪講
表色系(color specification system)とは，色を定量的に表す体系のことを指す．表色系には顕色系と混色系の2種類存在し，マンセル表色系は顕色系，CIE-RGP表色系やCIE-XYZ表色系は混色系である．

---
## マンセル表色系とは
マンセル標識系とは，米国の画家マンセルが，色相，明度，彩度の3属性で定義した色表示方法のことである．
- 色相
	- 色の違いを示す属性である．赤，黄，緑，青，紫の5種類を基本色相としてその中間にそれぞれ10等分することで全体を100色相とする．
- 明度
	- 各色相の明るさを示す属性である．黒を0段階，白を10段階とした11段階に等分割にして表現する．
- 彩度
	- 色の鮮やかさを示す属性である．各色相と明度ごとに無彩色から最も鮮やかな色までを等間隔で区切り，数字で表現する．


## CIE-RGB表色系
CIE-RGB表色系とは，赤，緑，青を原色とし，それを加法することによる色表示方法のことである．
測定対象からの反射光を $\textbf{C}$ , 原刺激を $\textbf{R, G, B}$ としてそれぞれの刺激値をR, G, Bとして混色したときに

$$
\begin{align*} 
\textbf{C} = R\textbf{R} + G\textbf{G} + B\textbf{B} \tag{1}
\end{align*}
$$

### 等色関数
すべての可視光は，これらの原色の特定の比率で混合することで表現できると考えられている．その混合比を示す関数が等色関数である．
等色関数とは，すべての可視光を表現するために原色の混合比を示す関数である．赤，緑，青のそれぞれの等色関数は $\bar{r}(\lambda)$, $\bar{g}(\lambda)$, $\bar{b}(\lambda)$　とする．ここでの $\lambda$ はR, G, Bの必要量(刺激値)を表す．
ここで，それぞれの等色関数を代入すると，
$$
\begin{align}
\textbf{U}(\lambda) = \bar{r}(\lambda)\textbf{R} + \bar{g}(\lambda)\textbf{G} + \bar{b}(\lambda)\textbf{B} \tag{2}
\end{align}
$$
 $\textbf{U}$とは，可視光の波長範囲で単位放射量を発行する仮想光のことである．また，反射光C を単一波長光として考え，三刺激値測定したものである．
この刺激値の分布を用いることで，反射光のCの分光エネルギー分布 $L(\lambda)$ から次のように三刺激値を求めることができる．
$$
\left\{ \tag{3}
\begin{align*} 
	R = \int_V L(\lambda)\bar{r}(\lambda)d\lambda\\
	G = \int_V L(\lambda)\bar{g}(\lambda)d\lambda\\
	B = \int_V L(\lambda)\bar{b}(\lambda)d\lambda
\end{align*}
\right.
$$
ここでの積分範囲 V は，可視光の波長範囲を表す．したがって，$\bar{r}(\lambda), \bar{g}(\lambda), \bar{b}(\lambda)$ が分かれば，任意の分光強度分布を持つ光の色彩を表すことができる．



## CIE-XYZ表色系
CIE-XYZ表色系とは，CIE-XYZ表色系と同時に採用された標準表色系である．CIE-RGB表色畏敬の等色関数では，負の値が存在するため，計算しづらかった．そこで，等色関数が非負となるようにCIE-RGB表色系の等色関数から線形変換によって求めた等色関数 $\bar{x}(\lambda), \bar{y}(\lambda), \bar{z}(\lambda)$ を用いて，三刺激値を求めて表現する．採用された原刺激 $\textbf{X, Y, Z}$ は R,G,Bを用いて表すと，以下のように定義する．

$$
\left\{ \tag{3}
\begin{pmatrix}
\textbf{X} \\
\textbf{Y} \\
\textbf{Z}
\end{pmatrix}
=
\begin{pmatrix}
0.41844 &  -0.09117 & 0.00092 \\
-0.15866 & 0.25242 & -0.00255 \\
-0.08283 & 0.01570 & 0.17858 \\
\end{pmatrix}
\right. 
$$
逆に，CIE-RGB表色系の原刺激 $\textbf{R, G, B}$ を，三刺激値であるX, Y, Zで表すと
$$
\left\{
\begin{pmatrix}
\textbf{R} \\
\textbf{G} \\
\textbf{B}
\end{pmatrix}
= 
\begin{pmatrix}
2.7689 & 1.0000 & 0.0000 \\
1.7517 & 4.5907 & 0.0565 \\
1.1302 & 0.0601 & 5.5943 \\
\end{pmatrix}
\right.
$$



CIE-XYZの表色系では等色実験によって三刺激値を測定することはできないが， CIE-RGBの三刺激値とCIE-XYZの三刺激値の座標変換によって求めることができる．以下の式がその座標変換である．
$$
\begin{pmatrix}\tag{4}
X \\
Y \\
Z
\end{pmatrix}
= 
\begin{pmatrix}
2.7689 & 1.7517 & 1.1302 \\
1.0000 & 4.5907 & 0.0601 \\
0.0000 & 0.0565 & 5.5943 
\end{pmatrix}
\begin{pmatrix}
R \\
G \\
B
\end{pmatrix}
$$


等色関数 $\bar{x}(\lambda), \bar{y}(\lambda), \bar{z}(\lambda)$ が分かっていれば，三刺激値X, Y, Zを求めることができる．
$$ \tag{5}
\left\{
\begin{align*}
X = \int_V L(\lambda)\bar(x)(\lambda)d\lambda \\
Y = \int_V L(\lambda)\bar(y)(\lambda)d\lambda \\
Z = \int_V L(\lambda)\bar(z)(\lambda)d\lambda
\end{align*}
\right.
$$


ここで，X, Y, Zを3軸とする直交座標を考えると，任意の色Cは3次元ベクトルで表現できる．
このベクトルは色度座標と呼び，3刺激値を用いて以下で表現できる．
$$
\left\{ \tag{6}
\begin{align*}
	x = \dfrac{X}{X + Y + Z} \\
	y = \dfrac{Y}{X + Y + Z} \\
	z = \dfrac{Z}{X + Y + Z} 
\end{align*}
\right.
$$

このとき，$x  + y + z = 1$ が成り立つため，3次元座標から2次元座標(x, y)に変換することができる．これをxy色度図と呼ぶ．
xy色度図の各変数は次のような意味合いを持つ．
- x が大きいほど赤が強く，xが小さいほど青が強い
- y が大きいほど緑が強く，yが小さいほど青が強い

## CIE-L * a * b * 色空間
CIE-L * a * b * 色空間とは，均等空間の一種であり，異なる2色の色がどの程度似ているのか，どの程度異なっているかを数値化するために用いる．
この色空間は三刺激値(X, Y, Z)で均等色空間を近似することを目的としており，L*, a*, b* の直交座標系で定義されている．
- L* は明度を示す．0が黒で100に対応している．
- a* は色の赤みと緑の度合いを示す．値が大きいほど赤みが強く，値が小さいほど緑みが強くなる．
- b* は色の黄みと青みの度合いを示す．値が大きいほど黄みが強く，値が小さいほどみ青みが強くなる．
$$
\left\{ \tag{7}
\begin{align}
	L* &= 116f\left(\frac{Y}{Y_n}\right)-16 \\
	a* &= 500\left(f\left(\dfrac{X}{X_n}\right) - f\left(\dfrac{Y}{Y_n}\right)\right) \\
	b* &= 200\left(f\left(\dfrac{Y}{Y_n}\right) - f\left(\dfrac{Z}{Z_n}\right)\right) \\
\end{align}
\right.
$$
この関数$f$は以下のように定義されている．
$$ \tag{8}
f(\alpha) =
\left\{
\begin{align}
&\alpha^{\frac{1}{3}}, & \alpha > \left(\frac{24}{116}\right)^3 \\
&(\frac{841}{108})\alpha + \frac{16}{116} &\alpha \leqq \left(\frac{24}{116}\right)^3
\end{align}
\right.
$$
また，$X_n, Y_n, Z_n$ は，対象と同一照明下の完全拡散反射面に対する三刺激値である．この色空間では，$(L^*_1, a^*_1, b^*_1)$ と $(L^*_2, a^*_2, b^*_2,)$ の2色間の色差 $\Delta$ は，ユークリッド距離として，以下のように計算することができる．
$\Delta = [(L^*_1- L^*_2)^2 + (a^*_1 -  a^*_2)^2 + (b^*_1 - b^*_2)^2]^{1/2}$ 

## sRGB色空間
sRGB色空間とは，デバイス独立色の色空間の一種類．
以下の4つの刺激が定義されている．
- $\textbf{R}$ = (0.6400, 0.3300)
- $\textbf{G}$ = (0.3300, 0.6000)
- $\textbf{B}$ = (0.3127, 0.3290) = (標準光$D_{65}$)

sRGB色空間からCIE-XYZの三刺激値に変換する方法を示す．
(9)は，sRGBの非線形の電気信号 $E'$ から線形な光の強度 $E$ への変換を行う．
$$ \tag{9}
\begin{align*}
E'_{sRGB} &= \frac{E'_{8bit}}{255.0} \\
E_{sRGB} &=
\begin{cases}
\dfrac{E'_{sRGB}}{12.92} & E'_{sRGB} \leqq 0.04045 \\
\left(\dfrac{E'_{sRGB} + 0.055}{1.055}\right)^{24} &E'_{sRGB} > 0.4045
\end{cases}
\end{align*}
$$
また，CIE-XYZ表色系の三刺激値に変換すると
$$ \tag{10}
\begin{pmatrix}
X \\
Y \\
Z \\
\end{pmatrix}
=
\begin{pmatrix}
0.4124 & 0.3576 & 0.1805 \\
0.2126 & 0.7152 & 0.0722 \\
0.0193 & 0.1192 & 0.9505 
\end{pmatrix}
\begin{pmatrix}
R_{sRGB} \\
G_{sRGB} \\
B_{sRGB}
\end{pmatrix}
$$
逆に，CIE-XYZ表色系の三刺激値からsRGB色空間に変換する方法を以下に示す．
$$ \tag{11}
\begin{pmatrix}
R_{sRGB} \\
G_{sRGB} \\
B_{sRGB}
\end{pmatrix}
=
\begin{pmatrix}
3.2406 & -1.5372 & -0.4989 \\
-0.9689 & 1.8578 & 0.0415 \\
0.0557 & -0.2040 & 1.0570 \\
\end{pmatrix}

\begin{pmatrix}
X \\
Y \\
Z \\
\end{pmatrix}
$$

$\gamma = 2.2$ に対するガンマ補正を行い，0から255までの8ビット
線形なsRGB値 $E_{sRGB}$から非線形な8bit値$E'_{8bit}$への変換を行う．
$$ \tag{12}
\begin{align*}
E'_{sRGB} &=
\begin{cases}
12.92 E_{sRGB} & E_{sRGB} \leqq 0.0031308 \\
1.055 E_{sRGB}^{\frac{1}{2.4}} - 0.055 & E_{sRGB} > 0.0031308 \\
\end{cases} \\
E'_{8bit} &=255.0E'_{sRGB}
\end{align*}
$$
## 輝度信号と色差信号
人間の目は，色の変化よりも明るさの変化に対して敏感である．そのため，輝度成分はそのまま保持し，色の情報については情報を減らしたりしても，視覚的な劣化を知覚しづらいという特性を持つ．テレビ放送でもRGB値を輝度成分と色差成分に変換している．
これを利用した変換の1つがYUV変換である．
- Yは明るさを表す輝度信号
- Uは青みと輝度成分の差を表す．値が大きいと青みが強く，小さいほど黄色みが強くなる
- Vは赤色と輝度成分の差を表す．値が大きいと赤みが強く，小さいほど緑みが強くなる
$$ \tag{13}
\begin{cases}
Y &= 0.299R' + 0.587G' + 0.114B' \\
U &= 0.492(B' - Y) = 0.147R' - 0.289G' + 0.436B' \\
V &= 0.877(R' - Y) = 0.615R' - 0.515G' - 0.100B' \\
\end{cases}
$$

この色空間は，基本となる赤，緑，青の光の色合いと基準となる白の色合いをxy色度変換という方法で定義している．また，これらの原色を用いて色を表すRGB値は$\gamma = 2.2$ という特性でガンマ補正されており，0 ~ 1までの値をとる．
$$ \tag{14}
\begin{align*}
	\textbf{R} &= (0.6400, 0.3300) \\
	\textbf{G} &= (0.2900, 0.6000) \\
	\textbf{B} &= (0.1500, 0.0600) \\
	\textbf{W} &= (0.3127, 03290) (\text{標準光}D_{65})
\end{align*}
$$
YCbCr変換は，YUV変換と似ているが色差信号の信号が異なる．
YUV変換では負の値を含むことがあるため，デジタル環境での扱いやすさを考慮して，負の値を含まないようにオフセットしている．
静止画像の代表的な圧縮フォーマットであるJPEGは以下のような方法で変換している．
この式は，RGB値からYCbCr変換を行っている．

$$ \tag{15}
\begin{cases}
Y &= 0.299R' + 0.587G' + 0.114B' \\
C_b &= 0.564(B' - Y) = -0.169R' - 0.331G' + 0.500B' \\
C_r &= 0.713(R' - Y) = 0.500R' - 0.419G' -0.081B'
\end{cases}
$$
sRGB値からのYCbCr変換は以下のような式で求めることができる．
$$ \tag{16}
\begin{cases}
Y &= 02126R' + 07152G' + 0.0722B' \\
G &= 0.5389(B' - Y) = -0.1146R' - 0.3854G' + 0.5000B' \\
B &= 0.6350(R' - Y) = 0.5000R' - 0.4542G' - 0.0458B'
\end{cases}
$$
## HSI変換と逆変換
HSI変換とは，色相・彩度・明度を座標軸とする変換のことである．この変換を用いることでRGB値では色の濃さと画像の明るさが連動してしまうという問題点があったが，HSI変換を用いることで画像の明るさと彩度を別で変更させたい場合はHSI変換を用いることで解決する．

### 6角錐モデル
このモデルのHSI変換は以下の通りとなっている．
- Sは $I_{max} - I_{min}$ をとることで色の成分間ばらつきを計算し，$I_{max}$で割ることで，0  ~ 1の間に正規化している．
$$
\begin{align*}
I_{max} &= max\{R, G, B\}, ~~ I_{min} = min\{R, G, B\} \\
I &= I_{max} \\
S &= (I_{max} - I_{min}) / I_{max}) \\

H &= 
\begin{cases}
\dfrac{G - B}{I_{max} - I_{min}}\dfrac{\pi}{3} & (I_{max} = R) \\
\dfrac{B - R}{I_{max} - I_{min}}\dfrac{\pi}{3} + \dfrac{2}{3}\pi & (I_{max} = G) \\
\dfrac{R - G}{I_{max} - I_{min}}\dfrac{\pi}{3} + \dfrac{4}{3}\pi & (I_{max} = B)
\end{cases}
\end{align*}

$$
これの逆変換について以下のようになる．
$$
(R,G,B) = 
\begin{cases}
(I, T, P) & (h = 0) \\
(Q, I, P) & (h = 1) \\
(P, I, T) & (h = 2) \\
(P, Q, T) & (h = 3) \\
(T, P, I) & (h = 4) \\
(I, P, Q) & (h = 5) \\
\end{cases}
$$
各値は以下のように表現することができる
$$
\begin{align*}
h &= floor(\dfrac{3}{\pi}H) \\
P &= I(1 - S) \\
Q &= I(1 - S(\dfrac{3}{\pi}H - h)) \\
T &= I(1  - S(1 - \dfrac{3}{\pi} H + h)) \\
\end{align*}
$$
$$
\begin{align*}
&H = 2\pi = 0 \\
&0 \leqq R, G, B, S, I \leqq 1 \\
&0 \leqq H < 2\pi
\end{align*}
$$

### 双6角錐モデル
6角錐モデルをより精密にしたもの．デザイン分野で利用されるオズワルド表色系に地下い．
$$
\begin{align*}
I_{max} &= max\{R, G, B\}, ~~ I_{min} = min\{R, G, B\} \\
I &= I_{max} + I+{min} / 2 \\
S &= 
\begin{cases}
\dfrac{I_{max} - I_{min}}{I_{max} + I_{min}} &(I \leqq 0.5)\\
\dfrac{I_{max} - I_{min}}{2 - (I_{max} + I_{min})} &(I >0.5)\\
\end{cases}
\\
H &= 
\begin{cases}
\dfrac{G - B}{I_{max} - I_{min}}\dfrac{\pi}{3} & (I_{max} = R) \\
\dfrac{B - R}{I_{max} - I_{min}}\dfrac{\pi}{3} + \dfrac{2}{3}\pi & (I_{max} = G) \\
\dfrac{R - G}{I_{max} - I_{min}}\dfrac{\pi}{3} + \dfrac{4}{3}\pi & (I_{max} = B)
\end{cases}
\end{align*}
$$

逆変換は，以下のようになる
$$
\begin{aligned}
R &= X & (h = H + \frac{2}{3}\pi) \\
G &= X & (h = H) \\
B &= X & (h = H - \frac{2}{3}\pi)
\end{aligned}
$$

X は h に応じて以下のように求めることができる．
$$
\begin{align*}
h' &=
\begin{cases}
	h \\
	h + 2 \pi & (h < 0) \\ 
	h - 2 \pi & (h > 2\pi) \\
\end{cases}
\\
M_2 &= 
\begin{cases}
	I(1 + S) & (I \leqq 0.5) \\
	I + S - IS & (I > 0.5) \\
\end{cases}
\\
M_1 &= 2I - M_2 \\
X &= 
\begin{cases}
M_1 + (M_2 - M_1) \dfrac{3}{\pi}h' & (h' < \dfrac{3}{\pi}) \\
M_2 & (\dfrac{3}{\pi} \leqq h' < \pi) \\
M_1 + (M_2 - M_1)(4 - \dfrac{3}{\pi}h') & (\pi \leqq h' < \dfrac{4}{3}\pi) \\
M_1 & (\dfrac{4}{3}\pi \leqq h' \leqq 2\pi)
\end{cases}
\end{align*}
$$