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
  double _firstButtonOpacity = 1;
  double _secondButtonOpacity = 1;
  double _thirdButtonOpacity = 1;
  double _fourthButtonOpacity = 1;
  double _fifthButtonOpacity = 1;
  double _sixButtonOpacity = 1;

  Stream<double> _endSample() async* {
    advancedPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      s == AudioPlayerState.COMPLETED ? _opacity = 0 : _opacity = 1;
      s == AudioPlayerState.COMPLETED ? _isPlaying = false : _opacity = 0;
      s == AudioPlayerState.COMPLETED ? resetButtonOpacity() : _opacity = 0;
    });
  }

  resetButtonOpacity() {
    _firstButtonOpacity = 1;
    _secondButtonOpacity = 1;
    _thirdButtonOpacity = 1;
    _fourthButtonOpacity = 1;
    _fifthButtonOpacity = 1;
    _sixButtonOpacity = 1;
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

  changeButtonOpacity(int id) {
    id == 1 ? _firstButtonOpacity = 0 : _firstButtonOpacity = 1;

    id == 2 ? _secondButtonOpacity = 0 : _secondButtonOpacity = 1;
    id == 3 ? _thirdButtonOpacity = 0 : _thirdButtonOpacity = 1;

    id == 4 ? _fourthButtonOpacity = 0 : _fourthButtonOpacity = 1;
    id == 5 ? _fifthButtonOpacity = 0 : _fifthButtonOpacity = 1;

    id == 6 ? _sixButtonOpacity = 0 : _sixButtonOpacity = 1;
  }

  checkIfIsPlaying(String sampleName, int id) {
    print(id);

    _isPlaying == true ? _opacity = 1 : loadMusic(sampleName);
    _isPlaying == true ? _opacity = 1 : changeButtonOpacity(id);
  }

  Future loadMusic(String sampleName) async {
    advancedPlayer = await AudioCache(prefix: "music/").play("$sampleName");

    setState(() {
      _isPlaying = true;
      _opacity = 1;
    });
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
                      Opacity(
                        opacity: _firstButtonOpacity,
                        child: RaisedButton(
                          onPressed: () => checkIfIsPlaying("bass.wav", 1),
                          elevation: 50,
                          splashColor: Colors.redAccent,
                          shape: CircleBorder(),
                          color: Colors.redAccent,
                        ),
                      ),
                      Opacity(
                        opacity: _secondButtonOpacity,
                        child: RaisedButton(
                          onPressed: () => checkIfIsPlaying("bass.wav", 2),
                          elevation: 50,
                          splashColor: Colors.redAccent,
                          shape: CircleBorder(),
                          color: Colors.blue,
                        ),
                      ),
                      Opacity(
                        opacity: _thirdButtonOpacity,
                        child: RaisedButton(
                          onPressed: () => checkIfIsPlaying("bass.wav", 3),
                          elevation: 50,
                          splashColor: Colors.redAccent,
                          shape: CircleBorder(),
                          color: Colors.amberAccent,
                        ),
                      ),
                      Opacity(
                        opacity: _fourthButtonOpacity,
                        child: RaisedButton(
                          onPressed: () => checkIfIsPlaying("bass.wav", 4),
                          elevation: 50,
                          splashColor: Colors.redAccent,
                          shape: CircleBorder(),
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      Opacity(
                        opacity: _fifthButtonOpacity,
                        child: RaisedButton(
                          onPressed: () => checkIfIsPlaying("bass.wav", 5),
                          elevation: 50,
                          splashColor: Colors.redAccent,
                          shape: CircleBorder(),
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      Opacity(
                        opacity: _sixButtonOpacity,
                        child: RaisedButton(
                          onPressed: () => checkIfIsPlaying("bass.wav", 6),
                          elevation: 50,
                          splashColor: Colors.redAccent,
                          shape: CircleBorder(),
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                );
              })),
    ));
  }

// void changeOpacity() {
// setState(() {
// _opacity = 1;
//});
//}
}
