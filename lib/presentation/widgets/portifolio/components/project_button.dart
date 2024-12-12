import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';
import 'package:melloss_portifolio/presentation/widgets/portifolio/components/project_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectButton extends StatelessWidget {
  final String projectImage;
  final String projectTechStacks;
  final String projectTitle;
  final String shortDescription;
  final String longDescription;
  final String link;
  final List<String> screenshots;

  const ProjectButton({
    super.key,
    required this.projectImage,
    required this.projectTechStacks,
    required this.projectTitle,
    required this.shortDescription,
    required this.screenshots,
    required this.link,
    required this.longDescription,
  });

  showProjectDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Align(
          child: ProjectDetail(
        title: projectTitle,
        images: screenshots,
        description: longDescription,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showProjectDetail(context);
      },
      child: Container(
        width: 340,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFABB2BF),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 340,
              height: 270,
              child: Image.asset(
                projectImage,
                width: 340,
                height: 270,
                fit: BoxFit.fill,
              ),
            ),
            const Divider(
              height: 1,
              color: ColorName.greyColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                projectTechStacks,
                style: const TextStyle(
                  fontSize: 18,
                  color: ColorName.greyColor,
                ),
              ),
            ),
            const Divider(
              height: 1,
              color: Color(0xFFABB2BF),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    projectTitle,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    shortDescription,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorName.greyColor,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF282C33),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: const BorderSide(
                              color: ColorName.primaryColor,
                              width: 2,
                            ))),
                    onPressed: () {
                      showProjectDetail(context);
                    },
                    child: Text(
                      "More",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.firaCode().fontFamily,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF282C33),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: const BorderSide(
                              color: ColorName.greyColor,
                              width: 2,
                            ))),
                    onPressed: () async {
                      final Uri uri = Uri.parse(link);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                    child: Text(
                      "Link",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.firaCode().fontFamily,
                        color: ColorName.greyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
