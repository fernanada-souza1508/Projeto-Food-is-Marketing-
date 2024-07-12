import "package:flutter/material.dart";

class MyListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const MyListTile(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
          leading: Icon(
            icon,
            color: Color.fromARGB(255, 243, 241, 161),
          ),
          title: Text(text),
          onTap: onTap),
    );
  }
}
