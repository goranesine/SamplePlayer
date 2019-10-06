import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:random_color/random_color.dart';

void main() {
  runApp(new MaterialApp(home: new ExampleApp()));
}

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => new _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  AudioPlayer advancedPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  double _opacity = 0;
  Color _backgroundColor;
  bool _isPlaying = false;

  Stream<double> _endSample() async* {
    advancedPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      s == AudioPlayerState.COMPLETED ? _opacity = 0 : _opacity = 1;
      s == AudioPlayerState.COMPLETED ? _isPlaying = false : _opacity = 0;
    });
  }

  Color randomizecolor() {
    setState(() {
      RandomColor _randomColor = RandomColor();
      _backgroundColor = _randomColor.randomColor();
      const oneSecond = const Duration(seconds: 5);
      new Timer.periodic(oneSecond, (Timer t) => setState(() {}));
    });
    return _backgroundColor;
  }

  checkIfIsPlaying(String sampleName) {
    print("is-----play$_isPlaying");
    _isPlaying == true ? _opacity = 1 : loadMusic(sampleName);
  }

  Future loadMusic(String sampleName) async {
    //changeOpacity();
    advancedPlayer = await AudioCache(prefix: "music/").play("$sampleName");

    setState(() {
      _isPlaying = true;
      _opacity = 1;
    });
    print("isPlajening je $_isPlaying");
  }

  @override
  void dispose() {
    advancedPlayer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      child: Scaffold(
          backgroundColor: randomizecolor(),
          body: StreamBuilder<double>(
              stream: _endSample(),
              initialData: 0.0,
              builder: (context, asyncSnapshot) {
                return Container(
                  color: const Color(0xFFF3F3F3).withOpacity(_opacity),
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 30,
                    crossAxisCount: 2,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => checkIfIsPlaying("bass.wav"),
                        elevation: 50,
                        splashColor: Colors.redAccent,
                        shape: CircleBorder(),
                        color: Colors.redAccent,
                      ),
                      RaisedButton(
                        onPressed: () => checkIfIsPlaying("bass.wav"),
                        elevation: 50,
                        splashColor: Colors.redAccent,
                        shape: CircleBorder(),
                        color: Colors.blue,
                      ),
                      RaisedButton(
                        onPressed: () => checkIfIsPlaying("bass.wav"),
                        elevation: 50,
                        splashColor: Colors.redAccent,
                        shape: CircleBorder(),
                        color: Colors.amberAccent,
                      ),
                      RaisedButton(
                        onPressed: () => checkIfIsPlaying("bass.wav"),
                        elevation: 50,
                        splashColor: Colors.redAccent,
                        shape: CircleBorder(),
                        color: Colors.deepOrangeAccent,
                      ),
                      RaisedButton(
                        onPressed: () => checkIfIsPlaying("bass.wav"),
                        elevation: 50,
                        splashColor: Colors.redAccent,
                        shape: CircleBorder(),
                        color: Colors.deepPurpleAccent,
                      ),
                      RaisedButton(
                        onPressed: () => checkIfIsPlaying("bass.wav"),
                        elevation: 50,
                        splashColor: Colors.redAccent,
                        shape: CircleBorder(),
                        color: Colors.green,
                      ),
                    ],
                  ),
                );
              })),
    ));
  }

  void changeOpacity() {
    setState(() {
      _opacity = 1;
    });
  }
}
