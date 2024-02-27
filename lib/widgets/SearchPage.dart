import 'package:ahafeeth_ai_app/constants/Localization.dart';
import 'package:ahafeeth_ai_app/constants/Utils.dart';
import 'package:ahafeeth_ai_app/constants/constants.dart';
import 'package:ahafeeth_ai_app/provider/AnalyticsProvider.dart';
import 'package:ahafeeth_ai_app/widgets/category_boxes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localization/app_localizations.dart';
import '../provider/ApiProvider.dart';
import '../provider/UserProvider.dart';
import 'discover_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';
  int selectedItemsCount = 5;
  bool isRelevance = false;
  bool isExpanded = true;
  late LocaleProvider localeProvider;
  bool isLoading = false;

  // Mock data, replace with actual API call
  List<Hadeeth> hadeethList = [];

  void performSearch() async {
    // Replace this with your actual API call logic
    // For now, just populate the list with mock data
    hadeethList = [];
    setState(() {
      isLoading = true;
      isExpanded = false;
    });

    hadeethList = await AhadeethProvider().searchAhadeeth(
        query: searchText,
        isRelevance: isRelevance,
        number: selectedItemsCount);
    hadeethList.insert(0, hadeethList.first);

    if (hadeethList.isEmpty) {
      await AhadeethProvider().searchAhadeeth(
        query: searchText,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        ),
        content: Text(AppLocalizations.of(context).errorSearch),
        duration: Duration(minutes: 1),
      ));
      AnalyticProvider.track("ErrorWithSearch", properties: {
        "query": searchText,
        "isRelevance": isRelevance,
        "number": selectedItemsCount,
      });
    }

    setState(() {
      isLoading = false;
    });
    AnalyticProvider.track("performSearch", properties: {
      "query": searchText,
      "isRelevance": isRelevance,
    });
  }

  @override
  Widget build(BuildContext context) {
    localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xff121421),
      body: isLoading
          ? Center(
              child: Utils.loadingView(context, isSearch: true),
            )
          : Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: hadeethList.isEmpty
                          ? Utils.loadingView(context,
                              isSearch: true,
                              showLoading: false,
                              text: AppLocalizations.of(context).search_ai)
                          : buildListView(),
                    ),
                  ],
                ),
                buildSearchBar(context),
              ],
            ),
    );
  }

  Padding buildSearchBar(BuildContext context) {
    List<Map<String, String>> topicsList = Constants().topicsList;
    topicsList.sort((a, b) => b[localeProvider.isArabic ? "arabic" : "english"]!
        .length
        .compareTo(a[localeProvider.isArabic ? "arabic" : "english"]!.length));
    topicsList = topicsList.reversed.toList();
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.all(16.0),
        child: AnimatedContainer(
          height: isExpanded ? 600 : 71,
          duration: Duration(milliseconds: 300),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  AppLocalizations.of(context).search_settings,
                ),
                subtitle: Text("( $searchText )"),
                trailing: CircleAvatar(
                  child: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    size: 30.0,
                  ),
                ),
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
              Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  searchText = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .searchInAhadeeth,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                                '${AppLocalizations.of(context).searchNumber}: $selectedItemsCount'),
                            Slider(
                              value: selectedItemsCount.toDouble(),
                              min: 5,
                              max: 100,
                              onChanged: (value) {
                                setState(() {
                                  selectedItemsCount = value.toInt();
                                });
                              },
                            ),
                            SizedBox(height: 16.0),
                            Text(
                                '${AppLocalizations.of(context).searchOption}:'),
                            Wrap(
                              spacing: 8.0,
                              children: [
                                ChoiceChip(
                                  label: Text(AppLocalizations.of(context)
                                      .searchOptionSimilar),
                                  selected: !isRelevance,
                                  onSelected: (selected) {
                                    setState(() {
                                      isRelevance = false;
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  label: Text(AppLocalizations.of(context)
                                      .searchOptionRelevance),
                                  selected: isRelevance,
                                  onSelected: (selected) {
                                    setState(() {
                                      isRelevance = true;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff121421),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 100)),
                                onPressed: searchText.isNotEmpty
                                    ? performSearch
                                    : null,
                                child: Text(
                                  AppLocalizations.of(context).searchSearch,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                leading: Icon(Icons.topic),
                                subtitle: Text(
                                  AppLocalizations.of(context)
                                      .searchSuggestedTopicsSubtext,
                                ),
                                title: Text(
                                  AppLocalizations.of(context)
                                      .searchSuggestedTopics,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: topicsList.map((topic) {
                                return CategoryBoxes(
                                    onPressed: () {
                                      searchText = topic[localeProvider.isArabic
                                          ? "arabic"
                                          : "english"]!;
                                      AnalyticProvider.track("Suggested topic",
                                          properties: {
                                            "topic": searchText,
                                          });
                                      performSearch();
                                    },
                                    text: topic[localeProvider.isArabic
                                        ? "arabic"
                                        : "english"]!);
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: hadeethList.length,
        itemBuilder: (context, index) {
          if (index == 0)
            return SizedBox(
              height: 80,
            );
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: HadeethCard(
              hadeethList[index],
              title: localeProvider.isArabic
                  ? hadeethList[index].titleArGpt4
                  : hadeethList[index].titleEn,
              subtitle: localeProvider.isArabic
                  ? hadeethList[index].matinAr
                  : hadeethList[index].matinEn,
            ),
          );
        },
      ),
    );
  }
}
