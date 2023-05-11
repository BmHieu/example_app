import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';

import '../../../../config/config.dart';
import '../../../../core/screen_router.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../helper/dimension.dart';
import '../../../../shared/widgets/button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String url = "";
  List<MediaFile> selectedMedias = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.theme.colors.primary.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          LocaleKeys.common_welcome,
          style: App.theme.textStyle.nhnSebo32.copyWith(
            fontSize: 14.h(),
          ),
        ).tr(),
        actions: [
          IconButton(
            splashRadius: 24,
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(
                context,
                ScreenRouter.example,
                arguments: {ScreenArgument.id: 99},
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter url here..."),
                onChanged: (text) {
                  url = text;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              title: LocaleKeys.common_done.tr(),
              onPressed: () {
                Navigator.pushNamed(context, ScreenRouter.webview, arguments: {ScreenArgument.url: url});
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickMedia() async {
    List<MediaFile>? media = await GalleryPicker.pickMedia(
      context: context,
      initSelectedMedia: selectedMedias,
      extraRecentMedia: selectedMedias,
      startWithRecent: true,
    );
    if (media != null) {
      setState(() {
        selectedMedias += media;
      });
    }
  }
}
