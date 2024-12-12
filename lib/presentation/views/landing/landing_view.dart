// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:melloss_portifolio/bloc/file_system/file_system_bloc.dart';
import 'package:melloss_portifolio/config/routes/go_routing.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';
import 'package:melloss_portifolio/presentation/widgets/loading_animation.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../gen/assets.gen.dart';

part 'landing_viewmodel.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final viewModel = LandingViewmodel();

  enterPressHandler() async {
    context.read<FileSystemBloc>().add(PushTo(path: 'Desktop'));
    setState(() {
      viewModel.isEnterPressed = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        viewModel.isEnterPressed = false;
      });
    }

    context.goNamed(RouteName.desktop);
  }

  bool isFullScreen() {
    return html.document.fullscreenElement != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Assets.images.ubuntuWallpaper.image(
            width: 100.sh,
            height: 100.sw,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 70,
              sigmaY: 70,
            ),
            child: Container(
              color: ColorName.white.withOpacity(0.0), // Transparent container
            ),
          ),
          _buildLogin(),
        ],
      ),
    );
  }

  _buildLogin() {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          SizedBox(
            width: 450,
            height: 35.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: Assets.images.mellossPic.provider(),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 30),
                  child: Text(
                    'Melloss Dev',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                        ),
                  ),
                ),
                SizedBox(
                  width: 18.sh,
                  child: TextField(
                    onEditingComplete: enterPressHandler,
                    obscureText: viewModel.isObscure,
                    autofocus: true,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16,
                        ),
                    obscuringCharacter: '●',
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.7)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            viewModel.isObscure = !viewModel.isObscure;
                          });
                        },
                        icon: Icon(
                          viewModel.isObscure
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                          color: ColorName.white.withOpacity(0.7),
                          size: 21,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    '( just press enter to login )',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -5,
            bottom: 0,
            top: isFullScreen() ? 3.5.sw : 8.sw,
            child: SizedBox(
              width: 50,
              child: Visibility(
                  visible: viewModel.isEnterPressed,
                  child: const LoadingAnimation()),
            ),
          )
        ],
      ),
    );
  }
}
