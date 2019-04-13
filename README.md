# Transform from scribble to painting
>這是一個將手繪圖鴉轉換為彩色圖畫的程式，程式內容主要分成前處理、相似度比較、組成與風格轉換四部份，相似度比較所使用的演算法是sparse coding
，而風格轉換則是用CNN。

## 開發環境
* OS: Ubuntu 18.04 LTS
* GPU: GTX 1060 6G
* CPU: i5-6700
* RAM: 16G

## 執行方法
### 第一步
請先到[這裡](https://drive.google.com/file/d/18jXHQcELDsqrhYOKPIz-lPKgGUoQCPHU/view?usp=sharing)下載training過得VGG模型，並將其放入matconvnet-1.0-beta24/styleTransfer的資料夾內，接著下載[caltech101](http://www.vision.caltech.edu/Image_Datasets/Caltech101/)的資料集，然後將它們全部解壓縮後放入cal101這個資料夾中

### 第二步
將你要的轉換的圖片轉為jpg格式後放入input的資料夾

### 第三步
打開matlab執行即可，若是使用者的作業系統為windows，則需要將檔案中有包含檔案路徑的地方改寫，要將'/'
改成'\\'


## 執行結果
執行結果都放在result這個資料夾中，thinning_result是thinning過後的結果，sel_reg則是componsation後的結果，region是指selective search
所選擇出來的區域，ranking則是caltech資料集中與region比對後最相近的前八名，final是最後完成的結果。下方則是目前完成的結果:
* origin
<img width="600" src="/input/image000.jpg"/></img>
* result
<img width="600" src="/result/final/image1_style4.png"/></img>
