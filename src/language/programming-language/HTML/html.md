```
scheme://host.domain:port/path/filename
    :scheme - 定义因特网服务的类型。最常见的类型是 http
    :host - 定义域主机（http 的默认主机是 www）
    :domain - 定义因特网域名，比如 w3school.com.cn
    :port - 定义主机上的端口号（http 的默认端口号是 80）
    :path - 定义服务器上的路径（如果省略，则文档必须位于网站的根目录中）。
    :filename - 定义文档/资源的名称
    
&nbsp;		&#160; 		不断行的空白（1个字符宽度）
&ensp; 		&#8194;		半个空白（1个字符宽度）
&emsp;		&#8195;		一个空白（2个字符宽度）
&thinsp; 	&#8201;		窄空白（小于1个字符宽度）
```

## 2. 标签

```html
<meta charset="utf-8">  // meta 属性标识了创作者和编辑软件。
<base href="" target="_blank"> // <base> 标签为页面上的所有链接规定默认地址或默认目标（target）

 // 页面结构
<header>定义页眉</header>
<footer>页脚</footer>
<nav></nav>	 // 定义导航链接的容器
<aside>元素页面主内容之外的某些内容(比如侧栏)</aside>
// 分为块元素和内联元素
<div>
    块元素
</div>
<span>内联元素</span>

// link
<link rel="stylesheet" type="text/css" herf="xx.css">
<style type="text/css"></style>  // 内部css
<script type="text/javascript" src="" charset="js字符编码"></script>

// 字体与线条
<hr>  // 水平线
<font></font>  // 设置字体
<basefont></basefont>  // 设置字体
<s></s>  <strike></strike>  // 定义删除线
<u></u>  // 定义下划线
<b></b>  // 粗体
<em></em>  // 注重体
<i></i>  // 斜体
<sup></sup>  // 上标字
<sub></sub>  // 下标
<ins>插入字</ins>
<del>删除字</del>

// 表格
<table border="1">  // 边框  <th>加粗表头</th>
    <tr>
    	<td></td>
    </tr>
</table>

<ol>
    <li>有序表格</li>
</ol>

<ul>
    <li>无序列表</li>
</ul>

// 边框&嵌套页面
<iframe src="" frameborder="0">
    网址， 边框
</iframe>
<frameset rows="25% 25% 50% 行" cols="25% 25% 50% 列" noresize="noresize设置边框不能改变大小">
    <frame src="a.htm"></frame>
	<frame src="a.htm"></frame>
	<frame src="a.htm"></frame>
</frameset>

// 表单 & Input
<form name="asd" action="a.php执行的动作" method="GET方法" target="_self" accept-charset="utf-8被提交表单中编码格式">
    <input type="text文本 radio单选 submit提交 password 密码" name="ads" value="初始值" maxlength="16" autofocus自动获得焦点 form="归属表单id" formaction="处理该表单的URL" patterm="用于检测的正则表达式" placeholder="提示文本" required规定为必填属性>
    <select name="下拉列表">
        <option value="键值">显示</option>
    </select>
    <textarea>多文本框</textarea>
    <button type="button" onclick="f()">
        按钮
    </button>
</form> 
```

## 3. 属性

```html
align="conter"  // 设置居中
color=""  // 
<body bgcolor="yellow" style="background-color: red"></body> // 背景色
<a name="锚" target="_blank"></a>  // 新窗口
background="background.jpg"
bgcolo="rgb(0,0,0)"
<img src="" alt="" align="">  // 通过align可设置浮动
```

[CSS]: https://www.w3school.com.cn/cssref/index.asp	"CSS"

# 二. CSS

