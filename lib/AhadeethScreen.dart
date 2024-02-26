import 'dart:math';

import 'package:ahafeeth_ai_app/constants/Utils.dart';
import 'package:ahafeeth_ai_app/provider/AnalyticsProvider.dart';
import 'package:ahafeeth_ai_app/provider/ApiProvider.dart';
import 'package:ahafeeth_ai_app/provider/SharedPrefProvider.dart';
import 'package:ahafeeth_ai_app/provider/UserProvider.dart';
import 'package:ahafeeth_ai_app/widgets/discover_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/styles.dart';
import 'localization/app_localizations.dart';

class AhadeethScreen extends StatefulWidget {
  Map<String, dynamic> chapter;

  AhadeethScreen(this.chapter, {Key? key}) : super(key: key);

  static PageRouteBuilder getRoute(Map<String, dynamic> chapter) {
    return PageRouteBuilder(
        opaque: false,
        transitionsBuilder: (_, animation, secondAnimation, child) {
          return FadeTransition(
            opacity: animation,
          );
        },
        pageBuilder: (_, __, ___) {
          return AhadeethScreen(chapter);
        });
  }

  @override
  State<AhadeethScreen> createState() => _AhadeethScreenState();
}

class _AhadeethScreenState extends State<AhadeethScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Hadeeth> hadeethList = [];
  late LocaleProvider localeProvider;
  late SharedPrefProvider sharedPrefProvider;
  bool isLoadingMore = false;
  bool chapterFinished = false;

  @override
  Widget build(BuildContext context) {
    localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    sharedPrefProvider =
        Provider.of<SharedPrefProvider>(context, listen: false);

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (isLoadingMore) return;
        setState(() {
          isLoadingMore = true;
        });
        List<Hadeeth> newHadeeth = await AhadeethProvider().fetchAhadeeth(
            chapterId: widget.chapter["id"],
            lastIdInBook: hadeethList
                .last.idInBook); // Trigger load more when scrolled to the end
        if (newHadeeth.isNotEmpty)
          setState(() {
            hadeethList.addAll(newHadeeth);
            AnalyticProvider.track("LoadMoreAhadeeth",
                properties: {"chapter": widget.chapter["arabic"]});
          });
        else
          setState(() {
            chapterFinished = true;
          });
        setState(() {
          isLoadingMore = false;
        });
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xff121421),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff121421),
          title: AutoSizeText(
            localeProvider.isArabic
                ? widget.chapter["arabic"]
                : widget.chapter["english"],
            maxLines: 1,
            style: TextStyle(
                color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
          )),
      body: hadeethList.isEmpty
          ? FutureBuilder<List<Hadeeth>>(
              future: AhadeethProvider()
                  .fetchAhadeeth(chapterId: widget.chapter["id"]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Utils.loadingView(context));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  hadeethList = snapshot.data!;
                  return buildListView();
                }
              },
            )
          : buildListView(),
    );
  }

  ListView buildListView() {
    print("sharedPrefProvider.hadeethList.length");
    print(sharedPrefProvider.hadeethList.length);
    var color =
        Style.myGradientColors[Random().nextInt(Style.myGradientColors.length)];
    return ListView.builder(
      controller: _scrollController,
      itemCount: chapterFinished
          ? hadeethList.length + 1
          : isLoadingMore
              ? hadeethList.length + 1
              : hadeethList.length,
      itemBuilder: (context, index) {
        if (index == hadeethList.length)
          return Card(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (!chapterFinished)
                Center(
                    child: SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator())),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(chapterFinished
                    ? AppLocalizations.of(context).noMore
                    : AppLocalizations.of(context).loadingMore),
              ),
            ],
          ));
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: HadeethCard(
            hadeethList[index],
            gradientStartColor: color["gradientStartColor"],
            gradientEndColor: color["gradientEndColor"],
            title: localeProvider.isArabic
                ? hadeethList[index].titleArGpt4
                : hadeethList[index].titleEn,
            subtitle: localeProvider.isArabic
                ? hadeethList[index].matinAr
                : hadeethList[index].matinEn,
          ),
        );
      },
    );
  }
}
