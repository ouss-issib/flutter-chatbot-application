import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChabotPage extends StatefulWidget {
  ChabotPage({super.key});

  @override
  State<ChabotPage> createState() => _ChabotPageState();
}

class _ChabotPageState extends State<ChabotPage> {
  var messages = [];
  String baseUrl = 'http://192.168.60.132'; // Default value
  TextEditingController userController = TextEditingController();
  ScrollController scrollController = ScrollController();

  final Color primaryColor = Color(0xFF1565C0); // Blue shade
  final Color backgroundColor = Colors.white;
  final Color userMessageColor = Color(0xFFD0E8FF); // Light blue for user messages
  final Color botMessageColor = Color(0xFFF5F5F5); // Light gray for bot messages
  final Color hintTextColor = Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "E-Chatbot",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/");
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser = messages[index]['role'] == 'user';
                return Column(
                  children: [
                    Row(
                      children: [
                        isUser ? SizedBox(width: 80) : SizedBox(width: 0),
                        Expanded(
                          child: Card(
                            margin: EdgeInsets.all(6),
                            color: isUser ? userMessageColor : botMessageColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                "${messages[index]['content']}",
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                          ),
                        ),
                        !isUser ? SizedBox(width: 80) : SizedBox(width: 0),
                      ],
                    ),
                    Divider()
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: userController,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: "Ask anything",
                      hintStyle: TextStyle(color: hintTextColor),
                      suffixIcon: Icon(Icons.person, color: primaryColor),
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: primaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: primaryColor,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    String question = userController.text;
                    Uri uri = Uri.parse('$baseUrl:11434/v1/chat/completions'); // Fixed port

                    var headers = {
                      "Content-Type": "application/json",
                    };

                    // Optimistic UI: Show user message immediately
                    setState(() {
                      messages.add({"role": "user", "content": question});
                    });

                    var body = {
                      "model": "llama3.2",
                      "messages": messages,
                    };

                    // Add a typing indicator or show loading spinner (UI improvement)
                    setState(() {
                      messages.add({
                        "role": "assistant",
                        "content": "Thinking..."
                      });
                    });

                    try {
                      final response = await http
                          .post(uri, headers: headers, body: json.encode(body));

                      // Handle response here
                      if (response.statusCode == 200) {
                        var aiResponse = json.decode(response.body);
                        String answer =
                        aiResponse['choices'][0]['message']['content'];

                        setState(() {
                          // Remove "Thinking..." and add actual response
                          messages.removeWhere((msg) => msg['content'] == 'Thinking...');
                          messages.add({"role": "assistant", "content": answer});
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent + 800);
                        });
                      } else {
                        throw Exception("Failed to load data");
                      }
                    } catch (e) {
                      // Error handling in case of issues
                      print("Error: $e");
                      setState(() {
                        messages.add({
                          "role": "assistant",
                          "content": "An error occurred. Please try again later."
                        });
                      });
                    } finally {
                      userController.clear(); // Clear input after processing
                    }
                  },
                  icon: Icon(Icons.send, color: primaryColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
