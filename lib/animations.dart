
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:photo_view/photo_view.dart';

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;


  // late AnimationController animationController =
  // AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat(reverse: false);
  late Animation<Offset> animationOffset;
   double Xvalue = 0.0;
  double Yvalue = 0.0;

  double zoomValue = 0.41;

  Offset offsetFromVal = Offset.zero;
  Offset offsetToVal = Offset.zero;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);
    // it flying from left side towards center
    // -ve value mean it start from left side
    animation = Tween(begin: 0.0, end: -1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));
    animationOffset = Tween<Offset>(begin:offsetFromVal,end: offsetToVal).animate(animationController);

  }

  Widget SlideAnimation() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: SlideTransition(
        position: Tween<Offset>(begin:offsetFromVal,end: offsetToVal).animate(animationController),
        // position: animationOffset,
        child: PhotoView(
          imageProvider: const AssetImage("assets/world.jpeg"),
          // controller: controllerPhoto,
          // scaleStateController: scaleStateController,
          enableRotation: true,
          initialScale:  zoomValue,
          minScale: 0.41,
          maxScale: 5.0,
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
        ),
        // Image.asset('assets/world.jpeg',height: 200,width: MediaQuery.of(context).size.width,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: Center(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 350.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print(animation.value);
                            print(animation.value * width);

                            offsetFromVal = offsetToVal;
                            offsetToVal = const Offset(0.0,1.0);

                            // animationOffset = Tween<Offset>(begin:offsetFromVal,end: offsetToVal).animate(animationController);

                            setState(() {
                              zoomValue = 2.0;
                              animationController.forward();
                            });

                          },
                          child: Text('Live'),
                          // elevation: 7.0,
                          // color: Colors.blue,
                          // textColor: Colors.white,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print(animation.value);
                            print(animation.value * width);
                            // animationController.reverse();

                            offsetFromVal = offsetToVal;
                            offsetToVal = const Offset(-1.0,-1.0);

                            // animationOffset = Tween<Offset>(begin:offsetFromVal,end: offsetToVal).animate(animationController);

                            setState(() {
                              zoomValue = 2.0;
                              animationController.forward();
                            });
                            // Future.delayed(Duration(milliseconds: 10), () {
                            //   // animationController.duration = Duration(seconds: 10);
                            //   // Do something
                            //   //
                            //   print(offsetFromVal);
                            //   print(offsetToVal);
                            //   animationOffset = Tween<Offset>(begin:offsetFromVal,end: offsetToVal).animate(animationController);
                            //   animationController.forward();
                            //
                            // });
                          },
                          child: Text('Details'),
                          // elevation: 7.0,
                          // color: Colors.blue,
                          // textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                  // padding: Align(alignment:,),
                  child: GestureDetector(
                    onTap: () {
                      print(animation.value);
                      print(animation.value * width);
                      animationController.forward();
                    },
                    onDoubleTap: () {
                      print(animation.value);
                      print(animation.value * width);
                      animationController.reverse();
                    },
                    child: ClipRect(
                      child: SlideAnimation(),

                      // Container(
                      //   alignment: Alignment.bottomCenter,
                      //   width: MediaQuery.of(context).size.width,
                      //   height: 200.0,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15.0),
                      //     image: DecorationImage(
                      //       image: AssetImage('assets/world.jpeg'),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      //   transform: Matrix4.translationValues(
                      //       Xvalue , Yvalue , 0.0),
                      // ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
