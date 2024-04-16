# OpenVINO

## 一.GPU 在linux系统上的配置(Ubuntu 22.04.x LTS) 

此步骤参考https://docs.openvino.ai/2023.3/openvino_docs_install_guides_configurations_for_intel_gpu.html

可以直接运行当前目录下的脚本文件，根据自己系统型号选择不同的脚本

[gpu22.04.x.sh](gpu22.04.x.sh) 

1. 更新源并且安装wget

```shell
sudo apt update
sudo apt install -y gpg-agent wget
```

2.使用 `wget` 下载了特定版本的 Intel GPU 驱动程序安装文件

```
. /etc/os-release
if [[ ! " jammy " =~ " ${VERSION_CODENAME} " ]]; then
  echo "Ubuntu version ${VERSION_CODENAME} not supported"
else
  wget https://repositories.intel.com/gpu/ubuntu/dists/jammy/lts/2350/intel-gpu-ubuntu-${VERSION_CODENAME}-2350.run
  chmod +x intel-gpu-ubuntu-${VERSION_CODENAME}-2350.run
  sudo ./intel-gpu-ubuntu-${VERSION_CODENAME}-2350.run
fi
```

3.安装的驱动文件和库

```shell
 apt-get install -y ocl-icd-libopencl1 intel-opencl-icd intel-level-zero-gpu level-zero
```

## 二.GPU在linux系统上配置(Ubuntu 20.04.x LTS ）

可以直接运行当前目录下的脚本文件，根据自己系统型号选择不同的脚本

 [gpu20.04.x.sh](gpu20.04.x.sh) (如果执行失败，自己手动输入一下3.)

1.更新源和安装一些第2步需要的工具

```shell
sudo apt-get update
sudo apt-get install -y --no-install-recommends curl gpg gpg-agent 
```

2.下载 Intel GPU 软件仓库的 GPG 密钥，并将其解码，将 Intel GPU 软件仓库的源添加到系统中。

```
sudo curl https://repositories.intel.com/graphics/intel-graphics.key | gpg --dearmor --output /usr/share/keyrings/intel-graphics.gpg && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/graphics/ubuntu focal-legacy main' | tee  /etc/apt/sources.list.d/intel.gpu.focal.list 
```

3.安装的驱动文件和库

```shell
apt-get update
apt-get update && apt-get install -y --no-install-recommends intel-opencl-icd intel-level-zero-gpu level-zero
```



## 三.CMAKE 配置

```cmake
cmake_minimum_required(VERSION 3.17)
project(openvino)

find_package(OpenCV REQUIRED)
find_package(OpenVINO REQUIRED) # 必须放在find_package(InferenceEngine REQUIRED)find_package(ngraph REQUIRED)前面
find_package(InferenceEngine REQUIRED)
find_package(ngraph REQUIRED)

add_library(${PROJECT_NAME}  src/openvino_ov.cpp src/openvino.cpp include/openvino.h)

target_include_directories(${PROJECT_NAME} PUBLIC ${InferenceEngine_INCLUDE_DIRS})
target_include_directories(${PROJECT_NAME} PUBLIC ${ngraph_INCLUDE_DIRS})
target_include_directories(${PROJECT_NAME} PUBLIC include/)

target_link_libraries(${PROJECT_NAME}  ${OpenCV_LIBS} 
                                        ${OpenVINO_LIBRARIES}
                                        ${InferenceEngine_LIBRARIES}
                                        ${ngraph_LIBRARIES})
```

## 四.示例代码(此示例代码是基于InferenceEngin写的)

