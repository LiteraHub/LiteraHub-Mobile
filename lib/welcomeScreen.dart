import 'package:flutter/material.dart';
import 'package:literahub/screens/register.dart';
import 'package:literahub/deletesoon/signup.dart';
import 'package:literahub/widgets/customScaffold.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return CustomScaffold(
      showBackArrow: false,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: [
              Flexible(
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: screenHeight * 0.3),
                  padding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 0.1 *
                        screenWidth, // Adjust the horizontal padding based on screen width
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Selamat Datang!',
                        style: TextStyle(
                          fontSize: 0.04 *
                              screenHeight, // Adjust the font size based on screen height
                          fontFamily: 'Prompt',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '\nKini, cakrawala ada di genggamanmu',
                        style: TextStyle(
                          fontSize: 0.019 *
                              screenHeight, // Adjust the font size based on screen height
                          color: Colors.black,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: screenWidth * 0.45, bottom: 4),
            child: Text(
              "LiteraHub",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),

          Positioned(
            bottom: 0.05 * screenHeight,
            right: 0.05 * screenWidth,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(0.02 * screenHeight),
                decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(0.05 *
                      screenHeight)),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  size: 0.035 *
                      screenHeight,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
