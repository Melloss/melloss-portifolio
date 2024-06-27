import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/battery/battery_bloc.dart';

PreferredSize ubuntuAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize:
        const Size.fromHeight(kToolbarHeight + 50.0), // Adjust height as needed
    child: Container(
        height: 33,
        color: Colors.black.withOpacity(0.86),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15)),
                  onPressed: () {
                    //
                  },
                  child: Text(
                    'Activities',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.8)),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15)),
                  onPressed: () {
                    //
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
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
                ),
              ],
            ),
            Positioned(
              right: 0,
              left: 0,
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15)),
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
              ),
            ),
          ],
        )),
  );
}
