import 'package:flutter/material.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';

class SkillTable extends StatelessWidget {
  final String tableName;
  final String tableContent;
  final double width;
  const SkillTable(
      {super.key,
      required this.tableName,
      required this.tableContent,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: width,
      decoration: BoxDecoration(
          border: Border.all(
        color: ColorName.greyColor,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              tableName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
          ),
          const Divider(
            height: 1,
            color: ColorName.greyColor,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              tableContent,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 16,
                    color: ColorName.greyColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
