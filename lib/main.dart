import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          // Change color to transparent
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'As you can see, image with 30 height has really poor quality, how can I fix that?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  showPopup(context);
                },
                child: const Text('show popup'))
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
