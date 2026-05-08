import 'package:flutter/material.dart';
import 'package:save_plant/core/widgets/header_section.dart';
import 'package:save_plant/feature/camera/presentation/views/widgets/photo_tips_view_body.dart';

class PhotoTipsView extends StatelessWidget {
  const PhotoTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeaderSection(title: 'Photo Guide'),
        automaticallyImplyLeading: false,
      ),
      body: PhotoTipsViewBody(),
    );
  }
}
