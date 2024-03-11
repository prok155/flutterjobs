import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterjobs/in_app_purchase.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewInsets.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: statusBarHeight,

        /// Set backgroundColor when status bar is colored
        /// & comment forceMaterialTransparency
        backgroundColor: Colors.red,

        /// comment backgroundColor when status bar is transparent
        /// & set forceMaterialTransparency to true
        forceMaterialTransparency: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 400,
            ),
            Image.asset(
              'assets/image.png',
              height: 30,
            ),
            Image.asset(
              'assets/image.png',
              height: 150,
            ),
            SvgPicture.asset(
              'assets/svg_test.svg',
              height: 100,
            ),
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/image.png',
              height: 30,
            ),
            Image.asset(
              'assets/image.png',
              height: 150,
            ),
            SvgPicture.asset(
              'assets/svg_test.svg',
              height: 100,
            ),
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/image.png',
              height: 30,
            ),
            Image.asset(
              'assets/image.png',
              height: 150,
            ),
            SvgPicture.asset(
              'assets/svg_test.svg',
              height: 100,
            ),
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/image.png',
              height: 30,
            ),
            Image.asset(
              'assets/image.png',
              height: 150,
            ),
            SvgPicture.asset(
              'assets/svg_test.svg',
              height: 100,
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'As you can see, image with 30 height has really poor quality, how can I fix that?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                showPopup(context);
              },
              child: const Text('show popup'),
            ),
            const SizedBox(height: 50),
            const InAppPurchaseWidget(),
          ],
        ),
      ),
    );
  }

  void showPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 470,
          child: const Center(
            child: Text(
                textAlign: TextAlign.center,
                'Look at status bar, is completely white, it should be darken. '),
          ),
        );
      },
    );
  }
}
