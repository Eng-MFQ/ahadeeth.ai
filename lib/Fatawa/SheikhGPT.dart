import 'package:ahafeeth_ai_app/Fatawa/models/ChatModle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ahafeeth_ai_app/Fatawa/fatwaWidgets/FatwaCard.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller =
      TextEditingController(text: "السلام عليكم");
  List<Map<String, String>> _messages = [];
  List<SheikhModel> _sheikhMessages = [
    SheikhModel.fromMessage(
        "السلام عليكم ورحمة الله وبركاته. أنا  شيخ جي بي تي  هنا لأساعدك في الإجابة على فتاوى. إذا كانت لديك أي أسئلة، فلا تتردد في طرحها وسأكون سعيدًا بمساعدتك. كيف يمكنني أن أخدمك اليوم؟",
        isUser: false)
  ];
  bool isLoading = false;

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    final newMessage = {
      'role': 'user',
      'content': _controller.text,
    };

    setState(() {
      _messages.add(newMessage);
      _sheikhMessages.add(SheikhModel.fromMessage(_controller.text));
      isLoading = true;
    });

    // try {
    final response = await http.post(
      // Uri.parse('https://whilelearn.onrender.com/searchHadithBrain'),
      Uri.parse('http://10.0.2.2:8000/searchHadithBrain'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode([..._messages, newMessage]),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      SheikhModel model = SheikhModel.fromJson(responseData);
      _sheikhMessages.add(model);
      if (_sheikhMessages.last.isSendToSheikh) showCustomDialog(context);
      setState(() {
        _messages
            .add({'role': 'assistant', 'content': model.gptAnswer.content});
        isLoading = false;
      });
    } else {
      _showSnackBar('Failed to send message');
    }
    // } catch (e) {
    //   _showSnackBar('Error: $e');
    // }

    _controller.clear();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شيخGPT'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _messages.clear();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _sheikhMessages.length,
              itemBuilder: (context, index) {
                final message = _sheikhMessages[index];
                final isUserMessage = message.gptAnswer.role == 'user';
                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                      right: !isUserMessage ? 24 : 0,
                      left: isUserMessage ? 24 : 0,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          !isUserMessage ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: isUserMessage
                            ? Radius.circular(12)
                            : Radius.circular(0),
                        bottomRight: isUserMessage
                            ? Radius.circular(0)
                            : Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(message.gptAnswer.content,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  isUserMessage ? Colors.black : Colors.black87,
                            ),
                            textAlign: TextAlign.right),
                        if (message.fatwaList.isNotEmpty)
                          ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: message.fatwaList
                                .map((e) => FatwaCard(
                                      fatwa: e,
                                    ) as Widget)
                                .toList(),
                          ),
                        if (message.fatwaList.isNotEmpty)
                          Text(message.gptAnswer.content,
                              style: TextStyle(
                                fontSize: 20,
                                color: isUserMessage
                                    ? Colors.black
                                    : Colors.black87,
                              ),
                              textAlign: TextAlign.right),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'أكتب هنا',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('أرسل الفتوى للشيخ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'البريد الإلكتروني',
                  labelText: 'البريد الإلكتروني',
                ),
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: 'رقم الهاتف',
                  labelText: 'رقم الهاتف',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إغلاق'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your send logic here
                Navigator.of(context).pop();
              },
              child: Text('أرسل الفتوى للشيخ'),
            ),
          ],
        );
      },
    );
  }
}
