import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProjectDetail extends StatefulWidget {
  final String title;
  final String description;
  final List<String> images;
  const ProjectDetail(
      {super.key,
      required this.images,
      required this.title,
      required this.description});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  int selectedIndex = 0;
  String getUrlAddress(String fileID) {
    return 'https://www.googleapis.com/drive/v3/files/$fileID?alt=media&key=AIzaSyCAtbRmPnOklzrDRYZe4LBemLzNTjx80pI&v';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.sh,
      height: 97.sw,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF282C33),
        border: Border.all(
          color: const Color(0xFFABB2BF),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.close_rounded,
                color: ColorName.greyColor,
              ),
            ),
          ),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 32,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 27.sh,
                child: DefaultTextStyle(
                  style: TextStyle(
                      height: 1.5,
                      fontSize: 16,
                      fontFamily: GoogleFonts.firaCode().fontFamily,
                      color: const Color(0xFFABB2BF)),
                  child: AnimatedTextKit(
                    repeatForever: false,
                    isRepeatingAnimation: false,
                    pause: const Duration(milliseconds: 20),
                    animatedTexts: [
                      TypewriterAnimatedText(widget.description, cursor: "_"),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (selectedIndex > 0) {
                        setState(() {
                          selectedIndex = selectedIndex - 1;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: ColorName.greyColor,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 430,
                    height: 83.sw,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: getUrlAddress(widget.images[selectedIndex]),
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      if (selectedIndex < (widget.images.length - 1)) {
                        setState(() {
                          selectedIndex = selectedIndex + 1;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorName.greyColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
