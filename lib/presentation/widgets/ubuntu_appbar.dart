import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:melloss_portifolio/bloc/brightness/brightness_bloc.dart';
import 'package:melloss_portifolio/config/routes/go_routing.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/battery/battery_bloc.dart';

PreferredSize ubuntuAppBar(BuildContext context,
    {Function()? onActivityClickes}) {
  return PreferredSize(
    preferredSize:
        const Size.fromHeight(kToolbarHeight + 50.0), // Adjust height as needed
    child: Container(
        height: 33,
        color: ColorName.darkBlackColor,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActivityButton(
                  onActiviyClicks: onActivityClickes,
                ),
                const UtilityButton(),
              ],
            ),
            const Positioned(
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
  bool isWifiExpanded = false;
  bool isBluetoothExpanded = false;
  bool isBatteryExpanded = false;
  bool isSettingExpanded = false;
  bool isLockExpanded = false;
  bool isPowerExpanded = false;

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
          constraints: const BoxConstraints.tightFor(
            width: 350,
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
                  Bootstrap.battery_half,
                  // Icons.battery_3_bar_outlined,
                  size: 20,
                  color: Colors.white70,
                ),
                const SizedBox(width: 10),
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
      PopupMenuItem(
        child: _buildExpansionTile(
            icon: Icons.signal_wifi_4_bar,
            title: 'Wi-Fi',
            isWhat: isWifiExpanded,
            childrens: [
              _buildExpanstionTileChild(
                title: 'Select Network',
                onPress: () {
                  //
                },
              ),
              _buildExpanstionTileChild(
                title: 'Turn Off',
                onPress: () {
                  //
                },
              ),
              _buildExpanstionTileChild(
                title: 'Wi-Fi Settings',
                onPress: () {
                  //
                },
              ),
            ]),
      ),
      PopupMenuItem(
        child: _buildExpansionTile(
            icon: Icons.bluetooth,
            title: 'Bluetooth On',
            isWhat: isBluetoothExpanded,
            childrens: [
              _buildExpanstionTileChild(
                title: 'Turn Off',
                onPress: () {
                  //
                },
              ),
              _buildExpanstionTileChild(
                title: 'Bluetooth Settings',
                onPress: () {
                  //
                },
              ),
            ]),
      ),
      PopupMenuItem(
        child: BlocBuilder<BatteryBloc, BatteryLevel>(
          builder: (context, state) {
            return _buildExpansionTile(
                icon: Bootstrap.battery_half,
                title: 'Power (${state.batterLevel} %)',
                isWhat: isBatteryExpanded,
                childrens: [
                  _buildExpanstionTileChild(
                    title: 'Power Settings',
                    onPress: () {
                      //
                    },
                  ),
                ]);
          },
        ),
      ),
      _buildPopupDivider(),
      PopupMenuItem(
        child: _buildExpansionTile(
            icon: Icons.settings,
            title: 'Settings',
            isWhat: isSettingExpanded,
            noTrailer: true,
            childrens: []),
      ),
      PopupMenuItem(
        child: _buildExpansionTile(
            icon: Icons.settings_power,
            title: 'Power off / Log out',
            isWhat: isPowerExpanded,
            childrens: [
              _buildExpanstionTileChild(
                title: 'Suspend',
                onPress: () {
                  context.pop();
                  context.goNamed(RouteName.inactive, extra: RouteName.landing);
                },
              ),
              _buildExpanstionTileChild(
                title: 'Restart...',
                onPress: () {
                  context.pop();
                  context.goNamed(RouteName.boot);
                },
              ),
              _buildExpanstionTileChild(
                title: 'Power Off',
                onPress: () {
                  context.pop();
                  context.goNamed(RouteName.inactive, extra: RouteName.boot);
                },
              ),
              _buildExpanstionTileChild(
                title: 'Log Out',
                onPress: () {
                  context.pop();
                  context.goNamed(RouteName.landing);
                },
              ),
            ]),
      ),
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

  _buildExpansionTile({
    required bool isWhat,
    required String title,
    required IconData icon,
    required List<Widget> childrens,
    bool noTrailer = false,
  }) {
    return StatefulBuilder(
      builder: (context, setS) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: ExpansionTile(
            onExpansionChanged: (value) {
              setS(() {
                isWhat = !isWhat;
              });
            },
            initiallyExpanded: isWhat,
            tilePadding: const EdgeInsets.symmetric(horizontal: 5),
            trailing: noTrailer
                ? null
                : Icon(
                    isWhat
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_right,
                  ),
            title: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                ),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 15,
                      ),
                ),
              ],
            ),
            children: childrens,
          ),
        );
      },
    );
  }

  _buildExpanstionTileChild({
    required String title,
    required Function() onPress,
  }) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const ContinuousRectangleBorder(),
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
        ),
        onPressed: onPress,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 14,
                  ),
            ),
          ),
        ),
      ),
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
        onPressed: () async {
          final position = Offset((100.sh / 3.2), 40);
          final overlay =
              Overlay.of(context).context.findRenderObject() as RenderBox;
          await showMenu(
            context: context,
            position: RelativeRect.fromRect(
                position & const Size(40, 40), Offset.zero & overlay.size),
            useRootNavigator: true,
            popUpAnimationStyle:
                AnimationStyle(duration: const Duration(milliseconds: 200)),
            constraints: const BoxConstraints.tightFor(
              width: 750,
            ),
            items: _buildNotificationCalander(context),
          );
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

  List<PopupMenuEntry<dynamic>> _buildNotificationCalander(
      BuildContext context) {
    return [
      PopupMenuItem(
          enabled: false,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Bootstrap.bell_fill,
                        size: 30,
                        color: Colors.white60,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'No Notifications',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white60,
                                ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 400,
                color: Colors.white60,
                width: 0.5,
              ),
              Flexible(
                flex: 3,
                child: SizedBox(
                  height: 400,
                  child: _buildCalander(context),
                ),
              ),
            ],
          ))
    ];
  }

  _buildCalander(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            DateFormat('E').format(DateTime.now()),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white60,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            DateFormat('MMM dd  yyyy').format(DateTime.now()),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white60,
                ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Text(
              DateFormat('MMM').format(DateTime.now()),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white60,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Wrap(
                children: List.generate(
              31,
              (index) => _buildCalanderButton(
                '${index + 1}'.padLeft(2, '0'),
                DateFormat('dd').format(DateTime.now()),
              ),
            )),
          )
        ],
      ),
    );
  }

  _buildCalanderButton(String name, String currentDay) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          backgroundColor: currentDay == name ? ColorName.primaryColor : null),
      onPressed: () {
        //
      },
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white60,
        ),
      ),
    );
  }
}

class ActivityButton extends StatelessWidget {
  final Function()? onActiviyClicks;
  const ActivityButton({super.key, required this.onActiviyClicks});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
      onPressed: onActiviyClicks,
      child: Text(
        'Activities',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.8)),
      ),
    );
  }
}
