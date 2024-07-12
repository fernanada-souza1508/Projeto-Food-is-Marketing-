import "package:flutter/material.dart";
import "../components/my_button.dart";

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // logo
          Image.asset('logo.png', height: 200, width: 300,),
          
          const SizedBox(height: 25),
          //titulo
          const Text(" Food is Marketing ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),

          const SizedBox(height: 25),


          const SizedBox(height: 25),
          //button
          MyButton(
              onTap: () => Navigator.pushNamed(context, '/shop_page'),

              child: const Icon(Icons.arrow_forward)),
        ])));
  }
}
