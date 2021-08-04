import 'package:flutter/material.dart';
import 'package:spacex/src/Service/Providers/apiProvider.dart';
import 'package:spacex/src/View/Components/animation.dart';
import 'package:spacex/src/View/Components/appBar.dart';
import 'package:spacex/src/View/Components/constants.dart';
import 'package:spacex/src/View/Components/customText.dart';

class HomeScreen extends StatefulWidget {
  //to use data that saved
  final ApiProvider apiProvider;
  const HomeScreen({Key key, this.apiProvider}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  //a controller for animation
  AnimationController animationController;

  @override
  void initState() {
    //animation settings
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //screen's size
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        //Appbar
        appBar: CustomAppBar(
          text: "SpaceX Lastest Launch",
          widget: SizedBox(),
        ),
        //Body
        body: SingleChildScrollView(
          child: SlideAnimation(
            //animation settings
            itemCount: 12,
            position: 0,
            animationController: animationController,
            slideDirection: SlideDirection.fromBottom,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: size.width * 0.9,
                  height: size.height * 0.9,
                  //box decoration settings
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: secondaryColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        //Title and Flight Number
                        Center(
                            child: ListTile(
                          //name
                          title: CustomText(
                            color: Colors.black,
                            sizes: Sizes.title,
                            text: widget.apiProvider.apiModel.name,
                          ),
                          //flight number
                          trailing: CustomText(
                            color: Colors.black,
                            sizes: Sizes.small,
                            text:
                                "Flight : ${widget.apiProvider.apiModel.flightNumber}",
                          ),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        //Image
                        Image.network(
                            widget.apiProvider.apiModel.links.patch.large),
                        const SizedBox(
                          height: 20,
                        ),
                        //Details
                        Center(
                          child: CustomText(
                            color: Colors.black,
                            sizes: Sizes.small,
                            text: widget.apiProvider.apiModel.details,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
