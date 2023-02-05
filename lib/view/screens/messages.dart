import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/helper/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MessagesScreen extends StatelessWidget {
  final List messages;
  final regex = RegExp(r'(https?://\S+)');
   MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.01, horizontal: Get.width * 0.03),
            child: Row(
              mainAxisAlignment: messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                messages[index]['isUserMessage']
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.mainColor,
                          child: Image.asset('assets/images/bot.png'),
                        ),
                      ),
                InkWell(
                  onTap: () {
                    final regex = RegExp(r'(https?://\S+)');
                    final match = regex.firstMatch(
                        "${messages[index]["message"].text!.text[0]}");
                    if (match != null) {
                      print("${match.group(1)}");
                      final uri = Uri.parse("${match.group(1)}");
                      if (uri.isAbsolute) {
                        launch(match.group(1)!);
                      }
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: messages[index]['isUserMessage']
                            ? AppColors.mainColor
                            : AppColors.grey.withOpacity(0.2)),
                    constraints: BoxConstraints(maxWidth: Get.width * 2 / 3),
                    child: Text(
                      "${messages[index]['message'].text!.text[0].replaceAll(regex, "")}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: messages[index]['isUserMessage']
                            ? Colors.white
                            : Colors.black38,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: messages.length);
  }
}
