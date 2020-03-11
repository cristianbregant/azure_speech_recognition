import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:azure_speech_recognition/azure_speech_recognition.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _centerText = 'Unknown';
  AzureSpeechRecognition _speechAzure;
  String subKey = "your_key";
  String region = "your_server_region";
  String lang = "it-IT";
  bool isRecording = false;

void activateSpeechRecognizer(){
    // MANDATORY INITIALIZATION
  AzureSpeechRecognition.initialize(subKey, region,lang: lang);
  
  _speechAzure.setFinalTranscription((text) {
    // do what you want with your final transcription
    setState(() {
      _centerText = text;
      isRecording = false;
    });

  });

  _speechAzure.setRecognitionStartedHandler(() {
   // called at the start of recognition (it could also not be used)
    isRecording = true;
  });

}
  @override
  void initState() {
    
    _speechAzure = new AzureSpeechRecognition();

    activateSpeechRecognizer();

    super.initState();
  }

Future _recognizeVoice() async {
    try {
      AzureSpeechRecognition.simpleVoiceRecognition();//await platform.invokeMethod('azureVoice');
     
    } on PlatformException catch (e) {
      print("Failed to get text '${e.message}'.");
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('TEXT RECOGNIZED : $_centerText\n'),
              FloatingActionButton(
                onPressed: (){
                  if(!isRecording)_recognizeVoice();
                },
                child: Icon(Icons.mic),),
            ],
          ),
        ),
      ),
    );
  }
}
