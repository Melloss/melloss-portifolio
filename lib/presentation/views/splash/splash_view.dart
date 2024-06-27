import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:melloss_portifolio/bloc/battery/battery_bloc.dart';
import 'package:melloss_portifolio/config/routes/go_routing.dart';

part 'splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final viewModel = SplashViewModel();

  Future<void> showCommandWidget() async {
    for (int i = 0; i < viewModel.commands.length; i++) {
      int halfIndex = viewModel.commands.length ~/ 2;
      if (i > halfIndex) {
        await Future.delayed(const Duration(milliseconds: 50));
      } else {
        await Future.delayed(const Duration(milliseconds: 300));
      }
      setState(() {
        viewModel.commandWigets.add(
          AnimatedTextKit(
            repeatForever: false,
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(
                viewModel.commands[i],
                speed: Duration(microseconds: i > halfIndex ? 10 : 300),
                textStyle: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  void initState() {
    context.read<BatteryBloc>().add(CheckBatterLevel());
    showCommandWidget().then((value) async {
      await Future.delayed(
        const Duration(milliseconds: 500),
      );
      // ignore: use_build_context_synchronously
      context.goNamed(RouteName.landing);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: NotificationListener(
          onNotification: (notification) {
            viewModel.scrollController.animateTo(
              viewModel.scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
            );

            return true;
          },
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            controller: viewModel.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: viewModel.commandWigets,
            ),
          ),
        ),
      ),
    );
  }
}
