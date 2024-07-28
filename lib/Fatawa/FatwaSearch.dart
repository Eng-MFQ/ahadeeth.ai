import 'package:ahafeeth_ai_app/Fatawa/SheikhGPT.dart';
import 'package:ahafeeth_ai_app/Fatawa/fatwaWidgets/FatwaCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../icons.dart';
import '../localization/app_localizations.dart';
import '../provider/AnalyticsProvider.dart';
import '../widgets/svg_asset.dart';
import 'models/Fatwa.dart';

// Define the data model
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Fatwa> _fatwas = [];
  bool _isLoading = false;
  bool _showClear = false;

  // Fetch data from the API
  Future<void> _fetchData(String query) async {
    if (query.trim().isEmpty) {
      // Notify the user to enter a query
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء كتابة شيء في خانة البحث')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://whilelearn.onrender.com/searchFatwa?query=${Uri.encodeComponent(query)}'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        _fatwas = data.map((json) => Fatwa.fromJson(json)).toList();
        _isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        _isLoading = false;
      });
      print('Failed to load data');
    }
  }

  void _clearInput() {
    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: SvgAsset(
            assetName: AssetName.discover,
            height: 24,
            width: 24,
            color: Color(0xff121421),
          ),
          onPressed: () {
            Get.to(() => ChatScreen(), transition: Transition.rightToLeft);
            AnalyticProvider.track("SheikhGPTPressed");
          },
          label: Text("إسأل شيخGPT")),
      appBar: AppBar(title: Text('البحث بالفتاوى')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              onChanged: (x){
                setState(() {
                  _showClear = x.isNotEmpty;
                });
              },
              maxLength: 200,
              decoration: InputDecoration(
                hintText: 'أكتب مثلا: كيف أخشع بالصلاة',
                border: OutlineInputBorder(),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (_showClear)
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: _clearInput,
                      ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _fetchData(_controller.text);
                      },
                    ),
                  ],
                ),
              ),
              onSubmitted: (value) {
                _fetchData(value);
              },
            ),
            SizedBox(height: 16.0),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
              child: ListView.builder(
                itemCount: _fatwas.length,
                itemBuilder: (context, index) {
                  final fatwa = _fatwas[index];
                  return FatwaCard(fatwa: fatwa);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
