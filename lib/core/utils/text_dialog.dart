import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';

Future<String> showTextDialog(BuildContext context,
    {String hintText = 'folder name'}) async {
  final textController = TextEditingController();
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        titlePadding: const EdgeInsets.all(10),
        backgroundColor: ColorName.forgroundColor,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: const WidgetStatePropertyAll(
                      ColorName.backgroundColor,
                    ),
                  ),
                  onPressed: () {
                    textController.text = '';
                    context.pop();
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: const WidgetStatePropertyAll(
                      ColorName.backgroundColor,
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    'Ok',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 500,
              child: TextField(
                onSubmitted: (value) {
                  context.pop();
                },
                style: Theme.of(context).textTheme.titleMedium,
                controller: textController,
                autofocus: true,
                decoration: InputDecoration(
                    fillColor: ColorName.forgroundColor,
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: ColorName.primaryColor,
                      width: 2,
                    )),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: ColorName.primaryColor,
                    )),
                    hintText: hintText,
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white60,
                            )),
              ),
            ),
          ],
        ),
      );
    },
  );
  return textController.text;
}
