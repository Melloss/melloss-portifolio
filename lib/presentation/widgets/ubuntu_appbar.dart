import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melloss_portifolio/bloc/brightness/brightness_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/battery/battery_bloc.dart';

PreferredSize ubuntuAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize:
        const Size.fromHeight(kToolbarHeight + 50.0), // Adjust height as needed
    child: Container(
        height: 33,
        color: Colors.black.withOpacity(0.86),
        child: const Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActivityButton(),
                UtilityButton(),
              ],
            ),
            Positioned(
              right: 0,
              left: 0,
              child: DateTimeButton(),
            ),
          ],
        )),
  );
}

class UtilityButton extends StatefulWidget {
  const UtilityButton({super.key});

  @override
  State<UtilityButton> createState() => _UtilityButtonState();
}

class _UtilityButtonState extends State<UtilityButton> {
  double soundLevel = 70.0;
  double brightnessLevel = 100.0;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
      onPressed: () async {
        final position = Offset(100.sh, 40);
        final overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        await showMenu(
          context: context,
          position: RelativeRect.fromRect(
              position & const Size(40, 40), Offset.zero & overlay.size),
          useRootNavigator: true,
          popUpAnimationStyle:
              AnimationStyle(duration: const Duration(milliseconds: 200)),
          constraints: BoxConstraints.tight(
            const Size(350, 400),
          ),
          items: _buildUtils(),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.signal_wifi_4_bar,
              size: 18,
              color: Colors.white70,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.volume_up,
              size: 20,
              color: Colors.white70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.battery_3_bar_outlined,
                  size: 20,
                  color: Colors.white70,
                ),
                const SizedBox(width: 5),
                BlocBuilder<BatteryBloc, BatteryLevel>(
                  builder: (context, state) {
                    return Text(
                      '${state.batterLevel} %',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PopupMenuEntry<dynamic>> _buildUtils() {
    return [
      PopupMenuItem(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.volume_up,
              color: Colors.white,
              size: 20,
            ),
            StatefulBuilder(builder: (context, setS) {
              return SizedBox(
                width: 290,
                child: Slider(
                  value: soundLevel,
                  onChanged: (value) {
                    setS(() {
                      soundLevel = value;
                    });
                  },
                  min: 0,
                  max: 100,
                ),
              );
            })
          ],
        ),
      )),
      PopupMenuItem(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.brightness_4_outlined,
              color: Colors.white,
              size: 20,
            ),
            StatefulBuilder(builder: (context, setS) {
              return SizedBox(
                width: 290,
                child: Slider(
                  value: brightnessLevel,
                  onChanged: (value) {
                    setS(() {
                      brightnessLevel = value;
                    });
                    context.read<BrightnessBloc>().add(
                          ChangeBrightness(brightnessLevel: (value / 100)),
                        );
                  },
                  min: 0,
                  max: 100,
                ),
              );
            })
          ],
        ),
      )),
      _buildPopupDivider(),
    ];
  }

  PopupMenuItem _buildPopupDivider() {
    return const PopupMenuItem(
      height: 20,
      enabled: false,
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Divider(
            height: 0.5,
            color: Colors.white24,
          )),
    );
  }
}

class DateTimeButton extends StatelessWidget {
  const DateTimeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
        onPressed: () {
          //
        },
        child: Text(
          DateFormat('MMM dd  HH:mm').format(DateTime.now()),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.8),
              ),
        ),
      ),
    );
  }
}

class ActivityButton extends StatelessWidget {
  const ActivityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
      onPressed: () {
        //
      },
      child: Text(
        'Activities',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.8)),
      ),
    );
  }
}
