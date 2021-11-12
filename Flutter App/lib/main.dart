import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
//import 'package:IOTBloodGlucose/input.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
//import 'dart:convert' as convert;
//import 'package:http/http.dart' as http;
//import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
//import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



void main() => runApp(new MyApp());

String output='aa';
String output2='aa';
String _value='i';
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ImageCropper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'IOT Sensor Blood Glucose level',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  
  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum AppState {
  free,
  picked,
  cropped,
}
String str='';
class _MyHomePageState extends State<MyHomePage> {
  AppState state;
  File imageFile;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }
  fun()
  {
    double temp2=100*double.parse(str) -1.3*(double.parse(_value));
    output2=temp2.toString();

    if(double.parse(str) < 1.2)
    {
      output='Diabeties';
    }
    else
    {
      if(double.parse(str) > 1.3)
      {
        output='Normal';
      }
      else
      {
        double temp=(double.parse(str)-1.3)*100;
        output='% chance of diabetic= '+'$temp';
      }
    }

    Navigator.of(context)
        .push(
        MaterialPageRoute(
            builder: (context) => page2()
        )
    );

  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        //child: imageFile != null ? Image.file(imageFile) : Text(str),
        child: Column(
          children: [
            imageFile != null ? Image.file(imageFile) : Text(str),
            Text(_value),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.refresh),
                    tooltip: 'Comment Icon',
                    iconSize: 26,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget));
                    }
                ),
                IconButton(
                    icon: Icon(Icons.input),
                    tooltip: 'Comment Icon',
                    iconSize: 26,
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(
                              builder: (context) => input()
                          )
                      );
                    }
                ),
                IconButton(
                    icon: Icon(Icons.ac_unit_sharp),
                    tooltip: 'Comment Icon',
                    iconSize: 26,
                    onPressed: () {
                      fun();
                    }
                ),
              ],

            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          if (state == AppState.free){
            _pickImage();
            if(str == 'upload.jpeg'){
              setState(() { 
                loading = false;
              });
            }
          }else if (state == AppState.picked){
            _cropImage();
            str='';
          }else if (state == AppState.cropped){ 
            setState(() => loading = false);
            _clearImage();
            if(str == 'upload.jpeg'){
              setState(() { 
                loading = false;
              });
            }

          }
        },
        child: _buildButtonIcon(),
      ),
    );
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.check);
    else
      return Container();
  }

  Future<Null> _pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  void getHttpFile() async {
    FormData formData = new FormData.fromMap({
        "name": "wendux",
        "age": 25,
        "pic": await MultipartFile.fromFile(imageFile.path,filename: "upload.jpeg"),
        /*"files": [
          await MultipartFile.fromFile("./text1.txt", filename: "text1.txt"),
          await MultipartFile.fromFile("./text2.txt", filename: "text2.txt"),
        ]*/
    });

    BaseOptions options = new BaseOptions(
        //baseUrl: "https://www.xx.com/api",
        connectTimeout: 600000,
        receiveTimeout: 600000,
    );

    Dio dio = new Dio(options);

    Response response = await dio.post(
      "base_url(rest api url generated when uploaded to cloud)/file-upload",
      data: formData,
      onSendProgress: (int sent, int total) {
        print("$sent $total");
      },
    );

    print(response.data);
    str=response.data['torsion'].toString();
    if(response != null){
      loading = false;
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    getHttpFile();
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
    //return ans;
  }

  
}

class page2 extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Output')),
      body: Center(
          child:Column(
            children: [
              Text(output),
              Text(output2)
            ],
          )

      ),
    );
  }
}

class page3 extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Output')),
      body: Center(child: RaisedButton(
        onPressed: (){
          Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => MyApp()
              )
            );
        },
        child: Text('Go back'),
      )),
    );
  }
}

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}

class input extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return inputState();
  }
}


class inputState extends State<input> {



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildIn() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Value'),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Value is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _value = value;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Value")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                _buildIn(),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();


                    print(_value);


                  },
                ),
                RaisedButton(
                  child: Text(
                    'Back',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                        MaterialPageRoute(
                            builder: (context) => MyApp()
                        )
                    );


                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
