# gluCam: Smartphone Based Blood Glucose Monitoring and Diabetic Sensing

# Concepts Involved
Computer Vision, Flutter, Google Cloud Platform, TensorFlow, Medical Imaging, Machine Learning, Software Programming

# Requirements
Python 3.6, OpenCV 4.0, Microsoft Excel 2013

# A Brief Overview
Diabetes occurs when the blood glucose level is higher than the nominal value, and for its multitude sensing, both invasive and non-invasive techniques are used. Notable drawbacks include dearth of laboratory facilities and personnel at remote locations, invasive techniques, additional equipment resulting in exorbitant costs, lack of smartphone implementation, and non-autonomous functioning. The paper addresses these problems and proposes gluCam - a novel, autonomous, non-invasive, optical-based, smart-diabetic sensing model. It automatically segments blood vessels and calculates the tortuosity measure. Using the tortuosity measure and time from meal intake, a regression polynomial is developed for predicting the blood glucose level. Diabetes is diagnosed if the tortuosity measure is less than 1.15. For effortless smartphone implementation, gluCam incorporates image processing techniques to quantify blood glucose levels. Our model reports a sensitivity of 94.28%, specificity of 82.61%, mean absolute error of 10.7%, and an overall accuracy of 91.89% (for 81 participants). The model remains unaffected by lighting conditions and independent to device platform. It thereby manifests itself as a definitive and appropriate substitution for the invasive laboratory blood glucose tests by buttressing the property of self-diagnosis of diabetes.
<p align="center">
  <img width="860" height="300" src="https://user-images.githubusercontent.com/59502132/143031898-22b407da-fd41-4bb7-a56c-3f7f6f12f201.png">
</p>

# Process Flow of gluCam
There are three main steps involved: Extracting Region of Interest (Step 1), Tortuosity and Blood Glucose Measurement (Step 2), and Smartphone-based Implementation (Step 3). In the following we explain each phase in detail along with the smart diabetic sensing.
<p align="center">
  <img width="760" height="400" src="https://user-images.githubusercontent.com/59502132/143031047-ee1cd4fa-5bc9-44f5-82b8-b53bdf87dfe3.png">
</p>

# Step-wise explanation of the functioning of gluCam
## Step 1:
Capture images of both the eyes. A good snapshot is preferred for the code to detect the eye, preferably at a distance of 7 – 12cm. The room should be normally lighted. Image of both the eyes should be taken in succession with a minute gap at-most. This is ensured by a timer set in the model that beeps to keep the user informed about the time frame to capture the second eye image.

## Step 2:
In Step 1, ROI from the digital eye image is extracted using five main functions: Extraction, Erosion, LargestArea, Merge, and Converter. Extraction removes the majority-white portion from the input image, followed by Erosion that dilates the white boundaries. From the dilated image the largest white region is extracted by LargestArea, merged with the original input image by Merge, and Converter outputs the required ROI.
<p align="left">
  <img width="300" height="250" src="https://user-images.githubusercontent.com/59502132/143079115-73e48dd0-cb84-410a-bf44-6c54bca3ee4d.png">
  <img width="300" height="250" src="https://user-images.githubusercontent.com/59502132/143079112-2abf5d0b-181c-4e4e-9966-e74e0cda02bc.png">
  <img width="300" height="250" src="https://user-images.githubusercontent.com/59502132/143079109-7ab1ab31-f2fe-405d-bb68-9f7f45fa5ca6.png">
</p>
<p align="center">
  <img width="560" height="600" src="https://user-images.githubusercontent.com/59502132/143029549-6360e3c4-0a1f-4fe9-8df4-19f0dc4639e5.png">
</p>

## Step 3:
The ROI obtained in Step 1 is processed in Step 2 for determining the tortuosity measure and blood glucose quantification using machine learning frameworks.
<p align="center">
  <img width="760" height="400" src="https://user-images.githubusercontent.com/59502132/143031452-9783d251-5a5a-422c-a5b6-25c3d2d38a12.png">
</p>

# Results:
## Some extracted ROIs by gluCam
<p align="center">
  <img width="860" height="300" src="https://user-images.githubusercontent.com/59502132/143031742-9379fdd6-ba10-4599-8b5b-f26446353e60.png">
</p>

## Analytical Results
<p align="center">
  <img width="660" height="300" src="https://user-images.githubusercontent.com/59502132/143030336-d2e0c018-b3c0-4793-8133-838d3bc6ff18.png">
</p>
<p align="center">
  <img width="660" height="300" src="https://user-images.githubusercontent.com/59502132/143030408-ba95cbee-b23d-4e63-bfd5-2ff030e63307.png">
</p>
<p align="center">
  <img width="660" height="300" src="https://user-images.githubusercontent.com/59502132/143030461-27a887a2-02ae-4859-bccf-66122b90d31d.png">
</p>

## Robustness to Light, Distance and Device Platform
<p align="center">
  <img width="660" height="300" src="https://user-images.githubusercontent.com/59502132/143030541-4006d43f-9dd3-47b0-9687-1e40bd6bb96e.png">
</p>

# Citation
If you find this work useful, use the code or the results in your research and academic work, consider citing the following:
```
@ARTICLE{9551982,
  author={Ghosal, Sagnik and Kumar, Abhishek and Udutalapally, Venkanna and Das, Debanjan},
  journal={IEEE Sensors Journal}, 
  title={gluCam: Smartphone Based Blood Glucose Monitoring and Diabetic Sensing}, 
  year={2021},
  volume={21},
  number={21},
  pages={24869-24878},
  doi={10.1109/JSEN.2021.3116191}}
```


