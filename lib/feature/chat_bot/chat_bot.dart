import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:io';

import 'package:yamtaz/core/constants/colors.dart';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat';
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _chatHistory = [];
  String? _file;

  late final GenerativeModel _model;
  late final GenerativeModel _visionModel;
  late final ChatSession _chat;
  bool _isLoading = false;

  @override
  void initState() {
    _model = GenerativeModel(
        model: 'gemini-pro', apiKey: 'AIzaSyCsMbJd9qQw8mNT_J3V4icff560vmkepco');
    _visionModel = GenerativeModel(
        model: 'gemini-pro-vision', apiKey: 'AIzaSyCsMbJd9qQw8mNT_J3V4icff560vmkepco');
    _chat = _model.startChat();
    super.initState();
  }
  Future<void> _sendMessage() async {
    _isLoading = true;
    setState(() {
      if (_chatController.text.isNotEmpty) {
        if (_file != null){
          _chatHistory.add({
            "time": DateTime.now(),
            "message": _file,
            "isSender": true,
            "isImage": true
          });
        }

        _chatHistory.add({
          "time": DateTime.now(),
          "message": _chatController.text,
          "isSender": true,
          "isImage": false
        });
      }
    });

    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );

    getAnswer(_chatController.text);
    _chatController.clear();
  }
  Future<void> getAnswer(String text) async {
    late final GenerateContentResponse response;
    if(_file != null){
      // final firstImage = await (File(_file!).readAsBytes());
      final prompt = TextPart(text);
      // final imageParts = [
      //   DataPart('image/jpeg', firstImage ),
      // ];
      response = await _visionModel.generateContent([
        Content.multi([prompt,])
      ]);
      _file = null;
    }else{
      var content = Content.text(text.toString());
      response = await _chat.sendMessage(content);
    }
    setState(() {
      _chatHistory.add({
        "time": DateTime.now(),
        "message": response.text,
        "isSender": false,
        "isImage": false
      });
      _file = null;
      _isLoading = false;
    });


    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 60,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );


  }



  // Future<void> _sendMessage() async {
  //   if (_chatController.text.isEmpty) return;
  //
  //   setState(() {
  //     _chatHistory.add({"isSender": true, "message": _chatController.text, "isImage": false});
  //   });
  //
  //   _scrollController.animateTo(
  //     _scrollController.position.maxScrollExtent + 60,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeOut,
  //   );
  //
  //   final message = _chatController.text;
  //   _chatController.clear();
  //
  //   try {
  //     final response = await _dio.post(
  //       '/chat:generateMessage',
  //       data: jsonEncode({
  //         'prompt': {
  //           'messages': [
  //             {'content': message},
  //           ],
  //         },
  //       }),
  //     );
  //
  //     final data = response.data;
  //     final aiMessage = data['messages'][0]['content'];
  //
  //     setState(() {
  //       _chatHistory.add({"isSender": false, "message": aiMessage, "isImage": false});
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _chatHistory.add({
  //         "isSender": false,
  //         "message": "Sorry, something went wrong. Please try again later.",
  //         "isImage": false,
  //       });
  //     });
  //   }
  //
  //   _scrollController.animateTo(
  //     _scrollController.position.maxScrollExtent + 60,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeOut,
  //   );
  // }
  Future<void> _pickImage() async {
    // You can implement the image picker functionality here
    // For now, just add a placeholder image message
    setState(() {
      _chatHistory.add({"isSender": true, "message": "path/to/image.png", "isImage": true});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "تهامي الذكي",
          style: TextStyle(fontWeight: FontWeight.bold , fontSize: 12.sp),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 160,
            child: ListView.builder(
              itemCount: _chatHistory.length,
              shrinkWrap: false,
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (_chatHistory[index]["isSender"]
                        ? Alignment.topRight
                        : Alignment.topLeft),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: (_chatHistory[index]["isSender"]
                            ? appColors.primaryColorYellow
                            : Colors.white),
                      ),
                      padding: EdgeInsets.all(16),
                      child: _chatHistory[index]["isImage"]
                          ? Image.file(
                        File(_chatHistory[index]["message"]),
                        width: 200,
                      )
                          : Text(
                        _chatHistory[index]["message"],
                        style: TextStyle(
                            fontSize: 15,
                            color: _chatHistory[index]["isSender"]
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  // MaterialButton(
                  //   onPressed: () {
                  //     _pickImage();
                  //   },
                  //   minWidth: 42.0,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(80.0)),
                  //   padding: const EdgeInsets.all(0.0),
                  //   child: Ink(
                  //     decoration: const BoxDecoration(
                  //       gradient: LinearGradient(
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //         colors: [
                  //           Color(0xFFF69170),
                  //           Color(0xFF7D96E6),
                  //         ],
                  //       ),
                  //       borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  //     ),
                  //     child: Container(
                  //       constraints: const BoxConstraints(minWidth: 42.0, minHeight: 36.0),
                  //       alignment: Alignment.center,
                  //       child: Icon(
                  //         _file == null ? Icons.image : Icons.check,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: Container(

                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CupertinoTextField(
                          placeholder: 'اكتب رسالتك',
                          controller: _chatController,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  _isLoading ? const CupertinoActivityIndicator() :
                  GestureDetector(
                    onTap: () {
                      _sendMessage();
                    },
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: appColors.primaryColorYellow,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: appColors.blue100,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
