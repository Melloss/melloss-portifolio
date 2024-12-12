import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:melloss_portifolio/gen/assets.gen.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';
import 'package:melloss_portifolio/presentation/widgets/portifolio/components/project_button.dart';
import 'package:melloss_portifolio/presentation/widgets/portifolio/components/skill_table.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class PortifolioManPage extends StatelessWidget {
  const PortifolioManPage({super.key});
  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    // Adjust if the birthday hasn't occurred yet this year
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF282C33),
      width: 100.sh,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Row(
        children: [
          Container(
            width: 60,
            margin: const EdgeInsets.only(right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 1,
                  height: 190,
                  color: const Color(0xFFABB2BF),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () async {
                    final Uri uri = Uri.parse("https://github.com/melloss");
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                  icon: const Icon(
                    Bootstrap.github,
                    color: Color(0xFFABB2BF),
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () async {
                    final Uri uri =
                        Uri.parse("https://www.linkedin.com/in/melloss/");
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                  icon: const Icon(
                    Bootstrap.linkedin,
                    color: Color(0xFFABB2BF),
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () async {
                    final Uri uri = Uri.parse("https://t.me/mellossDev");
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                  icon: const Icon(
                    Bootstrap.telegram,
                    color: Color(0xFFABB2BF),
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () async {
                    final Uri emailUri = Uri(
                      scheme: 'mailto',
                      path: 'mellossdev@gmail.com',
                      queryParameters: {
                        'subject': 'Hello Melloss',
                      },
                    );

                    if (await canLaunchUrl(emailUri)) {
                      await launchUrl(emailUri);
                    }
                  },
                  icon: const Icon(
                    Icons.mail,
                    size: 27,
                    color: Color(0xFFABB2BF),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTop(),
                  _buildProjectSection(),
                  _buildSkills(),
                  _buildAboutMe(),
                  _buildContacts(),
                  const SizedBox(height: 100),
                  const Divider(
                    color: ColorName.greyColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildContactButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF282C33),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: const BorderSide(
                color: ColorName.primaryColor,
                width: 2,
              ))),
      onPressed: () async {
        final Uri uri = Uri.parse("https://t.me/mellossDev");
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Text(
        "Contact Me!!",
        style: TextStyle(
          fontSize: 16,
          fontFamily: GoogleFonts.firaCode().fontFamily,
          color: Colors.white,
        ),
      ),
    );
  }

  _buildTop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Hi, I'm ",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontFamily: GoogleFonts.firaCode().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontFamily: GoogleFonts.firaCode().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  repeatForever: false,
                  isRepeatingAnimation: false,
                  pause: const Duration(milliseconds: 100),
                  animatedTexts: [
                    RotateAnimatedText(
                      'Melloss',
                      rotateOut: false,
                      textStyle: const TextStyle(
                        color: ColorName.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50.sh,
                  height: 100,
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
                        TypewriterAnimatedText(
                            'A passionate software developer specializing in Flutter and Android Native development. With a keen eye for detail and a commitment to delivering high-quality, user-friendly applications, I bring ideas to life through clean and efficient code.',
                            cursor: "_"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                _buildContactButton(),
              ],
            ),
            SizedBox(
              height: 300,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: SvgPicture.asset(Assets.svgs.p1)),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(
                      Assets.svgs.p2,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildProjectSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "#",
              style: TextStyle(
                fontSize: 32,
                color: ColorName.primaryColor,
              ),
            ),
            const Text(
              "projects",
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 30.sh,
              height: 1,
              color: ColorName.primaryColor,
            )
          ],
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 60,
          children: [
            ProjectButton(
              projectTitle: 'Arganon',
              shortDescription: "Religious Mobile App",
              projectImage: Assets.images.arganon.path,
              projectTechStacks: 'Flutter, Firebase, Bloc',
              link: 'https://arganon.app/',
              screenshots: const [
                '1v-9AeUJ4oOnG0jJcvzSD8P7xf9XPYCjo',
                '1cm-ApsG06kkgdQfurmY4q3_QyYpRl_sq',
                '1Fczyvi7XYZCtmL22NHcqS8FGd0wTsYbN',
                '1ZXMD5vIF_m0S4pm6wO3wmRl9L8OC5mlC',
                '1W0fGOUILsyp1zN2BODPn4wmqeHVC-Nfs',
                '1YfSXgokYdMxRCwCxnGM84URFRNmnqiPn',
                '1fzOYFYn8Am8Fl4P_bTWN49UpI51oMhai',
                '1ADSEjT5Axs66sINrO-QyZte82pskSipk',
                '14OAKyGuZ9LRWYyDlkllroyw9ZPbvzeIO'
              ],
              longDescription:
                  '''Arganon is religious mobile app that enables users to download and listen Ethiopian Orthodox Church Mezmurs with Lyrics and it also helps users to learn Ethiopian Orthodox Church Liturgy (Kidase).
            
  ● flutter_bloc: for State Management
  ● go_router: for Route management
  ● shared_preferences: for local caching
  ● firebase_database: for storage
  ● firebase_messaging: for push notification
  ● dio: to download Mezmur (Song)
  ● assets_audio_player: to play Mezmur (Song)
  ● audioplayers: to play Kidase (Liturgy)
  ● flu_wake_lock: to keep the device screen awake
  ● freerasp: for security monitoring''',
            ),
            ProjectButton(
              projectTitle: 'Mela Finance',
              shortDescription: "Financial Mobile App",
              projectImage: Assets.images.melaFinance.path,
              projectTechStacks: 'Flutter, Bloc, Stripe, Jumio, Plaid',
              link:
                  'https://play.google.com/store/apps/details?id=com.melafinance.wallet',
              screenshots: const [
                '1j25eQ5g7iKWzPhn34efnXwzYEqqgtXBQ',
                '15F63vXF2UK8nyN2bQoEUss_MCN05KNII',
                '1lARmBuC-S6WQtIriwrrBy5qD724hBIu5',
                '1vDysp-z5g_vcpWD3u4D5ZT1oNORRyJE4',
                '1JMA3sBqauzLvnI_fhTkZkA9T5n3rkBy-',
                '1c--FNupXmG8u-ZjoR518iS6H8EwloKKX',
                '1PpnOEDlpbXnjRBaTgUP2neHnja_HxHAJ',
                '18ZN8m_bz2qaVX6P4ta5IRBA6riRDopGR',
              ],
              longDescription:
                  '''Mela Finance is a financial wallet app designed to simplify your money management. It allows users to send and receive money instantly and also it has Equb feature.
            
  ● flutter_bloc: for State Management
  ● go_router: for Route management
  ● flutter_secure_storage: for secure local caching
  ● plaid_flutter: for plaid integration
  ● flutter_stripe: for stripe integration
  ● jumio_mobile_sdk_flutter: for jumio(KYC) integration
  ● sentry_flutter: for sentry integration
  ● webview_flutter: for showing terms and conditions
  ● pretty_qr_code: for QR code generation
  ● http_interceptor: for http request and interceptor implementation
  ● printing: for printing Receipt''',
            ),
            ProjectButton(
              projectTitle: 'CLiQ',
              shortDescription: "Contest Mobile App",
              projectImage: Assets.images.cliq.path,
              projectTechStacks: 'Flutter, Bloc, AppLink/DeepLink',
              link:
                  'https://play.google.com/store/apps/details?id=net.cliqapp.CLiQ',
              screenshots: const [
                '1gB0aIQm7KaJBvklV-oXBX1HLpNlIHMb9',
                '1deRbu8LTjTWZo7n4bpI4PAmTou6AcI75',
                '1vGrn6SgC1dCmDASazG-IHkpo9QheXM6M',
                '14bgS-QrOry7kaDJ-5cu6sGTw9NATTGsG',
                '18Ay2LPC7WyCf4IRk-MyV58fDOn32EEJk',
                '1aVp9trS0MUsZVoWmYMwtakjvHIL3ZRU7',
                '1e5x5e2NXzAK60-bxJ_P-b1ohB9mmoRgk',
                '14gZugt8gfI4Y2QbAdrAk4uW8pC1wQtaI',
                '1lcJDkVilmPe_RH6FQGnGr4W0reRFePft',
              ],
              longDescription:
                  '''CLiQ is an exciting contest platform that lets you showcase your skills and compete with others. It has single-contest to challenge yourself, multi-contest to compete with friends or rivals, and live-contest for real-time, adrenaline-filled competitions.
            
  ● flutter_bloc: for State Management
  ● go_router: for Route management
  ● easy_localization: for multilingual support 
  ● uni_links: for applink/deeplink support
  ● http: for http request
  ● qr_flutter: for QR code generation
  ● qr_code_scanner: for scanning QR code
  ● firebase_messaging: for push notification
  ● flu_wake_lock: to keep the device screen awake
  ● secure_application: tp prevent taking screenshot during contest''',
            ),
          ],
        ),
      ],
    );
  }

  _buildSkills() {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "#",
                style: TextStyle(
                  fontSize: 32,
                  color: ColorName.primaryColor,
                ),
              ),
              const Text(
                "skills",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 24.sh,
                height: 1,
                color: ColorName.primaryColor,
              )
            ],
          ),
          const SizedBox(height: 40),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 20,
            children: [
              SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svgs.p2,
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(width: 60),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: ColorName.greyColor,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svgs.p1,
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(width: 70),
                        SvgPicture.asset(
                          Assets.svgs.p2,
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(width: 70),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: ColorName.greyColor,
                          )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SkillTable(
                tableName: 'Languages',
                tableContent: 'Dart Kotlin Java Python C++',
                width: 150,
              ),
              const SkillTable(
                tableName: 'Frameworks',
                tableContent: 'Flutter Jetpack-Compose React Next.js Django Qt',
                width: 200,
              ),
              const SkillTable(
                tableName: 'Tools',
                tableContent:
                    'Git VSCode Android-Studio Figma Firebase Supabase Shorebird Chatgpt CodeMagic Device-Preview',
                width: 300,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildAboutMe() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "#",
                style: TextStyle(
                  fontSize: 32,
                  color: ColorName.primaryColor,
                ),
              ),
              const Text(
                "about-me",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 30.sh,
                height: 1,
                color: ColorName.primaryColor,
              )
            ],
          ),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 45.sh,
                child: DefaultTextStyle(
                  style: TextStyle(
                      height: 1.5,
                      fontSize: 16,
                      fontFamily: GoogleFonts.firaCode().fontFamily,
                      color: const Color(0xFFABB2BF)),
                  child: AnimatedTextKit(
                    repeatForever: false,
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                          "I'm ${calculateAge(DateTime(2001, 7, 19))}-year-old self-taught mobile app developer based in Ethiopia. My journey into mobile app development is driven by passion, curiosity, and a relentless desire to create impactful solutions.\n\nI specialize in crafting mobile applications using Flutter and Android Native, focusing on efficiency and delivering results quickly without compromising on quality. With a commitment to staying up-to-date with the latest technologies, I bring innovative ideas to every project I work on.\n\nWhether you're looking for a robust app built from the ground up or need enhancements to an existing one, I’m here to help turn your vision into reality. Let’s build something amazing together!",
                          speed: const Duration(microseconds: 1000),
                          cursor: "_"),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 60),
              SvgPicture.asset(Assets.svgs.p2),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
                padding: const EdgeInsets.only(right: 300),
                child: SvgPicture.asset(Assets.svgs.p2)),
          ),
          const SizedBox(height: 10),
          Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(Assets.svgs.p2))
        ],
      ),
    );
  }

  _buildContacts() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "#",
                style: TextStyle(
                  fontSize: 32,
                  color: ColorName.primaryColor,
                ),
              ),
              const Text(
                "contacts",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 20.sh,
                height: 1,
                color: ColorName.primaryColor,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 30.sh,
                child: const Text(
                  "I’m interested in freelance opportunities. However, if you have other request or question, don’t hesitate to contact me",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFABB2BF),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 400),
                width: 300,
                height: 141,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: ColorName.greyColor,
                )),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Message me here",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: ColorName.greyColor,
                        ),
                        SizedBox(width: 10),
                        SelectableText(
                          "mellossdev@gmail.com",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorName.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
