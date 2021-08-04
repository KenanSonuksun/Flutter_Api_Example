import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:spacex/src/Service/Providers/apiProvider.dart';
import 'package:spacex/src/View/Components/customText.dart';
import '../HomeScreen/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //a variable for opacity animation (for Image)
  bool opacityForImage = false;
  //a variable for opacity animation (for Button)
  bool opacity = false;

  @override
  void initState() {
    //to get data with provider
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getDataFromApi();
    //animation settings
    Timer.periodic(Duration(milliseconds: 80), (timer) {
      //Image disappears and appears with this condition
      if (!opacityForImage) {
        //set true to opacity and opacityForImage , image and button appear
        Future.delayed(Duration(milliseconds: 1300), () {
          // Before calling setState check if the state is mounted.
          if (mounted) {
            setState(() {
              opacityForImage = true;
              opacity = true;
            });
          }
        });
      } else {
        //set true to opacity and opacityForImage and image disappears
        Future.delayed(Duration(milliseconds: 2000), () {
          // Before calling setState check if the state is mounted.
          if (mounted) {
            setState(() {
              opacityForImage = false;
            });
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //screen's size
    Size size = MediaQuery.of(context).size;
    //to use datas with provider
    final apiProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //Image
              AnimatedOpacity(
                duration: Duration(milliseconds: 1500),
                opacity: opacityForImage ? 1 : 0,
                child: Image.asset('assets/images/spacex.jpg',
                    height: size.height * 0.83, width: size.width * 0.83),
              ),
              //Button
              AnimatedOpacity(
                  duration: Duration(milliseconds: 3500),
                  opacity: opacity ? 1 : 0,
                  child: apiProvider.loading
                      ? //Loading
                      const Center(
                          child: const SpinKitWave(
                              color: Colors.blue, type: SpinKitWaveType.start))
                      : apiProvider.error
                          ? //Error Message
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //a text about error message
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Data could not be found. Please check your internet connection and try again",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                //a button to try again
                                ElevatedButton(
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          BorderSide(color: Colors.white)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                    ),
                                    onPressed: () {
                                      //restarts the app
                                      Phoenix.rebirth(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: CustomText(
                                        color: Colors.white,
                                        sizes: Sizes.small,
                                        text: "Try Again",
                                      ),
                                    ))
                              ],
                            )
                          : //a Button to continue
                          Container(
                              width: size.width * 0.7,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                        BorderSide(color: Colors.white)),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                  onPressed: () {
                                    //goes to Home Page
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen(
                                                  apiProvider: apiProvider,
                                                )),
                                        (route) => false);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CustomText(
                                      color: Colors.white,
                                      sizes: Sizes.normal,
                                      text: "Continue",
                                    ),
                                  )),
                            )),
            ],
          ),
        ),
      ),
    );
  }
}
