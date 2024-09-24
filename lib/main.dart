import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/bottomsheet/bottomsheet.dart';
import 'package:get/route_manager.dart';
import 'package:smtp_flutter/controller.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Flutter SMTP',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                _formtext(
                  labelText: "To: ",
                  hintText: "youremail@example.com",
                  controller: controller.to,
                ),
                const SizedBox(height: 10),
                _formtext(
                  labelText: "Subject: ",
                  controller: controller.subject,
                ),
                const SizedBox(height: 10),
                _formtext(
                  labelText: "Text: ",
                  controller: controller.text,
                ),
                const SizedBox(height: 10),
                _formtext(
                  labelText: "Html: ",
                  controller: controller.html,
                ),
                const SizedBox(height: 10),
                Obx(
                  () => _formImage(
                    onTap: controller.getAttach,
                    hintText:
                        "Attach File: ${controller.file.value?.path ?? ''}",
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.sentEmail,
                  child: const Text("Send Email"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _formtext extends StatelessWidget {
  const _formtext({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
  });
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
    );
  }
}

class _formImage extends StatelessWidget {
  const _formImage({
    super.key,
    this.onTap,
    this.hintText,
  });
  final String? hintText;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "File: ",
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
    );
  }
}
