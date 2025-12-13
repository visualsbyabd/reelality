import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:v1/prefs/theme.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String video;
  final String thumbnail;
  final bool isPlaying;
  const VideoPage({
    super.key,
    required this.video,
    required this.thumbnail,
    required this.isPlaying,
  });

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  late bool isPaused = false;
  late bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = false;
    _controller = VideoPlayerController.asset(widget.video)
      ..initialize().then((_) {
        setState(() {
          isPaused = false;
          _controller.addListener(() {
            setState(() {
              isPaused = !_controller.value.isPlaying;
            });
          });
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.thumbnail),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),

          !isPaused
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shadowColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> states,
                      ) {
                        return Colors.transparent;
                      }),
                      overlayColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> states,
                      ) {
                        return Colors.transparent;
                      }),
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> states,
                      ) {
                        return Colors.transparent;
                      }),
                    ),
                    onPressed: () {
                      setState(() {
                        isPaused = true;
                      });
                      _controller.pause();
                    },
                    child: SizedBox(),
                  ),
                )
              : AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: !isPaused
                        ? Colors.transparent
                        : Colors.black.withValues(alpha: 0.3),
                  ),
                  child: !isPaused
                      ? Container()
                      : IconButton(
                          icon: Icon(
                            Icons.play_arrow_rounded,
                            size: 80,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                          onPressed: () {
                            setState(() {
                              isPaused = false;
                            });
                            _controller.play();
                          },
                        ),
                ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.5),
                    Colors.black.withValues(alpha: 0),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.15,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.25,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent vitae mi a quam porttitor efficitur. Maecenas sit amet neque tincidunt.",
                      style: TextStyle(
                        fontFamily: kEnglishPrimaryFont,
                        color: kCream,
                        fontSize: 16,
                      ),
                    ),
                    Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.075,
                          height: MediaQuery.of(context).size.width * 0.075,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/placeholders/profile/profile1.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Gap(8),
                        Text(
                          "@username",
                          style: TextStyle(
                            fontFamily: kEnglishPrimaryFont,
                            color: kCream.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.black.withValues(alpha: 0.5),
                    Colors.black.withValues(alpha: 0),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      icon: SvgPicture.asset(
                        isLiked
                            ? "assets/icons/heart-selected.svg"
                            : "assets/icons/heart.svg",
                        width: 32,
                        height: 32,
                        colorFilter: ColorFilter.mode(kCream, BlendMode.srcIn),
                      ),
                    ),
                    Gap(4),
                    Text(
                      "21.1K",
                      style: TextStyle(
                        fontFamily: kEnglishPrimaryFont,
                        color: kCream,
                        fontSize: 16,
                      ),
                    ),
                    Gap(24),
                    SvgPicture.asset(
                      "assets/icons/comment.svg",
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(kCream, BlendMode.srcIn),
                    ),
                    Gap(4),
                    Text(
                      "531",
                      style: TextStyle(
                        fontFamily: kEnglishPrimaryFont,
                        color: kCream,
                        fontSize: 16,
                      ),
                    ),
                    Gap(24),
                    SvgPicture.asset(
                      "assets/icons/bookmark.svg",
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(kCream, BlendMode.srcIn),
                    ),
                    Gap(4),
                    Text(
                      "122",
                      style: TextStyle(
                        fontFamily: kEnglishPrimaryFont,
                        color: kCream,
                        fontSize: 16,
                      ),
                    ),
                    Gap(24),
                    SvgPicture.asset(
                      "assets/icons/share.svg",
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(kCream, BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
