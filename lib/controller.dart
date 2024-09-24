import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:file_picker/file_picker.dart';

class Controller extends GetxController {
  final to = TextEditingController();
  final subject = TextEditingController();
  final text = TextEditingController();
  final html = TextEditingController();
  var file = Rx<File?>(null);

  @override
  void onInit() async {
    super.onInit();
    await dotenv.load(fileName: ".env");
  }

  //fungsi untuk kirim email
  Future<void> sentEmail() async {
    try {
      String username = dotenv.env['SMTP_USERNAME']!;
      String password = dotenv.env['SMTP_PASSWORD']!;

      final smtpServer = gmail(username, password);

      final message = Message()
        ..from = Address(username, 'Bima Aprie Yudha')
        ..recipients.add(to.text)
        ..subject = subject.text
        ..text = text.text
        ..html = html.text
        ..attachments = [
          FileAttachment(file.value!)..location = Location.inline
        ];

      // Mengirim email
      await send(message, smtpServer, timeout: const Duration(seconds: 15));
      print('Message sent successfully.');
    } on MailerException catch (e) {
      print('There was an error when sending the email.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void getAttach() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      file.value = File(result.files.single.path!);
      print(file.value);
    }
  }
}
