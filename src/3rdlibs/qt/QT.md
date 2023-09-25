# 零. 类型转化

## 0.1 QString -><- wchar_t

```cpp
QString -> wchar_t*
QString qstr = "qstr";
const wchar_t* wstr = reinterpret_cast<const wchar_t *>(qstr.utf16());
    
wchar_t* -> QString
QString str = QString::fromWCharArray(wchar_t w);
```



## 0.2 QString -><- char*

```c++
char* -> QString
char* ch = "a";
QString qst(ch);
// 或者
QString qst = QString::fromUtf8(ch);
/**************************************************************************************************/
QString -> char*
Qstring  qst;
char*  ch;
QByteArray ba = qst.toLatin1();  // QByteArray ba = str.toUtf8();  如果有中文    
ch=ba.data();

QString  qst; // ? 
std::string str = qst.toStdString(); // ?
const char* ch = str.c_str();  // ?
```

## 0.3 QString -><- string

```c++
// 1.QString -> String
string s = qstr.toStdString();

// 2.String -> QString
QString qstr2 = QString::fromStdString(s);
```

## 0.4 string -><- char

```c++
string -> char
char* c = string::c_str();
```

## 0.5 QString -><-int

```c++
int i = 1;
QString s = QString::number(i);

QString("0").toInt(); // 可以指定基数 (是否成功的标志bool*, 基数 int) --> (nullptr, 10);
```



# 一. 组件

## 1. 按钮

# 二. 对话框

## 2.1 模态对话框

模态对话框 : 
指如果程序有多个对话框，当模态对话框弹出时，其他的对话框都无法操作(想操作其他对话框，必须先把模态对话框关闭)

QDialog::exec()函数，把对话框变成模态对话框。

```c++
QDialog dialog(this);
dialog.exec();  // 变成模态对话框
```

## 2.2 非模态对话框

非模态对话框 : 与这个非模态对话框交互的同时也可以与同一程序的其他窗口交互。

QDialog::show() 显示非模态对话框

```c++
QDialog *dialog = new Qdialog(this);
dialog->show();  // 显示非模态对话框
```

## 2.3 标准对话框

### 2.3.1 颜色对话框

静态函数 返回值是一个颜色变量 QColorDialog::getColor(设置初始颜色,指定父窗口,设置对话框标题)
来获取颜色 函数的，如果在颜色对话框里取消选择，则返回的颜色值无效，可以使用QColor::isValid()判断返回值。

```c++
//返回值是一个颜色变量 QColorDialog::getColor(设置初始颜色,指定父窗口,设置对话框标题);

#include <QColorDialog>
QColor color = QColorDialog::getColor(initColor,this,"select color");
QColor::isValid(); // 判断返回值
```

### 2.3.2 文件对话框

静态函数 QFileDialog::getOpenFileName()，模态对话框，选择文件点击“打开”后，函数会返回选择的文件名。
QFileDialog::getOpenFileName()使用时需要4个参数，分别是：指定父窗口，设置对话框标题，指定默认打开的目录，设置文件类型过滤器，如果不指定文件过滤器，则默认选择所有类型的文件。还可以设置多个过滤器，过滤器之间使用两个分号";;"隔开。

```c++
/**
 * 返回选择的文件名 QFileDialog::getOpenFileName(, , , );
 * @param: this 父窗口
 * @param: this 对话框标题
 * @param: this 父默认打开的目录
 * @param: this 文件类型过滤器; 默认选择所有类型的文件
 * 多个过滤器之间使用两个分号";;"隔开
 */
#include <QFileDialog>
QString str = QFileDialog::getOpenFileName(
    this,  // 父窗口
    "open file",  // 对话框标题
    "/",  // 默认打开的目录
    "text file(*.txt);;C file(*.cpp);;All file(*.*)"  // 文件类型过滤器
);

// 将返回用户选择的现有目录，如果用户按下“取消”，则返回空
QString QFileDialog::getExistingDirectory(
    QWidget *parent = nullptr,  //  父窗口
    const QString &caption = QString(), // 标题
    const QString &dir = QString(),  // 默认打开目录
    QFileDialog::Options options = ShowDirsOnly // 文件类型过滤器？
); 
QString dir = QFileDialog::getExistingDirectory(
    this, 
    tr("Open Directory"),
    "/home",                                       
    QFileDialog::ShowDirsOnly | QFileDialog::DontResolveSymlinks
);
```



# 二. 信号与槽

## 简介

在头文件中声明信号：

```c++
signals:
    void signalShowText();
```

在头文件中声明槽：

```c++
private slots:
    void showText();
```

在源文件中绑定信号与槽：

```c++
connect（pushButton,SIGNAL(clicked()),this,SLOT(showText()));
connect(push_button, &QPushButton::clicked, this, &exit);
```

在源文件中定义showText()函数，运行程序，点击pushButton 按钮就可以执行定义的槽

```c++
void MainWindow::showText(){
    lineEdit->setText("Push button is clicked.");
}
```

## connent()第五个参数

1. 自动连接(AutoConnection)：默认的连接方式。如果信号与槽，也就是发送者与接受者在同一线程，等同于直接连接；如果发送者与接受者处在不同线程，等同于队列连接。

2. 直接连接(Direct Connection)：当信号发射时，槽函数将直接被调用。无论槽函数所属对象在哪个线程，槽函数都在发射者所在线程执行。

3. 队列连接(Queued Connection)：当控制权回到接受者所在线程的事件循环式，槽函数被调用。槽函数在接收者所在线程执行。

4. Qt::BlocakingQueuedConnection: 与QueuedConnection类似但是信号线程会阻塞直到槽函数执行完毕(  当信号与槽函数是在同一个线程时不能使用，会造成死锁)

# 三. 布局

## 1. 箱布局

QBoxLayout类有两个子类，
		水平布局管理器 QHBoxLayout  
		垂直布局管理器 QVBoxLayout

### 1.1 水平布局

```c++
#include <QHBoxLayout>      // 用于水平布局的类
#include <QVBoxLayout>      // 用于垂直布局的类

QHBoxLayout *hlayout = new QHBoxLayout;
QVBoxLayout *layout = new QVBoxLayo;

hlayout->addWidget(button1);  // 添加组件
hlayout->addLayout(hlayout);  // 添加布局管理器
void QBoxLayout::setSpacing(int Spacing);  // 设置组件之间的间隔
void QBoxLayout::addStretch(int stretch = 0)  // 设置一个占位空间
void QLayout::setContentsMargins(int left, int top, int right, int bottom); //设置布局管理器到边界的距离。
this->setLayout(hlayout);  // 设置 整体窗口 页面布局

// 设置窗口为固定尺寸，sizeHint()函数的作用是保持窗口为理想大小的尺寸↓
this->setFixedSize(sizeHint()); // ←设置后页面大小不可调整，一直处于系统推荐大小的状态


```



### 1.2 垂直布局

## 2. 

## 3. 表单布局

