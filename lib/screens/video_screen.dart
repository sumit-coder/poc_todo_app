import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  late Duration dueration;

  bool isPlaying = false;
  double videoVolume = 1.0;
  double _currentSliderValue = 1;

  videoIsEnded() {
    isPlaying = false;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: false,
        mixWithOthers: false,
      ),
    );

    _initializeVideoPlayerFuture = _controller.initialize().then((value) {
      dueration = _controller.value.duration;
      _controller.addListener(() {
        if (_controller.value.duration == _controller.value.position) {
          setState(() {
            isPlaying = false;
          });
        }
      });
    });
    // _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Card(
                        color: const Color.fromARGB(255, 73, 73, 73),
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          // color: Colors.blue,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                child: AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  // Use the VideoPlayer widget to display the video.
                                  child: VideoPlayer(_controller),
                                ),
                              ),
                              Container(
                                // height: 40,
                                // width: 200,
                                padding: EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ValueListenableBuilder(
                                          valueListenable: _controller,
                                          builder: (context, VideoPlayerValue value, child) {
                                            if (value.position == _controller.value.duration) {
                                              // Video is Ended

                                              videoIsEnded();
                                            }
                                            return Text(
                                              value.position.inSeconds.toString(),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Container(
                                              height: 5,
                                              child: VideoProgressIndicator(
                                                _controller,
                                                allowScrubbing: false,
                                                padding: EdgeInsets.zero,
                                                colors: const VideoProgressColors(
                                                    backgroundColor: Colors.grey,
                                                    bufferedColor: Color.fromARGB(255, 99, 99, 99),
                                                    playedColor: Colors.blueAccent),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          _controller.value.duration.inSeconds.toString(),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          color: Colors.grey,
                                          onPressed: () {
                                            if (videoVolume == 1.0) {
                                              _controller.setVolume(0.0);
                                              setState(() {
                                                videoVolume = 0.0;
                                              });
                                            } else {
                                              _controller.setVolume(1.0);
                                              setState(() {
                                                videoVolume = 1.0;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            videoVolume != 0.0
                                                ? Icons.volume_down
                                                : Icons.volume_mute,
                                          ),
                                        ),
                                        IconButton(
                                          color: Colors.grey,
                                          onPressed: () {
                                            if (isPlaying == false) {
                                              _controller.play();

                                              setState(() {
                                                isPlaying = true;
                                              });
                                            } else {
                                              _controller.pause();

                                              setState(() {
                                                isPlaying = false;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            isPlaying ? Icons.pause : Icons.play_arrow,
                                          ),
                                        ),
                                        IconButton(
                                          color: Colors.grey,
                                          onPressed: () {
                                            _controller.seekTo(
                                              Duration(
                                                seconds: _controller.value.position.inSeconds + 1,
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.forward_10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Volume Slider
                                    Container(
                                      width: 200,
                                      child: Slider(
                                        value: _currentSliderValue,
                                        max: 1,
                                        min: 0,
                                        // divisions: 10,
                                        label: _currentSliderValue.round().toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _currentSliderValue = value;
                                          });
                                          _controller.setVolume(value);
                                          setState(() {
                                            videoVolume = value;
                                          });
                                        },
                                      ),
                                    ),
                                    //
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
