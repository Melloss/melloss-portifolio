import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../gen/assets.gen.dart';

part 'landing_viewmodel.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Assets.images.ubuntuWallpaper1.image(
        width: 100.sh,
        height: 100.sw,
        fit: BoxFit.cover,
      ),
    );
  }
}
