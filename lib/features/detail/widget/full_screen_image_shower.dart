import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageShower extends StatefulWidget {
  final String imageUrl;
  const FullScreenImageShower({super.key, required this.imageUrl});

  @override
  State<FullScreenImageShower> createState() => _FullScreenImageShowerState();
}

class _FullScreenImageShowerState extends State<FullScreenImageShower> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.black),
          enableRotation: false,
          initialScale: PhotoViewComputedScale.contained * 1,
          imageProvider: NetworkImage(widget.imageUrl),
        ),
      ),
    );
  }
}