```c++
#include <QLineEdit>        // 用于创建行文本框的类
#include <QFormLayout>      // 用于表单布局的类
// 创建行文本框
nameLineEdit = new QLineEdit();
emailLineEdit = new QLineEdit();
// [6]创建表单页面布局管理对象
QFormLayout *formLayout = new QFormLayout;
formLayout->addRow(tr("&Name:"), nameLineEdit);
formLayout->addRow(tr("&Email:"), emailLineEdit);
```

# xx. QMainWidget

参考网址: https://blog.csdn.net/qq769651718/article/details/79357912

## xx.1 菜单栏

### xx.1.1 添加菜单栏

```C++
/*
通过QMainWindow::MenuBar()获取QMenuBar对象的指针
如果该对象不存在, 就新建一个对象(只能创建一个菜单栏)
函数原型如下:
*/
QMenuBar* QMainWindow::menuBar();

// 也可以
QMenuBar* menu_bar = new QMenuBar;
this->setMenuBar(menu_bar);

```

### xx.1.2 添加菜单

```c++
QAction* QMenBar::addMenu(QMenu* menu);
QMenu* QMenBar::addMenu(const QString & title);
// 例:
QMenu* file_menu = new QMenu("文件(&F)", menu_bar);
menu_bar->addMenu(flie_menu);

QMenu* editMenu = menu_bar("编辑(&E)");
```

### xx.1.3 添加动作

动作，在Qt里面对应的类是QAction，继承至QObject，QMenu::addAction来添加动作

```c++
// QMenu::addAction() 来添加动作
 
QAction* addAction(const QString &text)
QAction* addAction(const QIcon &icon, const QString &text)
QAction* addAction(const QString &text, const QObject *receiver, const char *member, const QKeySequence &shortcut = 0)
QAction* addAction(const QIcon &icon, const QString &text, const QObject *receiver, const char *member, const QKeySequence &shortcut = 0)
```

### xx.1.4 添加分隔符

```c++
QAction *QMenu::addSeparator()
```

### xx.1.5 添加子菜单

菜单中添加一个子菜单,调用QMenu::addMenu()

```c++
QAction *QMenu::addMenu(QMenu *menu)     //添加一个已经创建好的QMenu对象
QMenu *QMenu::addMenu(const QString &title) //给定菜单标题，自动创建QMenu对象
```

## xx.2 工具栏 ( QToolbar )

QToolbar继承至QWidget

### xx.2.1 添加工具栏

QMainWindow::addToolBar() 添加工具栏

```c++
QToolBar *QMainWindow::addToolBar(const QString &title) //创建一个窗口标题为title的工具栏
void QMainWindow::addToolBar(QToolBar *toolbar) //添加一个已经存在的toolbar对象
void QMainWindow::addToolBar(Qt::ToolBarArea area, QToolBar *toolbar)
//添加一个已经存在的toolbar对象到指定区域，Qt::ToolBarArea是工具栏位置的枚举类型。
```

### xx.2.2 添加动作

QToolBar::addAction()

```c++
QAction *QToolBar::addAction(const QString &text)
QAction *QToolBar::addAction(const QIcon &icon, const QString &text)
QAction *QToolBar::addAction(const QString &text, const QObject *receiver, const char *member)
QAction *QToolBar::addAction(const QIcon &icon, const QString &text, const QObject *receiver, const char *member)
```

# 四. Qt 操作JSON

Qt: https://blog.csdn.net/cpp_learner/article/details/118421096

C++: https://blog.csdn.net/shuiyixin/article/details/89330529

QT编译器需要在.pro文件中 QT += Cor

需要用到的类:
QJsonDocument    读写JSON文档
QJsonObject          封装JSON对象
QJsonArray  		  封装JSON数组
QJsonValue 	      封装JSON值 int，float，double，bool，{ }，[ ]等
QJsonParseError  报告JSON处理过程中出现的错误

头文件
#include < QJsonObject > // { }
#include < QJsonArray > // [ ]
#include < QJsonDocument > // 解析Json
#include < QJsonValue > // int float double bool null { } [ ]
#include < QJsonParseError >=

## 4.1 封装

### 4.1.1 { }

```c++
"interest": {
	"basketball": "篮球",
	"badminton": "羽毛球"
},
// 定义 { } 对象
QJsonObject json_obj;
// 插入元素，对应键值对
json_obj.insert("basketball", "篮球");
json_obj.insert("badminton", "羽毛球");
```

### 4.1.2 [ ]

```c++
"color": [ "black", "white"],
// 定义 [ ] 对象
QJsonArray colorArray;
// 往数组中添加元素
colorArray.append("black");
colorArray.append("white");
```

### 4.1.3 [ { } ]

```c++
{
    "like": [
	{ "game": "三国杀", "price": 58.5 },
	{ "game": "海岛奇兵", "price": 66.65 }
]
}

// 定义 { } 对象
QJsonObject likeObject1;
likeObject1.insert("game", "三国杀");
likeObject1.insert("price", 58.5);

QJsonObject likeObject2;
likeObject2.insert("game", "海岛奇兵");
likeObject2.insert("price", 66.65);

// 定义 [ ] 对象
QJsonArray likeArray;
likeArray.append(likeObject1);
likeArray.append(likeObject2);

```

### 4.1.4 定义根节点(即最外层) { }

```c++
// 定义根节点	也即是最外层 { }
QJsonObject rootObject;

// 插入到跟节点{ }中
// 插入元素
rootObject.insert("name", "老王");
rootObject.insert("age", 26);
rootObject.insert("interest", interestObj);
rootObject.insert("color", colorArray);
rootObject.insert("like", likeArray);
rootObject.insert("languages", languages);
rootObject.insert("vip", true);
rootObject.insert("address", QJsonValue::Null);
```

### 4.1.5 QJsonDocument对象

```c++
QJsonDocument doc;  // 将json对象里的数据转换为字符串
doc.setObject(rootObject);  // 将object设置为本文档的主要对象
```

## 4.2 写入

```c++
QFile file("../Json/js.json");
if (!file.open(QIODevice::WriteOnly | QIODevice::Truncate)) 
{
	qDebug() << "can't open error!";
	return;
}
QTextStream stream(&file);
stream.setCodec("UTF-8");		// 设置写入编码是UTF8
// 写入文件
stream << doc.toJson();
file.close();
```

## 4.3 类型判断相关成员方法

```c++
bool isArray() const	// 是否为json数组
bool isBool() const	    // 是否为布尔类型
bool isDouble() const	// 是否为浮点类型
bool isNull() const	    // 是否为空
bool isObject() const	// 是否为json对象
bool isString() const	// 是否为字符串类型
```

## 4.4 读取

```c++
QFile file("../Json/js.json");
if (!file.open(QFile::ReadOnly | QFile::Text)) 
{
	qDebug() << "can't open error!";
	return;
}
// 读取文件的全部内容
QTextStream stream(&file);
stream.setCodec("UTF-8");		// 设置读取编码是UTF8
QString str = stream.readAll();

file.close();
```

## 4.5 将字符串解析成QJsonDocument对象

