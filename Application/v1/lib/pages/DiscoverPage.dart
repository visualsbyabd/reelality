import 'package:flutter/material.dart';
import 'package:v1/components/BottomNavBar.dart';
import 'package:v1/components/DefaultAppBar.dart';

class DiscoverPage extends StatefulWidget {
  final PageController pagesController;

  const DiscoverPage({super.key, required this.pagesController});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
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
