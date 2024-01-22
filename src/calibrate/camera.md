> 相机标定

## 一. 棋盘格

注意事项: 

- 一般需要标定板`rows`、`cols`时都是指内角点 -> 两黑色格子的脚垫
- 标定板的内角点个数，行和列一般有一个是奇数一个是偶数，便于标定时区分出宽高

## 二. 输入 & 标定结果

***输入与标定结果的形式一定要参照官方文档***

### 1. `OpenCV`

官网: 

- https://docs.opencv.org/5.x/

- https://docs.opencv.org/5.x/da/d35/group____3d.html#ga549c2075fac14829ff4a58bc931c033d

 (该形式是 `cv::solvePnP` `cv::calibrateCamera` 的形式)

`Intrinsic Matrix`:

```
fx 0   cx
0  fy  cy
0  0   1
```

`Distortion`

```
k1 k2 p1 p2 [k3 [k4 k5 k6 [s1 s2 s3 s4 [τx τy]]]]  # 4 OR 5 OR 8 OR 12 OR 14
```

### 2. `Matlab`

官网: 

- https://ww2.mathworks.cn/help/vision/ref/cameraparameters.html

`Intrinsic Matrix`: (注意`Matlab`的工具箱标定出的`Intrinsic Matix`是转置之后的结果, 即需要将标定结果转置之后才是下方给出的形式)

```
fx s   cx
0  fy  cy
0  0   1
```

`Radial Distortion`: (径向畸变)

```
k1 k2 [k3]    # 2 OR 3
```

`Tangential Distortion`: (切向畸变)

```
p1 p2
```

#### 3. `kalibr`

官网: 

- https://github.com/ethz-asl/kalibr/wiki/supported-models

`Intrinsic Matrix`

```
fu fv pu pv    # pinhole models
```

`Distortion`

```
k1 k2 r1 r2    # radtan models
```

