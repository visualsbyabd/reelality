import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:v1/components/BottomNavBar.dart';
import 'package:v1/components/DefaultAppBar.dart';
import 'package:v1/components/VideoPage.dart';

@RoutePage(name: "/")
@RoutePage(name: "/home/")
class HomeScreen extends StatefulWidget {
  final PageController pagesController;
  const HomeScreen({super.key, required this.pagesController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController videoController = PageController();
  late double currentPlayingIndex = 0;
  final videos = [
    {
      "video": "assets/placeholders/videos/1.mp4",
      "thumbnail": "assets/placeholders/thumbnails/1.png",
    },
    {
      "video": "assets/placeholders/videos/2.mp4",
      "thumbnail": "assets/placeholders/thumbnails/2.png",
    },
    {
      "video": "assets/placeholders/videos/3.mp4",
      "thumbnail": "assets/placeholders/thumbnails/3.png",
    },
    {
      "video": "assets/placeholders/videos/4.mp4",
      "thumbnail": "assets/placeholders/thumbnails/4.png",
    },
    {
      "video": "assets/placeholders/videos/5.mp4",
      "thumbnail": "assets/placeholders/thumbnails/5.png",
    },
    {
      "video": "assets/placeholders/videos/6.mp4",
      "thumbnail": "assets/placeholders/thumbnails/6.png",
    },
    {
      "video": "assets/placeholders/videos/7.mp4",
      "thumbnail": "assets/placeholders/thumbnails/7.png",
    },
    {
      "video": "assets/placeholders/videos/8.mp4",
      "thumbnail": "assets/placeholders/thumbnails/8.png",
    },
    {
      "video": "assets/placeholders/videos/9.mp4",
      "thumbnail": "assets/placeholders/thumbnails/9.png",
    },
    {
      "video": "assets/placeholders/videos/10.mp4",
      "thumbnail": "assets/placeholders/thumbnails/10.png",
    },
  ];
  @override
  void initState() {
    videoController.addListener(() {
      setState(() {
        currentPlayingIndex = videoController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: videoController,
                children: [
                  for (var i = 0; i < videos.length; i++)
                    VideoPage(
                      isPlaying: currentPlayingIndex == i,
                      video: videos[i]["video"]!,
                      thumbnail: videos[i]["thumbnail"]!,
                    ),
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.025,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              child: BottomNavbar(pagesController: widget.pagesController),
            ),
            Positioned(top: 0, child: DefaultAppBar()),
          ],
        ),
      ),
    );
  }
}
