import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'dart:async';


void main() {
  runApp(new MaterialApp(home: new SamplePlayer()));
}

class SamplePlayer extends StatefulWidget {
  @override
  _SamplePlayerState createState() => new _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  AudioPlayer myPlayer = AudioPlayer();
  AudioPlayerState isPlaying;
  Color _backgroundColor;
  double _firstButtonOpacity = 1;
  double _secondButtonOpacity = 1;
  double _thirdButtonOpacity = 1;
  double _fourthButtonOpacity = 1;
  double _fifthButtonOpacity = 1;
  double _sixButtonOpacity = 1;

  Stream<AudioPlayerState> _endSample() async* {
    myPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      if (s == AudioPlayerState.COMPLETED) {
        resetOpacity();
      }
      setState(() {
        isPlaying = s;
      });
    });
  }

  resetOpacity() {
    _firstButtonOpacity = 1;
    _secondButtonOpacity = 1;
    _thirdButtonOpacity = 1;
    _fourthButtonOpacity = 1;
    _fifthButtonOpacity = 1;
    _sixButtonOpacity = 1;
  }

  Widget button(BuildContext context, String sampleName, Color buttonColor,
      double opacity, int buttonId) {
    return Opacity(
      opacity: opacity,
      child: RaisedButton(
        onPressed: () => checkIfIsPlaying(sampleName, buttonId),
        elevation: 50,
        splashColor: Colors.redAccent,
        shape: CircleBorder(),
        color: buttonColor,
      ),
    );
  }

  checkIfIsPlaying(String sampleName, int buttonId) {
    isPlaying != AudioPlayerState.PLAYING
        ? loadMusic(sampleName, buttonId)
        : Container();
  }

  Color changeColor() {
    _backgroundColor == Colors.white70
        ? _backgroundColor = Colors.black
        : _backgroundColor = Colors.white70;
    const oneSecond = const Duration(seconds: 1);
    new Timer.periodic(oneSecond, (Timer t) => setState(() {}));

    return _backgroundColor.withOpacity(0.5);
  }

  Future loadMusic(String sampleName, int buttonId) async {
    myPlayer = await AudioCache(prefix: "music/").play(sampleName);
    changeOpacity(buttonId);
    {
      setState(() {
        isPlaying = AudioPlayerState.PLAYING;
      });
    }
  }

  changeOpacity(int buttonId) {
    if (buttonId == 1) {
      _firstButtonOpacity = 0;
    }
    if (buttonId == 2) {
      _secondButtonOpacity = 0;
    }
    if (buttonId == 3) {
      _thirdButtonOpacity = 0;
    }
    if (buttonId == 4) {
      _fourthButtonOpacity = 0;
    }
    if (buttonId == 5) {
      _fifthButtonOpacity = 0;
    }
    if (buttonId == 6) {
      _sixButtonOpacity = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    isPlaying = AudioPlayerState.COMPLETED;
    _backgroundColor = Colors.white70;



  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
          body: StreamBuilder<Object>(
              stream: _endSample(),
              builder: (context, snapshot) {
                return Center(
                    child: new Container(
                      color: isPlaying == AudioPlayerState.COMPLETED
                          ? changeColor()
                          : Colors.white70,
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 30,
                        crossAxisCount: 2,
                        children: <Widget>[
                          button(context, "bass.wav", Colors.redAccent,
                              _firstButtonOpacity, 1),
                          button(context, "bass.wav", Colors.blue,
                              _secondButtonOpacity, 2),
                          button(context, "bass.wav", Colors.amberAccent,
                              _thirdButtonOpacity, 3),
                          button(context, "bass.wav", Colors.green,
                              _fourthButtonOpacity, 4),
                          button(context, "bass.wav", Colors.deepOrangeAccent,
                              _fifthButtonOpacity, 5),
                          button(context, "bass.wav", Colors.deepPurpleAccent,
                              _sixButtonOpacity, 6),
                        ],
                      ),
                    ));
              })),
    );
  }
}