```css
background-color: red  // 背景色
font-family: ariral;    color: red;    font-size: 20px  // 设置字体系列，颜色，尺寸，style 属性淘汰了旧的 <font> 标签
text-align: center;  // 属性规定了元素中文本的水平对齐方式

/*背景*/
background-color:  ;  // 设置背景色
opacity: 0.3;  // 设置不透明度(对子元素生效)
background: rgba(0,0,0,0.3);  // 不对子元素生效
background-image: url("");  // 设置背景图片
background-repeat: repeat-x (no-repeat);  // 设置重复
background-position: right top;  // 设置图像位置
background-attachment: fixed固定 scroll滚动;  // 设置图像时滚动还是固定
background-size: 80px 60px;  // 设置图片尺寸
:contain 把图像图像扩展至最大尺寸，以使其宽度和高度完全适应内容区域
:over    把背景图像扩展至足够大，以使背景图像完全覆盖背景区域(背景图像的某些部分也许无法显示在背景定位区域中)
background-clip: ;  // 规定背景的绘制区域
background: background-color background-image background-repeat
		   background-attachment background-position  // 简写

/*边框*/
border-style: ;  // 
border-width: 25px上 25em右 thin下 medium左 thick;  // 边框宽度
border-color: red; hex, rgb, HSL,  // 设置四个边框颜色
或者border-top-color: ;  // 单独设置各个边框
border: border-width border-style(必需) border-color;
border-radius: 5px;  // 圆角边框
margin: 50px;  // 设置外边框, 允许负值 auto使元素在其容器中水平居中
或者单独设置 margin-top: ;
padding: ;  // 设置内边框，也可以同时设置四个边
width: 300px;  // 指定元素内容区域的宽度
box-sizing: ;
height: ;  // 高  
width: ;  // 宽

/*外边框*/
margin:

/*轮廓*/

/*文本*/
color: ;  // 文本颜色
text-align: ;  // 规定元素中的文本的水平对齐方式
direction: ;  // 更改文本方向
unicode-bidi: ;  // 更改文本方向
vertical-align: ;  // 属性设置元素的垂直对齐方式
text-decoration: overline/line-through/underline;  // 设置或删除文本装饰
text-transform: uppercase/lowercase/capitalize;  // 将所有内容转换为大写或小写字母，或将每个单词的首字母大																				               写
text-indent: 50px;  // 设置文本缩进
letter-spacing: 3px;  // 设置字符之间的间距
line-height: 0.8;  // 行间距
text-shadow: 2px 2px red;  // 设置阴影效果

衬线字体（Serif）- 在每个字母的边缘都有一个小的笔触。它们营造出一种形式感和优雅感。
无衬线字体（Sans-serif）- 字体线条简洁（没有小笔画）。它们营造出现代而简约的外观。
等宽字体（Monospace）- 这里所有字母都有相同的固定宽度。它们创造出机械式的外观。
草书字体（Cursive）- 模仿了人类的笔迹。
幻想字体（Fantasy）- 是装饰性/俏皮的字体。
衬线字体(Serif
font-family: "", aa, "";  // 规定使用的字体
font-style: normal正常 italic斜体 oblique倾斜
font-weight: bold;  // 字体粗细
font-size: em或 61% 或 vm;  // 字体大小  pixels/16=em, vw单位设置文本大小，它的意思是“视口宽度”（"viewport width"）
font: font-style font-variant font-weight &font-size/line-height &font-family  // 简写
text-decoration: ;  // 文本装饰

/*超链接伪类*/
a:link - 正常的，未访问的链接
a:visited - 用户访问过的链接
a:hover - 用户将鼠标悬停在链接上时
a:active - 链接被点击时
list-style-type: circle、square、upper-roman、lower-alpha;  // 列表项目标记
list-style-image: url("");// 将图像指定为列表项标记
/*列表*/

/*向元素应用 2D 或 3D 转换。该属性允许我们对元素进行旋转、缩放、移动或倾斜*/
transform: translate(x,y);	/*定义 2D 转换。*/

/*裁剪图像的两边，保留长宽比，然后填充空间*/
object-fit: cover; /*调整被替换内容的大小，以在填充元素的整个内容框时保持其长宽比*/

/*生成的显示框类型*/
display: block; /*块级元素，前后会带有换行符(?)*/
```

[Canvas-JS-Web-API]: https://developer.mozilla.org/zh-CN/docs/Web/API/Canvas_API/Tutorial/Applying_styles_and_colors	"Canvas-JS-Web-API"

```js
// js通过Canvas绘图
var canvas = document.getElementById('canvas');
var ctx = canvas.getContext('2d');

ctx.direction = "ltr" || "rtl" || "inherit";  // 左到右，右到左，根据情况继承 <canvas> 元素或者 Document 
// 在绘制文本时，描述当前文本方向的属性

ctx.fillStyle = "colorName";  // 设置颜色、样式
ctx.fillStyle = gradient;
ctx.fillStyle = pattern;

ctx.filter = ...// 提供模糊、灰度等过滤效果的

ctx.font = '48ps serif';  // css字符串. 设置字体样式

ctx.fontKerning =  auto或normal或none ; // 字间距

void ctx.fillRect(x, y, width, height);  // 填充矩形
void ctx.fillText(text, x, y, [maxWidth]);  // 填充文字

void ctx.beginPath(); //通过清空子路径列表开始一个新路径的方法
void ctx.moveTo(x, y);  // 将新的子路径的起始点移到(x，y)
void ctx.lineTo(x, y);  // 用直线连接子路径的终点到 x，y 坐标的方法
void ctx.closePath();
/*将笔点返回到当前子路径起始点的方法。它尝试从当前点到起始点绘制一条直线。如果图形已经是封闭的或者只有一个点，那么此方法不会做任何操作。*/
void ctx.arc(x, y, radius, startAngle(圆弧的起始点), endAngle, anticlockwise(方向)); // 绘制圆弧路径的方法
void ctx.arcTo(x1, y1, x2, y2, radius);
/*根据当前描点与给定的控制点 1 连接的直线，和控制点 1 与控制点 2 连接的直线，作为使用指定半径的圆的切线，画出两条切线之间的弧线路径*/
void ctx.stroke();
void ctx.stroke(path); // 根据当前的画线样式，绘制当前或已经存在的路径的方法。

```