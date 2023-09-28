> python 鼠标键盘自动化(3rdlib)

# 0. 安装

PyAutoGUI依赖于pyscreeze、pymsgbox、pytweening

```bash
python -m pip install -U pyautogui
```

# 一. 函数API

```python
import pyautogui

pyautogui.size()  # 获取屏幕尺寸

pyautogui.position()  # 获取鼠标位置

pyautogui.onScreen(x, y)  # 判断坐标是否在某一屏幕范围内
```

## 1.1 鼠标

```python
# 移动
# 移动到...(绝对位置移动), 鼠标移动过渡时间duration设为1秒
pyautogui.moveTo(sizex/2,sizey/2,duration=1)
# 移动...(相对位置移动)，鼠标移动过渡时间duration设为0.5秒
pyautogui.moveRel(100, -200, duration=0.5)


# 点击
# 移动至...并点击(左键)，过渡时间0.5秒
pyautogui.click(sizex/2,sizey/2, duration=0.5)

# 当前位置点击(右键)
pyautogui.click(button='right')

# 移动至...点击3次左键，点击间隔0.1s，鼠标移动过渡时间0.5秒
pyautogui.click(100,100, clicks=3,interval=0.1,duration=0.5)

# 移动至(100,100)点击2次右键，点击间隔0.5s，鼠标移动过渡时间0.2秒
pyautogui.click(100,100, clicks=2,interval=0.5,button='right',duration=0.2)


# 滚动
# 鼠标位置不动，向上回滚2个单位(项目文档对滚动量参数说明不详)
pyautogui.scroll(2)

# 鼠标移动至(1000,700)，前下滚动10个单位
# 运行发现鼠标并没有动
pyautogui.scroll(-10,1000,700)


# 鼠标拖曳
# 将鼠标从当前位置拖至...，默认左键
pyautogui.dragTo(sizex/2,sizey/2)

# 将鼠标从当前位置向左100像素、向右200像素拖动，过渡时间0.5秒，指定右键
pyautogui.dragRel(-100,200,duration=0.5,button='right')
```

## 1.2 键盘

```python
keyDown()  # 按下
keyUp()  # song'kai
# 键名用字符串表示，支持的所有键名
# 存在pyautogui.KEYBOARD_KEYS变量中，包括26个字母、数字、符号、F1~F20、方向等等所有按键
# 程序向终端输入了字符a，若程序运行时输入法为中文状态，由于没有继续输入空格或回车，输入法仅列出候选字，并不会输入到终端
pyautogui.press('a') # 按字母A键，字母支持大小写

# 传入键名列表（按键p、按键y、空格），按键之间间隔0.1秒（默认0）
 pyautogui.press(['p','y','space'], interval=0.1)

# typewrite[1]：传入字符串，不支持中文字符，因为函数无法知道输入法需要什么按键才能得到中文字符
pyautogui.typewrite('hello, PyAutoGUI!\n')
# typewrite[2]：传入键名列表，按键之间间隔0.1秒（默认0）
pyautogui.typewrite(['s','r','f','space'], interval=0.1)

# 按下组合键
# (参数是任意个键名，而非列表)
pyautogui.hotkey('ctrl', 'shift', 'esc') #调出任务管理器
pyautogui.hotkey('alt','ctrl','delete') # 并未调出重启界面
```

## 1.3 消息窗口

以JavaScript风格函数提供消息框功能，包括`alert()`、`confirm()`、`prompt()` 、`password()`，连参数都是一致的

```python
# 提示、警告. 点击的按键被返回
pyautogui.alert(text='警告',title='PyAutoGUI消息框',button='OK')

# 选择. 点击的按键被返回
pyautogui.confirm(text='请选择',title='PyAutoGUI消息框',buttons=['1','2'])

# 输入框. 点OK按钮后返回输入内容
pyautogui.prompt(text='请输入',title='PyAutoGUI消息框',default='请输入')

# 密码输入框. 点OK按钮后返回输入内容
pyautogui.password(text='输入密码',title='PyAutoGUI消息框',default='',mask='*')
```

## 1.4 截图相关

screenshot()`函数进行屏幕截图，返回是`Image`对象，这是在`Pillow`库中定义的
因此需要安装`Pillow库才能正常工作。

```python
pyautogui.screenshot(imageFilename, region)
"""
imageFilename: 截图要保存的文件全路径名. normol=None，不保存；
region: 截图区域，由左上角坐标、宽度、高度4个值确定. normol=None,截全屏
如果指定区域超出了屏幕范围，超出部分会被黑色填充
"""
In [41]: pyautogui.screenshot('shot.png',region=(1000,600,600,400))
Out[41]: <PIL.Image.Image image mode=RGB size=600x400 at 0x20C87497390>
```

## 1.5 图片匹配功能

在屏幕按像素匹配，定位图片在屏幕上的坐标位置
`locateOnScreen()`函数返回`region`对象 ->> 左上角坐标、宽度、高度4个值组成的元组，
再用`center()`函数计算出中心坐标

`locateCenterOnScreen()`函数则一步到位，返回中心坐标。

如果把需要点击的菜单、按钮事先保存成图片，可以用来自动查找菜单、按钮位置，再交由`click()`函数控制鼠标去点击。

```python
locateOnScreen(imageFilename, ...)
# @return: region对象 ->> 左上角坐标、宽度、高度4个值组成的元组，
# 再用center()函数计算出中心坐标

locateCenterOnScreen(imageFilename, ...)
# 函数则一步到位，返回中心坐标。

loc = pyautogui.locateCenterOnScreen("icon_xx.png", region=(0, 0,sizex/2, sizey/10) ) 
# region参数限制查找范围，加快查找速度
pyautogui.moveTo(*loc, duration=0.5) # 移动鼠标
pyautogui.click(clicks=1) #点击
```