```c++
// QJsonParseError类用于在JSON解析期间报告错误。
QJsonParseError jsonError;
// 将json解析为UTF-8编码的json文档，并从中创建一个QJsonDocument。
// 如果解析成功，返回QJsonDocument对象，否则返回null
QJsonDocument doc = QJsonDocument::fromJson(str.toUtf8(), &jsonError);
// 判断是否解析失败
if (jsonError.error != QJsonParseError::NoError && !doc.isNull()) {
	qDebug() << "Json格式错误！" << jsonError.error;
	return;
}

```

# 五. QThread

### 5.1.0 线程同步

https://blog.csdn.net/m0_46577050/article/details/122231627

```c++
QMutex;
QMutex::lock();

QMutexLocker locker(&lock);  // 析构函数中自动unlock()
locker.unlock();
locker.mutex();
---
QReadWriteLock rw_lock;
rw_lock.lockForWrite();

QWriteLocker;
QReadWriteLock;
---
// 主线程
mutex.lock();
Send(&packet);
condition.wait(&mutex); 
if (m_receivedPacket)
    HandlePacket(m_receivedPacket); // 另一线程传来回包
mutex.unlock();

// 通信线程
m_receivedPacket = ParsePacket(buffer);  // 将接收的数据解析成包
mutex.lock();
condition.wakeAll();
mutex.unlock();

```



### 5.1.1 QThread 类常用 API

```c++
// 构造函数
QThread::QThread(QObject *parent = Q_NULLPTR);
// 线程中的任务是否处理完毕了
bool QThread::isFinished() const;
// 子线程是否在执行任务
bool QThread::isRunning() const;

// Qt中的线程可以设置优先级
Priority QThread::priority() const;  // 得到当前线程的优先级
void QThread::setPriority(Priority priority); // 设置优先级
优先级:
    QThread::IdlePriority         --> 最低的优先级
    QThread::LowestPriority
    QThread::LowPriority
    QThread::NormalPriority
    QThread::HighPriority
    QThread::HighestPriority
    QThread::TimeCriticalPriority --> 最高的优先级
    QThread::InheritPriority      --> 子线程和其父线程的优先级相同, 默认是这个

// 退出线程, 停止底层的事件循环
// 退出线程的工作函数
void QThread::exit(int returnCode = 0);

// 调用线程退出函数之后, 线程不会马上退出因为当前任务有可能还没有完成, 调回用这个函数是
// 等待任务完成, 然后退出线程, 一般情况下会在 exit() 后边调用这个函数
bool QThread::wait(unsigned long time = ULONG_MAX);
```

### 5.1.2 信号槽

```c++
// 和调用 exit() 效果是一样的
// 代用这个函数之后, 再调用 wait() 函数
[slot] void QThread::quit();
// 启动子线程
[slot] void QThread::start(Priority priority = InheritPriority);
// 线程退出, 可能是会马上终止线程, 一般情况下不使用这个函数
[slot] void QThread::terminate();

// 线程中执行的任务完成了, 发出该信号
// 任务函数中的处理逻辑执行完毕了
[signal] void QThread::finished();
// 开始工作之前发出这个信号, 一般不使用
[signal] void QThread::started();
```

### 5.1.3 静态函数

```cpp
// 返回一个指向管理当前执行线程的QThread的指针
[static] QThread *QThread::currentThread();
// 返回可以在系统上运行的理想线程数 == 和当前电脑的 CPU 核心数相同
[static] int QThread::idealThreadCount();
// 线程休眠函数
[static] void QThread::msleep(unsigned long msecs);	// 单位: 毫秒
[static] void QThread::sleep(unsigned long secs);	// 单位: 秒
[static] void QThread::usleep(unsigned long usecs);	// 单位: 微秒
```

### 5.1.4 任务处理函数

```cpp
// 子线程要处理什么任务, 需要写到 run() 中
[virtual protected] void QThread::run();
```

## 5.2 使用方式 1

第一种使用方式的特点是： 简单

### 5.2.1 创建一个线程类的子类，并继承QThread

```cpp
class MyThread:public QThread
{
    ......
}
```

### 5.2.2 重写父类的 run () 方法

```cpp
// 在该函数内部编写子线程要处理的具体的业务流程
class MyThread:public QThread
{
    ......
 protected:
    void run()
    {
        ........
    }
}
```

### 5.2.3 在主线程中创建子线程对象

```cpp
MyThread * subThread = new MyThread;
```

### 5.2.4 启动子线程，调用 start () 方法

```cpp
subThread->start();
```

> 不能在类的外部调用 run () 方法启动子线程，在外部调用 start () 相当于让 run () 开始运行
>
> - 在 Qt 中子线程中不要操作程序中的窗口类型对象，这不允许，如果操作了程序就挂了
> - 只有主线程才能操作程序中的窗口对象，默认的线程就是主线程，自己创建的就是子线程

### 5.2.4.0 connent()第五个参数

1. 自动连接(AutoConnection)：默认的连接方式。如果信号与槽，也就是发送者与接受者在同一线程，等同于直接连接；如果发送者与接受者处在不同线程，等同于队列连接。

2. 直接连接(Direct Connection)：当信号发射时，槽函数将直接被调用。无论槽函数所属对象在哪个线程，槽函数都在发射者所在线程执行。

3. 队列连接(Queued Connection)：当控制权回到接受者所在线程的事件循环式，槽函数被调用。槽函数在接收者所在线程执行。

### 5.2.5 示例代码

举一个简单的数数的例子，假如只有一个线程，让其一直数数，会发现数字并不会在窗口中时时更新，并且这时候如果用户使用鼠标拖动窗口，就会出现无响应的情况，使用多线程就不会出现这样的现象了。

