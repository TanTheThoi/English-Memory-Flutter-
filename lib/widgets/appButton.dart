import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const AppButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, offset: Offset(3, 6), blurRadius: 12)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 30,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
