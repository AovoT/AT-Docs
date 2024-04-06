# OpenVINO

## CMAKE 配置

```cmake
cmake_minimum_required(VERSION 3.17)
project(test)

find_package(OpenCV REQUIRED)
find_package(OpenVINO REQUIRED) # 必须放在find_package(InferenceEngine REQUIRED)find_package(ngraph REQUIRED)前面
find_package(InferenceEngine REQUIRED)
find_package(ngraph REQUIRED)


include_directories(${InferenceEngine_INCLUDE_DIRS})
include_directories(${ngraph_INCLUDE_DIRS})
add_executable(${PROJECT_NAME} ./src/yolov5_openvino.cpp)
target_link_libraries(${PROJECT_NAME}  ${OpenCV_LIBS} 
                                        ${OpenVINO_LIBRARIES}
                                        ${InferenceEngine_LIBRARIES}
                                        ${ngraph_LIBRARIES})
```

## 示例代码

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
string model_path = "../file/yolov5s.onnx";
string image_path = "../image/one.jpg";
Blob::Ptr warpMat2Blob(Mat &image);
int main() {
        // 初始化Inference Engine
    Core ie;

    // 加载网络
    auto network = ie.ReadNetwork(model_path);

    // 设置输入配置
    auto inputInfo = network.getInputsInfo().begin()->second; // 获取输入数据的一系列数据
    auto inputName = network.getInputsInfo().begin()->first; // 获取输入数据的名称
    inputInfo->setLayout(Layout::NHWC); // 将输入数据的图像数据改为 nhwc
    inputInfo->setPrecision(Precision::U8); // 方法将该输入数据的精度设置为无符号8位整数（U8）。这种数据类型通常用于图像数据，因为它能够有效地表示像素值（0-255范围内）。

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
    Blob::Ptr imgBlob = warpMat2Blob(image);  // OpenCV Mat对象转换为OpenVINO Blob

    inferRequest.SetBlob(inputName, imgBlob);

    // 开始推理
    inferRequest.Infer();

    // 获取推理结果
    auto outputBlob = inferRequest.GetBlob(outputName);
    // 处理outputBlob获取检测结果
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
    TensorDesc tensorDesc(Precision::U8, {1, channels, height, width}, Layout::NHWC);
    Blob::Ptr blob = make_shared_blob<uint8_t>(tensorDesc, out_image.data);
    cout << channels * height * width << endl;
    
    return blob;
}
```

## GPU 在linux系统上的配置(Ubuntu 22.04.4 LTS) 

此步骤参考https://docs.openvino.ai/2023.3/openvino_docs_install_guides_configurations_for_intel_gpu.html

### 1.

```
sudo apt update
sudo apt install -y gpg-agent wget
```

2.

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

3.

```
apt-get install -y ocl-icd-libopencl1 intel-opencl-icd intel-level-zero-gpu level-zero
```

