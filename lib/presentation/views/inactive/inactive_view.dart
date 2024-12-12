import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InactiveView extends StatelessWidget {
  final String routeName;
  const InactiveView({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (_) {
        context.goNamed(routeName);
      },
      child: GestureDetector(
        onTap: () {
          context.goNamed(routeName);
        },
        onTapDown: (_) {
          context.goNamed(routeName);
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Text(
              "🖱️ Click or ⌨️ press any key to exit 🚪",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