在下面的窗口中，点击按钮开始在子线程中数数，让后通过信号槽机制将数据传递给 UI 线程，通过 UI 线程将数据更新到窗口中。
![在这里插入图片描述](https://img-blog.csdnimg.cn/882b60c6b38f4e6d96eaef9807a259d0.gif)

- mythread.h

```cpp
#ifndef MYTHREAD_H
#define MYTHREAD_H

#include <QThread>

class MyThread : public QThread
{
    Q_OBJECT
public:
    explicit MyThread(QObject *parent = nullptr);

protected:
    void run();

signals:
    // 自定义信号, 传递数据
    void curNumber(int num);

public slots:
};

#endif // MYTHREAD_H
```

- mythread.cpp

```cpp
#include "mythread.h"
#include <QDebug>

MyThread::MyThread(QObject *parent) : QThread(parent)
{

}

void MyThread::run()
{
    qDebug() << "当前线程对象的地址: " << QThread::currentThread();

    int num = 0;
    while(1)
    {
        emit curNumber(num++);
        if(num == 10000000)
        {
            break;
        }
        QThread::usleep(1);
    }
    qDebug() << "run() 执行完毕, 子线程退出...";
}
```

- mainwindow.cpp

```cpp
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "mythread.h"
#include <QDebug>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    qDebug() << "主线程对象地址:  " << QThread::currentThread();
    // 创建子线程
    MyThread* subThread = new MyThread;

    connect(subThread, &MyThread::curNumber, this, [=](int num)
    {
        ui->label->setNum(num);
    });

    connect(ui->startBtn, &QPushButton::clicked, this, [=]()
    {
        // 启动子线程
        subThread->start();
    });
}

MainWindow::~MainWindow()
{
    delete ui;
}
```

这种在程序中添加子线程的方式是非常简单的，但是也有弊端，假设要在一个子线程中处理多个任务，所有的处理逻辑都需要写到run()函数中，这样该函数中的处理逻辑就会变得非常混乱，不太容易维护。

## 5.3 使用方式 2

更加灵活，复杂

### 5.3.1 创建一个新的类( 从 QObject 派生 )

```cpp
class MyWork:public QObject
{
    .......
}
```

### 5.3.2 在这个类中添加一个公共的成员函数，函数体就是我们要子线程中执行的业务逻辑

```cpp
class MyWork:public QObject
{
public:
    .......
    // 函数名自己指定, 叫什么都可以, 参数可以根据实际需求添加
    void working();
}
```

### 3.3 主线程中创建 QThread 对象，这就是子线程的对象

```cpp
QThread* sub = new QThread;
```

1. 在主线程中创建工作的类对象（千万不要指定给创建的对象指定父对象）

```cpp
MyWork* work = new MyWork(this);    // error
MyWork* work = new MyWork;          // ok
```

1. 将 MyWork 对象移动到创建的子线程对象中，需要调用 QObject 类提供的 moveToThread() 方法

```cpp
// void QObject::moveToThread(QThread *targetThread);
// 如果给work指定了父对象, 这个函数调用就失败了
// 提示： QObject::moveToThread: Cannot move objects with a parent
work->moveToThread(sub);	// 移动到子线程中工作
```

1. 启动子线程，调用 start(), 这时候线程启动了，但是移动到线程中的对象并没有工作
2. 调用 MyWork 类对象的工作函数，让这个函数开始执行，这时候是在移动到的那个子线程中运行的

## 5.4 另外( url ):

https://www.cnblogs.com/xyf327/p/15032670.html

# 6. QSerialPortInfo

6.1 简单介绍

QT += serialport

CMake

```cmake
find_package(Qt5 COMPONENTS SerialPort REQUIRED)
target_link_libraries(${PROJECT_NAME} Qt5::SerialPort)
```

官方Doc: https://doc.qt.io/qt-5.9/qserialport.html
头文件: #include\<QSerialPortInfo>
简述: 一个串口的辅助类类，提供主要是提供系统已经存在串口的信息
————————————————
原文链接：https://blog.csdn.net/mcu_tian/article/details/43527385

## 6.1 构造函数

```cpp
QSerialPortInfo()
QSerialPortInfo(const QSerialPort & port)
QSerialPortInfo(const QString & name)
QSerialPortInfo(const QSerialPortInfo & other)
```

## 6.2 析构函数

```cpp
~QSerialPortInfo();
```

## 6.3 成员函数

该类函数主要是返回该对象所对应的端口信息。

```cpp
/**
 * 返回一个QString数据类型，表示对象所对应的端口类型(例如是标准的通信端口，还是USB转串口等)
 */
QString description() const;

/**
 * 判断该端口是否有有效的的16位产品编码
 * 有: true
 * 否则: false
 */
bool hasProductIdentifier() const 

/**
 * 判断该端口是否有有效的16位产品供应商的编码
 * 有: true
 * 否则: false
 */
bool hasVendorIdentifier() const;
    
/**
 * 判断该端口是否被被占用
 * 有: true
 * 否则: false
 */    
bool isBusy() const   
    
/**
 * 判断该对象是否有一个确定的对应关联端口
 * 有: true
 * 否则: false
 */
bool boolisNull() const;

/**
 * 返回生产厂商的信息
 */    
QString manufacturer() const;

/**
 * 返回对象对应的端口号类型，端口号类型用QString数据类型表示
 * 若是没有有效厂家信息，返回的是空QString
 */  
QString portName() const   

/**
 * 返回端口的16位序列号
 * 若是没有，返回的是0
 */
quint16 productIdentifier() const  

/**
 * 返回用QSrting表示的的序列号 (5.3以后的版本才有)
 */
QString serialNumber() const  

/**
 * 该对象与 other 引用所指向的对象互换相关信息，该函数的运行非常快，而且不会失败。
 */
void swap(QSerialPortInfo & other) 
    
/**
 * 返回串口系统的位置
 */
QString systemLocation() const  
    
/**
 * 返回该端口是否有有效的16位产品供应商的编码
 * 若是没有则返回0
 */
quint16 vendorIdentifier() const
```

## 6.4 static函数

static函数为类的全部服务而不是为某一个类的具体对象服务。static成员函数与静态数据成员一样，都是类的内部实现，属于类定义的一部分。

```cpp
/**
 * @return: QList<QSerialPortInfo>对象
 * QList中的QSerialPortInfo对象对应于该系统的可用的端口,(主要包括端口号（com），系统的位置，以及串口类型，厂商等信息)
 */
QList<QSerialPortInfo> availablePorts()    

/**
 * 端口名
 */
QString QSerialPortInfo::portName();

/**
 * 返回当前串口标准的可用的波特率
 */
QList<qint32>  standardBaudRates();  
```

## 6.5 其他函数

```cpp
QSerialPortInfo &operator=(const QSerialPortInfo & other)
```

# 7.QSerialPort

参考: https://blog.csdn.net/weixin_42837024/article/details/81669540
官方Doc: https://doc.qt.io/qt-5/qserialport.html

改文章中的示例有 QString -> Hex, char -> Hex, 收发数据

## 7.1 成员函数

```cpp
// 打开串口。
// 参数可以设置串口为只读、只写、读写三种方式。
QSerialPort::open(QIODevice::ReadWrite);
bool QSerialPort::isOpen() const;

// 打开监听消息线程。
// 采用开线程的方式定时去读取串口中缓存的数据，这样做是为了不造成堵塞
std::thread pListenThread = std::thread(&Myself::ListenThreadFuc, this); pListenThread.detach();

// 接收数据
void Myself::ListenThreadFuc() 
{
    if (m_serialPort == nullptr) { return; } 
    while (QSerialPort::isOpen()) 
    { 
        QByteArray readData = QSerialPort::read(DATA_SIZE); 
        if (!readData.isEmpty()) 
        {
            emit ReadData(readData); 
        } 
        Sleep(100); 
    } 
}
// 读取数据
QSerialPort::read();  // 指定每次读出的数据的大小。
QSerialPort::readAll();  // 将串口中缓存的数据全部读出。

// 发送数据。
QByteArray byteSendData();
QSerialPort::write(byteSendData);

// 关闭串口

/**
 * @param: directions
 * QSerialPort::Input	1	Input direction.
 * QSerialPort::Output	2	Output direction.
 * QSerialPort::AllDirections	Input | Output	Simultaneously in two directions.
 */
QSerialPort::clear(QSerialPort::Directions directions = AllDirections); //清除输入输出缓冲区里面的数据
QSerialPort::close(); //关闭串口设备
QSerialPort::deleteLater(); //不立即销毁,父类销毁时再销毁

// 设置串口属性
QSerialPort::setPortName("COM3");  // 设置串口名
设置波特率： QSerialPort::setBaudRate(QSerialPort::Baud9600);//是一个衡量符号传输速率的参数。
设置数据位： QSerialPort::setDataBits(QSerialPort::Data8);//是衡量通信中实际数据位的参数。
设置奇偶校验： QSerialPort::setParity(QSerialPort::OddParity);//在串口通信中一种简单的检错方式。有四种检错方式：偶、奇、高和低。当然没有校验位也是可以的。
设置停止位： QSerialPort::setStopBits(QSerialPort::OneStop);//用于表示单个包的最后一位。
设置流控制： QSerialPort::setFlowControl(QSerialPort::NoFlowControl);
设置读取数据的缓存大小： QSerialPort::setReadBufferSize(40960);
```



# 8.QByteArray

## 8.1 **初始化**

```cpp
QByteArray()
QByteArray(const char* data, int size = -1)
QByteArray(int size, char ch)
QByteArray(const QByteArray &other)
QByteArray(QByteArray &&other)
void swap(QByteArray &other); // 交换两个字符数组，执行速度非常的快
```

实际工程中常用的是第二个构造函数，因为有了指针，所以我们知道了数据在内存中的开头位置，那么用 size 指定我们要多少数据即可。
@warning: 默认 size 为负---遇到第一个‘\0’空字符时停止。
所以如果你要载入的数据中确实有‘\0’的话，需要手动指定 size，否则空字符后面的数据不会被加载进来

## 8.2 **数组是否空**

```cpp
bool isEmpty() const
bool isNull() const
```

由于历史原因，虽然都是空，但 Qt 对字符数组区分了 null 和 empty。我们其实关注的是有没有数据，所以一般就用 isEmpty() 就可以了。如果非要想知道区别，可以看以下代码感受一下：

```cpp
QByteArray().isEmpty(); // true
QByteArray("").isEmpty(); // true
QByteArray("abc").isEmpty(); // false

QByteArray().isNull(); // true
QByteArray("").isNull(); // false
QByteArray("abc").isNull(); // false
```

## 8.3 获取大小/resize/释放空间

```cpp
获取
    内存大小：int capacity() const
    字符大小：
    int count() const; 
	int size() const;
	int length() const; // 三者一致
设置
    不填充：void reserve(int size)
    填充：void resize(int size)
释放不需要的空间
    void squeeze()
    void shrink_to_fit()
```

容量大小: 因为每个字符占用一个空间，所以一般分配的内存空间大于数据的字节数，这样才能存放所有的字符。因此，capacity() 函数返回分配的内存空间大小；count()、size()、length() 三者效果一模一样，返回的是字符的数量，当然一个字符是1个字节，因此也可以说是数据的大小。

设置容量: 一般我们不需要做这样的操作，QByteArray 会自动管理的。但是 Qt 还是给我们开放了调整分配内存空间大小的函数 reserve() 和 resize()。两者都可以重新调整空间容量，区别在于 reserve() 不会在多余的空间中填充字符，而 resize() 扩大容量后会在多余的空间均填充一些字符，而且填充的字符不确定。

释放: squeeze() 等价于 shrink_to_fit()。作用就是当分配容量大于字符数量时，将多余的空间释放掉。

## 8.4 指向数据的指针

```cpp
	// 返回指向 QByteArray 中字符数组数据的指针，只要不重新分配空间或者销毁，该指针就保持有效
    char * data() 
    const char * data() const
    
    // 如果只读的话该函数非常快，不会导致深层复制。
    // 一般该函数用于的场合为需要 const char* 参数的地方。
    const char * constData() const
    QByteArray & setRawData(const char *data, uint size)
    [static]QByteArray fromRawData(const char *data, int size)
```

setRawData() 和 fromRawData(): 两个函数都是从原始数据中构造 QByteArray。看参数是 const char*，说明无论怎么构建 QByteArray，都不会对数据源进行修改，因为隐式共享的原因，只要用 QByteArray 修改一个字符，就会引发深拷贝。

## 8.5**增/删/改/查**

```cpp
删除
    前后
        删除后n个字符：void chop(int n)
        保留前n个字符：void truncate(int pos)
    中间：QByteArray &remove(int pos, int len)
    删除所有字符：void clear()
    去除空白
    	// 作用是删除字符串头尾的空白，同时将字符串中间有空白的地方均用一个空格替换。
    	// 例如“ lots\t of\nwhitespace\r\n ”->“lots of whitespa
        QByteArray simplified() const
        
    	// 仅删除字符串头尾的空白。
    	QByteArray trimmed() const
```

```cpp
查找
    判断数组中的内容
        是否包含
            开头
                bool startsWith(const QByteArray &ba) const
                bool startsWith(char ch) const
                bool startsWith(const char *str) const
            中间任意位置
                bool contains(const QByteArray &ba) const
                bool contains(const char *str) const
                bool contains(char ch) const
            结尾
                bool endsWith(const QByteArray &ba) const
                bool endsWith(char ch) const
                bool endsWith(const char *str) const
        包含的字符所在位置
            int indexOf(const QByteArray &ba, int from = 0) const
            int indexOf(const char *str, int from = 0) const
            int indexOf(char ch, int from = 0) const
            int indexOf(const QString &str, int from = 0) const
            int lastIndexOf(const QByteArray &ba, int from = -1) const
            int lastIndexOf(const char *str, int from = -1) const
            int lastIndexOf(char ch, int from = -1) const
            int lastIndexOf(const QString &str, int from = -1) const
        出现次数
            int count(const QByteArray &ba) const
            int count(const char *str) const
            int count(char ch) const
    提取内容
        单个字符
            第一个
                char front() const
                QByteRef front()
            中间
                char at(int i) const
                char operator[](uint i) const
                char operator[](int i) const
                QByteRef operator[](int i)
                QByteRef operator[](uint i)
            最后一个
                char back() const
                QByteRef back()
        字符串
            直接提取
                左：QByteArray left(int len) const
                中：QByteArray mid(int pos, int len = -1) const
                右：QByteArray right(int len) const
            删除后提取
                QByteArray chopped(int len) const
        切分：QList<QByteArray> split(char sep) const
```

关于查找，主要包含判断内容和内容提取两部分。判断内容就是字符数组中是否包含某某字符之类的，内容提取就是从字符串中获取子字符串内容。

## 8.6 **宏**

```cpp
QByteArrayLiteral(ba)
QT_NO_CAST_FROM_BYTEARRAY
```

关于 QByteArrayLiteral，作用就是在编译期构造好 QByteArray，而无需在运行期再去构造。如下代码所示，在程序运行的时候，第一个代码会创建临时的 QByteArray 而第二个代码不需要，因为它已经在我们编译的时候就创建好了。

```cpp
if (node.hasAttribute("length"))
if (node.hasAttribute(QByteArrayLiteral("length")))
```

关于 QT_NO_CAST_FROM_BYTEARRAY，就是禁用从 QByteArray 到 const char * 或 const void * 的自动转换。

## **附：所有函数**

```cpp
初始化
    QByteArray()
    QByteArray(const char *data, int size = -1)
    QByteArray(int size, char ch)
    QByteArray(const QByteArray &other)
    QByteArray(QByteArray &&other)
    交换：void swap(QByteArray &other)
数组信息
    是否空
        bool isEmpty() const
        bool isNull() const
    容量
        获取
            内存大小：int capacity() const
            字符大小：int count() const == int size() const == int length() const
        设置
            不填充：void reserve(int size)
            填充：void resize(int size)
        释放不需要的空间
            void squeeze()
            void shrink_to_fit()
    指向数据的指针
        char * data()
        const char *data() const
        const char *constData() const
        QByteArray &setRawData(const char *data, uint size)
        [static]QByteArray fromRawData(const char *data, int size)
增/删/改/查
    增加
        从前面
            QByteArray &prepend(const QByteArray &ba)
            QByteArray &prepend(int count, char ch)
            QByteArray &prepend(const char *str)
            QByteArray &prepend(const char *str, int len)
            QByteArray &prepend(char ch)
            void push_front(const QByteArray &other)
            void push_front(const char *str)
            void push_front(char ch)
        从中间
            QByteArray &insert(int i, const QByteArray &ba)
            QByteArray &insert(int i, int count, char ch)
            QByteArray &insert(int i, const char *str)
            QByteArray &insert(int i, const char *str, int len)
            QByteArray &insert(int i, char ch)
            QByteArray &insert(int i, const QString &str)
        从后面
            QByteArray &append(const QByteArray &ba)
            QByteArray &append(int count, char ch)
            QByteArray &append(const char *str)
            QByteArray &append(const char *str, int len)
            QByteArray &append(char ch)
            QByteArray &append(const QString &str)
            void push_back(const QByteArray &other)
            void push_back(const char *str)
            void push_back(char ch)
    删除
        前后
            删除后n个字符：void chop(int n)
            保留前n个字符：void truncate(int pos)
        中间：QByteArray &remove(int pos, int len)
        删除所有字符：void clear()
        去除空白
            QByteArray simplified() const
            QByteArray trimmed() const
    修改
        填充
            左：QByteArray leftJustified(int width, char fill = ' ', bool truncate = false) const
            全部：QByteArray & fill(char ch, int size = -1)
            右：QByteArray rightJustified(int width, char fill = ' ', bool truncate = false) const
        复制多次：QByteArray repeated(int times) const
        替换
            QByteArray &replace(int pos, int len, const QByteArray &after)
            QByteArray &replace(int pos, int len, const char *after, int alen)
            QByteArray &replace(int pos, int len, const char *after)
            QByteArray &replace(char before, const char *after)
            QByteArray &replace(char before, const QByteArray &after)
            QByteArray &replace(const char *before, const char *after)
            QByteArray &replace(const char *before, int bsize, const char *after, int asize)
            QByteArray &replace(const QByteArray &before, const QByteArray &after)
            QByteArray &replace(const QByteArray &before, const char *after)
            QByteArray &replace(const char *before, const QByteArray &after)
            QByteArray &replace(char before, char after)
            QByteArray &replace(const QString &before, const char *after)
            QByteArray &replace(char before, const QString &after)
            QByteArray &replace(const QString &before, const QByteArray &after)
    查找
        判断数组中的内容
            是否包含
                开头
                    bool startsWith(const QByteArray &ba) const
                    bool startsWith(char ch) const
                    bool startsWith(const char *str) const
                中间任意位置
                    bool contains(const QByteArray &ba) const
                    bool contains(const char *str) const
                    bool contains(char ch) const
                结尾
                    bool endsWith(const QByteArray &ba) const
                    bool endsWith(char ch) const
                    bool endsWith(const char *str) const
            包含的字符所在位置
                int indexOf(const QByteArray &ba, int from = 0) const
                int indexOf(const char *str, int from = 0) const
                int indexOf(char ch, int from = 0) const
                int indexOf(const QString &str, int from = 0) const
                int lastIndexOf(const QByteArray &ba, int from = -1) const
                int lastIndexOf(const char *str, int from = -1) const
                int lastIndexOf(char ch, int from = -1) const
                int lastIndexOf(const QString &str, int from = -1) const
            出现次数
                int count(const QByteArray &ba) const
                int count(const char *str) const
                int count(char ch) const
        提取内容
            单个字符
                第一个
                    char front() const
                    QByteRef front()
                中间
                    char at(int i) const
                    char operator[](uint i) const
                    char operator[](int i) const
                    QByteRef operator[](int i)
                    QByteRef operator[](uint i)
                最后一个
                    char back() const
                    QByteRef back()
            字符串
                直接提取
                    左：QByteArray left(int len) const
                    中：QByteArray mid(int pos, int len = -1) const
                    右：QByteArray right(int len) const
                删除后提取
                    QByteArray chopped(int len) const
	        切分：QList<QByteArray> split(char sep) const
转换
    大小写
        bool isLower() const
        bool isUpper() const
        QByteArray toLower() const
        QByteArray toUpper() const
    数字
        int 型
            QByteArray & setNum(int n, int base = 10)
            int toInt(bool *ok = nullptr, int base = 10) const
        unsigned int 型
            QByteArray & setNum(uint n, int base = 10)
            uint toUInt(bool *ok = nullptr, int base = 10) const
        short 型
            QByteArray & setNum(short n, int base = 10)
            short toShort(bool *ok = nullptr, int base = 10) const
        unsigned short 型
            QByteArray & setNum(ushort n, int base = 10)
            ushort toUShort(bool *ok = nullptr, int base = 10) const
        long long 型
            QByteArray & setNum(qlonglong n, int base = 10)
            qlonglong toLongLong(bool *ok = nullptr, int base = 10) const
        unsigned long long 型
            QByteArray & setNum(qulonglong n, int base = 10)
            qulonglong toULongLong(bool *ok = nullptr, int base = 10) const
        float 型
            QByteArray & setNum(float n, char f = 'g', int prec = 6)
            float toFloat(bool *ok = nullptr) const
        double 型
            QByteArray & setNum(double n, char f = 'g', int prec = 6)
            double toDouble(bool *ok = nullptr) const
        十六进制
            QByteArray toHex() const
            QByteArray toHex(char separator) const
            [static]QByteArray fromHex(const QByteArray &hexEncoded)
    Base64
        QByteArray toBase64() const
        QByteArray toBase64(QByteArray::Base64Options options) const
        [static]QByteArray fromBase64(const QByteArray &base64)
        [static]QByteArray fromBase64(const QByteArray &base64, QByteArray::Base64Options options)
    CFData
        CFDataRef toCFData() const
        CFDataRef toRawCFData() const
        [static]QByteArray fromCFData(CFDataRef data)
        [static]QByteArray fromRawCFData(CFDataRef data)
    NSData
        NSData * toNSData() const
        NSData * toRawNSData() const
        [static]QByteArray fromNSData(const NSData *data)
        [static]QByteArray fromRawNSData(const NSData *data)
    URL
        QByteArray toPercentEncoding(const QByteArray &exclude = QByteArray(), const QByteArray &include = QByteArray(), char percent = '%') const
        QByteArray fromPercentEncoding(const QByteArray &input, char percent = '%')
    StdString
        std::string toStdString() const
        [static]QByteArray fromStdString(const std::string &str)
比较字符串
    int compare(const char *c, Qt::CaseSensitivity cs = ...) const
    int compare(const QByteArray &a, Qt::CaseSensitivity cs = ...) const
游标
    QByteArray::iterator begin()
    QByteArray::const_iterator begin() const
    QByteArray::const_iterator cbegin() const
    QByteArray::const_iterator cend() const
    QByteArray::const_iterator constBegin() const
    QByteArray::const_iterator constEnd() const
    QByteArray::const_reverse_iterator crbegin() const
    QByteArray::const_reverse_iterator crend() const
    QByteArray::iterator end()
    QByteArray::const_iterator end() const
    QByteArray::reverse_iterator rbegin()
    QByteArray::const_reverse_iterator rbegin() const
    QByteArray::reverse_iterator rend()
    QByteArray::const_reverse_iterator rend() const
非成员相关函数
    CRC16校验和
        quint16 qChecksum(const char *data, uint len)
        quint16 qChecksum(const char *data, uint len, Qt::ChecksumType standard)
    解/压缩
        QByteArray qCompress(const uchar *data, int nbytes, int compressionLevel = -1)
        QByteArray qCompress(const QByteArray &data, int compressionLevel = -1)
        QByteArray qUncompress(const uchar *data, int nbytes)
        QByteArray qUncompress(const QByteArray &data)
    类似C函数
        int qsnprintf(char *str, size_t n, const char *fmt, ...)
        int qstrcmp(const char *str1, const char *str2)
        char *qstrcpy(char *dst, const char *src)
        char *qstrdup(const char *src)
        int qstricmp(const char *str1, const char *str2)
        uint qstrlen(const char *str)
        int qstrncmp(const char *str1, const char *str2, uint len)
        char *qstrncpy(char *dst, const char *src, uint len)
        int qstrnicmp(const char *str1, const char *str2, uint len)
        uint qstrnlen(const char *str, uint maxlen)
        int qvsnprintf(char *str, size_t n, const char *fmt, va_list ap)
宏
    QByteArrayLiteral(ba)
    QT_NO_CAST_FROM_BYTEARRAY
```



# 9. QJsonValue

CSDN: https://blog.csdn.net/dengjin20104042056/article/details/102729044

```cpp
QJsonValue(QJsonValue::Type type = Null)
QJsonValue(bool b)
QJsonValue(double n)
QJsonValue(int n)
QJsonValue(qint64 n)
QJsonValue(const QString &s)
QJsonValue(QLatin1String s)
QJsonValue(const char *s)
QJsonValue(const QJsonArray &a)
QJsonValue(const QJsonObject &o)
QJsonValue(const QJsonValue &other)
QJsonValue(QJsonValue &&other)
~QJsonValue()
bool isArray() const
bool isBool() const
bool isDouble() const
bool isNull() const
bool isObject() const
bool isString() const
bool isUndefined() const
void swap(QJsonValue &other)
QJsonArray toArray(const QJsonArray &defaultValue) const
QJsonArray toArray() const
bool toBool(bool defaultValue = false) const
double toDouble(double defaultValue = 0) const
int toInt(int defaultValue = 0) const
QJsonObject toObject(const QJsonObject &defaultValue) const
QJsonObject toObject() const
QString toString() const
QString toString(const QString &defaultValue) const
QVariant toVariant() const
QJsonValue::Type type() const
bool operator!=(const QJsonValue &other) const
QJsonValue &operator=(const QJsonValue &other)
QJsonValue &operator=(QJsonValue &&other)
bool operator==(const QJsonValue &other) const
const QJsonValue operator[](const QString &key) const
const QJsonValue operator[](QLatin1String key) const
const QJsonValue operator[](int i) const
```

 

```cpp
[static] QJsonValue QJsonValue::fromVariant(const QVariant &variant)
将variant转换为QJsonValue

bool QJsonValue::isArray() const
如果QJsonValue包含一个数组，返回true

bool QJsonValue::isBool() const
如果QJsonValue包含一个bool，返回true

bool QJsonValue::isDouble() const
如果QJsonValue包含一个double，返回true

bool QJsonValue::isNull() const
如果QJsonValue包含一个Null，返回true

bool QJsonValue::isObject() const
如果QJsonValue包含一个object，返回true

bool QJsonValue::isString() const
如果QJsonValue包含一个string，返回true

bool QJsonValue::isUndefined() const
如果QJsonValue包含一个undefined，返回true

QJsonArray QJsonValue::toArray(const QJsonArray &defaultValue) const
将QJsonValue转换为QJsonArray并返回，如果类型不是array，返回默认值defaultValue

QJsonArray QJsonValue::toArray() const
将QJsonValue转换为QJsonArray并返回

bool QJsonValue::toBool(bool defaultValue = false) const
将QJsonValue转换为bool并返回

double QJsonValue::toDouble(double defaultValue = 0) const
将QJsonValue转换为double并返回

int QJsonValue::toInt(int defaultValue = 0) const
将QJsonValue转换为int并返回

QJsonObject QJsonValue::toObject(const QJsonObject &defaultValue) const
QJsonObject QJsonValue::toObject() const
将QJsonValue转换为QJsonObject并返回

QString QJsonValue::toString(const QString &defaultValue = QString()) const
将QJsonValue转换为QString并返回

Type QJsonValue::type() const
返回QJsonValue的类型
```

# 10. QJsonDocument

CSDN: https://blog.csdn.net/dengjin20104042056/article/details/102747870

## 10.1 公有类型:

```cpp
enum DataValidation { Validate, BypassValidation }
enum JsonFormat { Indented, Compact }
```

##  10.2 公有成员方法

```cpp
QJsonDocument()
QJsonDocument(const QJsonObject &object)
QJsonDocument(const QJsonArray &array)
QJsonDocument(const QJsonDocument &other)
QJsonDocument(QJsonDocument &&other)
~QJsonDocument()
QJsonArray	array() const
bool	isArray() const
bool	isEmpty() const
bool	isNull() const
bool	isObject() const
QJsonObject	object() const
const char *	rawData(int *size) const
void	setArray(const QJsonArray &array)
void	setObject(const QJsonObject &object)
void	swap(QJsonDocument &other)
QByteArray	toBinaryData() const
QByteArray	toJson() const
QByteArray	toJson(QJsonDocument::JsonFormat format) const
QVariant	toVariant() const
bool	operator!=(const QJsonDocument &other) const
QJsonDocument &	operator=(const QJsonDocument &other)
QJsonDocument &	operator=(QJsonDocument &&other)
bool	operator==(const QJsonDocument &other) const
const QJsonValue	operator[](const QString &key) const
const QJsonValue	operator[](QLatin1String key) const
const QJsonValue	operator[](int i) const
```

```cpp
[static] QJsonDocument QJsonDocument::fromBinaryData(const QByteArray &data, DataValidation validation = Validate)
Validation决定数据是否在使用前检查数据有效性。

[static] QJsonDocument QJsonDocument::fromJson(const QByteArray &json, QJsonParseError *error = Q_NULLPTR)
将json解析为UTF-8的JSON文档

[static] QJsonDocument QJsonDocument::fromRawData(const char *data, int size, DataValidation validation = Validate)
使用data数据的前size字节创建一个QJsonDocument对象

[static] QJsonDocument QJsonDocument::fromVariant(const QVariant &variant)
根据variant创建QJsonDocument对象

bool QJsonDocument::isArray() const

bool QJsonDocument::isEmpty() const

bool QJsonDocument::isNull() const

bool QJsonDocument::isObject() const

QJsonObject QJsonDocument::object() const
返回文档中包含的QJsonObject对象

const char *QJsonDocument::rawData(int *size) const
返回size大小的二进制数据

void QJsonDocument::setArray(const QJsonArray &array)
设置array作为文档中的主对象

void QJsonDocument::setObject(const QJsonObject &object)
设置object作为文档中的主对象

QByteArray QJsonDocument::toBinaryData() const
返回文档的二进制格式数据

QByteArray QJsonDocument::toJson(JsonFormat format = Indented) const
将QJsonDocument转换为UTF-8编码的format格式的JSON文档

QVariant QJsonDocument::toVariant() const
返回JSON文档的QVariant格式
```

## 10.3 静态公有成员

```cpp
const uint	BinaryFormatTag
QJsonDocument	fromBinaryData(const QByteArray &data, QJsonDocument::DataValidation validation = Validate)
QJsonDocument	fromJson(const QByteArray &json, QJsonParseError *error = nullptr)
QJsonDocument	fromRawData(const char *data, int size, QJsonDocument::DataValidation validation = Validate)
QJsonDocument	fromVariant(const QVariant &variant)
```

# 11. QJsonValueRef

直接修改QObject 对象的值
(对这个json对象中的部分数据做修改，如果通过toArray或toObject转换后修改，那么修改后的值不会影响原来的对象，如果要直接修改原对象，那么可以用QJsonValueRef 。)

```cpp
QJsonValueRef RefPage = json.find("Page").value();
RefPage = QJsonValue("8888");
```

# 12. Qt正则表达式

```c++
int main()
{
	QRegularExpression re("(\\[.*?\\]).*");  // 
    if (!re.isValid()) std::cerr << "no!\n"; else cout << "yes!\n";
    QRegularExpressionMatch math = re.match("['str'/'type'/0], ['asd'/0]");
    if (math.hasMatch())
    {
        auto str = math.captured(1);
        QStringList str_list = math.capturedTexts();
        qDebug() << str;
        qDebug() << str_list;
        qDebug() << typeid(str).name();
        qDebug() << typeid(str_list).name();
    }
	
	return 0;
}
```

`QRegularExpression`定义正则表达式模式
`QRegularExpressionMatch` 正则表达式结果

`QRegularExpression::match()`

`QRegularExpressionMatch::captured()`        返回QString   参数: 0返回所有匹配到的结果; 1: ()捕获到的第一个; 2: 以此类推
`QRegularExpressionMatch::capturedTexts()` 返回QStringList  [0]: 匹配到的所有字符串(不仅仅是()捕获的), [1]: ()捕获到的第一个; [2]: 以此类推

另附: `QRegularExpression`所有函数

常用的有:

```cpp
/**
 * 构造函数，使用给定的模式和选项创建一个QRegularExpression对象。
 */
QRegularExpression(
    const QString &pattern, 
    QRegularExpression::PatternOptions options = NoPatternOption
);

// 检查QRegularExpression对象是否有效，即模式是否正确
bool isValid() const;  

// 在给定的字符串中搜索模式，并返回匹配结果
QRegularExpressionMatch match(
    const QString &subject, int offset = 0, 
    QRegularExpression::MatchType matchType = NormalMatch, 			 
    QRegularExpressionMatch::MatchOptions matchOptions = NoMatchOption
) const;

// 返回当前QRegularExpression对象使用的模式
QString pattern() const; 

// 设置QRegularExpression对象的模式
void setPattern(const QString &pattern);

// 返回模式中的捕获组数量
int captureCount() const;
```



```cpp
// 构造函数，使用给定的模式和选项创建一个QRegularExpression对象
QRegularExpression(
    const QString &pattern,
    QRegularExpression::PatternOptions options = NoPatternOption
);

// 检查QRegularExpression对象是否有效，即模式是否正确
bool isValid() const;

// 在给定的字符串中搜索模式，并返回匹配结果
QRegularExpressionMatch match(
    const QString &subject, 
    int offset = 0,
    QRegularExpression::MatchType matchType = NormalMatch,
    QRegularExpressionMatch::MatchOptions matchOptions = NoMatchOption
) const;
    
// 返回当前QRegularExpression对象使用的模式
QString pattern() const;
    
// 返回模式中所有命名捕获组的名称列表
QStringList namedCaptureGroups() const;
    
// 返回模式中发生错误的偏移量
int patternErrorOffset() const;
    
// 返回模式中的捕获组数量
int captureCount() const;
    
// 返回当前QRegularExpression对象使用的选项
QRegularExpression::PatternOptions patternOptions() const;
    
// 设置QRegularExpression对象的模式
void setPattern(const QString &pattern);
    
// 设置QRegularExpression对象的选项
void setPatternOptions(QRegularExpression::PatternOptions options);
    
// 返回一个迭代器，用于在给定字符串中找到所有与模式匹配的子串
QRegularExpressionMatchIterator globalMatch(
    const QString &subject, 
    int offset = 0, 
    QRegularExpression::MatchType matchType = NormalMatch,
    QRegularExpressionMatch::MatchOptions matchOptions = NoMatchOption
) const;

// 比较两个QRegularExpression对象是否相等
bool operator==(
    const QRegularExpression &re
) const;

// 比较两个QRegularExpression对象是否不相等
bool operator!=(
    const QRegularExpression &re
) const;
    
// 将整数选项转换为QRegularExpression::MatchOption枚举值
QRegularExpression::MatchOption toMatchOption(int options);
    
// 将整数选项转换为QRegularExpression::PatternOption枚举值
QRegularExpression::PatternOption toPatternOption(int options);
```

# 13. QCheckBox

## 13.1 多选框互斥

```python
from PyQt5.QtWidgets import QButtonGroup

self.isVideo = QCheckBox(self)
self.isAutoPlay = QCheckBox(self)

self.box_check_group = QButtonGroup()
self.box_check_group.setExclusive(True)
self.box_check_group.addButton(self.isVideo)
self.box_check_group.addButton(self.isAnime)
```