import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:melloss_portifolio/data/models/browser_tab_model.dart';
import 'package:melloss_portifolio/gen/assets.gen.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';
import 'package:melloss_portifolio/presentation/widgets/browser/webview_wrapper.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WebViewDisplayer extends StatefulWidget {
  final BrowserTabModel browserTabModel;
  final bool isExpanded;
  const WebViewDisplayer(
      {super.key, required this.browserTabModel, this.isExpanded = false});

  @override
  State<WebViewDisplayer> createState() => _WebViewDisplayerState();
}

class _WebViewDisplayerState extends State<WebViewDisplayer> {
  TextEditingController searchController = TextEditingController();
  TextEditingController googleSearchController = TextEditingController();

  bool showWebView = false;
  String mainUrl = '';

  final webGlobalKey = GlobalKey<WebviewWrapperState>();

  _navigateTo(String url) {
    if (url.startsWith('https://www') ||
        url.startsWith('https://') ||
        url.startsWith('http://www') ||
        url.startsWith('http://')) {
      setState(() {
        mainUrl = url;
        showWebView = true;
      });
      searchController.text = url;
    } else {
      setState(() {
        mainUrl = 'https://www.google.com/search?q=$url';
        showWebView = true;
      });
      searchController.text = mainUrl;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    googleSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2A33),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTop(),
          showWebView ? _buildWebView() : _buildDefaultPage(),
        ],
      ),
    );
  }

  _buildTop() {
    return Container(
      height: 50,
      color: const Color(0xFF4C4C4C),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(width: 10),
              IconButton(
                style: IconButton.styleFrom(
                    hoverColor: const Color(0xFF696969),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  webGlobalKey
                      .currentState?.iframeElement.contentWindow?.history
                      .back();

                  setState(() {});
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(
                    hoverColor: const Color(0xFF696969),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  webGlobalKey
                      .currentState?.iframeElement.contentWindow?.history
                      .forward();
                  setState(() {});
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                style: IconButton.styleFrom(
                    hoverColor: const Color(0xFF696969),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  if (mainUrl.isNotEmpty) {
                    _navigateTo(mainUrl);
                  }
                },
                icon: const Icon(
                  Icons.refresh,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 100),
              Container(
                width: widget.isExpanded ? 70.sh : 50.sh,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  cursorColor: ColorName.primaryColor,
                  autofocus: true,
                  onEditingComplete: () {
                    _navigateTo(searchController.text);
                  },
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                  decoration: InputDecoration(
                    fillColor: const Color(0xFF353535),
                    filled: true,
                    hintText: 'Search with Google or enter address',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white38,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(right: 15, left: 10),
                      child: Icon(
                        Icons.search,
                        color: Colors.white70,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: ColorName.primaryColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: ColorName.primaryColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  controller: searchController,
                ),
              ),
              const Spacer(),
              IconButton(
                style: IconButton.styleFrom(
                    hoverColor: const Color(0xFF696969),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  //
                },
                icon: const Icon(
                  Icons.file_download_outlined,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(
                    hoverColor: const Color(0xFF696969),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  //
                },
                icon: const Icon(
                  Icons.extension_outlined,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(
                    hoverColor: const Color(0xFF696969),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  //
                },
                icon: const Icon(
                  Icons.menu,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
            ],
          )
        ],
      ),
    );
  }

  _buildWebView() {
    // Web-specific implementation
    return Expanded(
      child: WebviewWrapper(
        globalKey: webGlobalKey,
        url: mainUrl,
      ),
    );
  }

  _buildDefaultPage() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.firefoxLogo.image(
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 20),
              Text(
                'Firefox',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: widget.isExpanded ? 40.sh : 30.sh,
            child: TextField(
              cursorColor: ColorName.primaryColor,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white70,
              ),
              decoration: InputDecoration(
                fillColor: const Color(0xFF42414D),
                filled: true,
                hintText: 'Search with Google or enter address',
                hintStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white38,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(right: 15, left: 10),
                  child: Icon(
                    Bootstrap.google,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.primaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.primaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
              controller: googleSearchController,
            ),
          ),
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                iconPath: Assets.images.wikipediaLogo.path,
                title: 'Wikipedia',
                url: 'https://www.wikipedia.org/',
              ),
              _buildButton(
                iconPath: Assets.images.youtubeLogo.path,
                title: 'Youtube',
                url: 'https://www.youtube.com',
              ),
              _buildButton(
                iconPath: Assets.images.dartLogo.path,
                title: 'Pub',
                url: 'https://pub.dev/',
              ),
              _buildButton(
                iconPath: Assets.images.linkedInLogo.path,
                title: 'LinkedIn',
                url: 'https://www.linkedin.com/in/melloss/',
              ),
              _buildButton(
                iconPath: Assets.images.githubLogo.path,
                title: 'Github',
                url: 'https://github.com/melloss',
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildButton(
      {required String iconPath, required String title, required String url}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 75,
            height: 75,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF42414D),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              icon: Image.asset(
                iconPath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                color: Assets.images.githubLogo.path == iconPath
                    ? Colors.white
                    : null,
              ),
              onPressed: () {
                _navigateTo(url);
              },
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