```c++
#include <openvino/openvino.hpp>
#include <opencv2/opencv.hpp>
#include<inference_engine.hpp>
#include <fstream>
#include <iostream>
#include<ctime>
using namespace std;
using namespace cv;
using namespace InferenceEngine;
string model_path = "";
string image_path = "";
Blob::Ptr warpMat2Blob(Mat &image);
int main() {
        // 初始化Inference Engine
    Core ie;

    // 加载网络
    auto network = ie.ReadNetwork(model_path);

    // 设置输入配置
    auto inputInfo = network.getInputsInfo().begin()->second; // 获取输入数据的一系列数据
    auto inputName = network.getInputsInfo().begin()->first; // 获取输入数据的名称
    //以下两行根据输入模型的不同修改不同的类型（output一样）
    inputInfo->setLayout(Layout::NHWC); 
    inputInfo->setPrecision(Precision::U8); 

    // 设置输出配置
    auto outputInfo = network.getOutputsInfo().begin()->second; // 获取输出的数据
    auto outputName = network.getOutputsInfo().begin()->first; // 获取输出数据的名字
    outputInfo->setPrecision(Precision::FP32);

    // 加载模型到设备
    auto executableNetwork = ie.LoadNetwork(network, "CPU"); //在cpu加载神经网络模型，也可以用gpu等等
    auto inferRequest = executableNetwork.CreateInferRequest();

    // 准备输入数据
    Mat image = imread(image_path);
    if (image.channels() != 3) {
        cout << "image is not supported" << endl;
        return -1;
    }
    //根据自己模型的不同  自己修改这个函数
    Blob::Ptr imgBlob = warpMat2Blob(image);  // OpenCV Mat对象转换为OpenVINO Blob

    inferRequest.SetBlob(inputName, imgBlob);

    // 开始推理
    inferRequest.Infer();

    // 获取推理结果
    auto outputBlob = inferRequest.GetBlob(outputName);
    // 处理outputBlob获取检测结果(这只是一个示例，每个模型都有不同的处理方法，自己根据自己模型的输出结果形式进行推理结果的分析)
    auto output_data = outputBlob->buffer().as<float*>(); // 获取结果
    size_t num_detections = outputBlob->getTensorDesc().getDims()[1]; // buffer()方法：这个方法通常是用来获取Blob中存储的原始数据的指针。由于Blob可以存储不同类型的数据（例如float、int等），因此buffer()方法返回的是一个通用的指针类型，需要根据实际存储的数据类型进行转换。
    cout << "number_detect = " << num_detections << endl;
    ofstream data_store("../data/result.txt");
    for (size_t i = 0; i < num_detections; ++i) {
    // output_data 是将结果展开而来根据class_id, confidence, xmin, ymin, xmax, ymax排序的
        float class_id = output_data[i * 6 + 0];
        float confidence = output_data[i * 6 + 1];
        float xmin = output_data[i * 6 + 2];
        float ymin = output_data[i * 6 + 3];
        float xmax = output_data[i * 6 + 4];
        float ymax = output_data[i * 6 + 5];
        
        // 将检测信息储存到文件中
        if (data_store.is_open()) {
            data_store << "Detection " <<  i << ": ClassID=" << class_id << " Confidence=" << confidence
                  << " Box=(" << xmin << "," << ymin << "," << xmax << "," << ymax << ")\n";
        }
    }
    data_store.close();

    return 0;

}
Blob::Ptr warpMat2Blob(Mat &image) {
    Mat out_image = Mat::zeros(640, 640, CV_32FC3);
    resize(image,out_image,out_image.size());
    size_t channels = out_image.channels();
    size_t height = out_image.rows;
    size_t width = out_image.cols;
    //注意  以下根据不同模型不同的输入数据形式进行不同的修改(借鉴开源时，可以先打印出模型输入输出数据的形式，然后更改)
    TensorDesc tensorDesc(Precision::U8, {1, channels, height, width}, Layout::NHWC);
    Blob::Ptr blob = make_shared_blob<uint8_t>(tensorDesc, out_image.data);
    // 根据不同版本的openvion以上两行代码可报错  因为  在 有些Opesudo nVINO版本中，确实没有提供名为 make_shared_blob 的函数，一下为不同版本的通用写法(建议使用这个写法，增加容错)
    TensorDesc tensorDesc(Precision::FP32, {1, height, width, channels}, Layout::NHWC);
    Blob::Ptr blob = make_shared_blob<float>(tensorDesc);
    blob->allocate();
    auto buffer = blob->buffer().as<float*>();
    std::copy(image.data, image.data + image.total() * image.channels(), buffer);
    return blob;
}
```

## 五.示例代码(基于ov库的示例代码)

```c++
#include <openvino/openvino.hpp>
#include <opencv2/opencv.hpp>
#include<inference_engine.hpp>
#include <fstream>
#include <iostream>
#include<ctime>
int main() {
    ov::Core core;

    ov::CompiledModel compiled_model = core.compile_model("Model_path", "Device"); //加载模型

    auto model_info = core.read_model("Model_path"); // 获取模型信息(可以获得模型的输入和输出数据形式以及名字)


    ov::InferRequest infer_request = compiled_model.create_infer_request(); //创建推理请求

    // 加载图像
    cv::Mat image = cv::imread("image_path");

    // 转换图像数据类型为 float
    cv::Mat float_image;
    image.convertTo(float_image, CV_32F);

    ov::Tensor input_tensor = infer_request.get_input_tensor();  //获取输入张量

    memcpy(input_tensor.data<float>(), image.data, image.total() * sizeof(float) ); // 将图像数据以模型定义的形式拷到输入张量的数据缓存区(这边根据模型的不同需要进行修改)

    infer_request.set_input_tensor(input_tensor); // 设置输入张量

    infer_request.infer(); // 进行推理

    auto output_tensor = infer_request.get_output_tensor(); //获取输出张量

    float* output_data = output_tensor.data<float>(); //获取输出数据指针

    // 根据不同的模型进行不同的数据处理
}

```

