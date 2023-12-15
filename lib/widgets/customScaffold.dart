import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      required this.child,
      this.backArrowColor,
      required this.showBackArrow});
  final Widget? child;
  final Color? backArrowColor;
  final bool showBackArrow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: showBackArrow,
        leading: showBackArrow
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: backArrowColor ?? Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'images/welcome.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: child!,
          ),
        ],
      ),
    );
  }
}
