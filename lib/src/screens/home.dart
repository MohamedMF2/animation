import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    super.initState();
    //=======================  BOX  ===================

    boxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    boxAnimation = Tween(
      begin: pi * 0.6,
      end: pi * 0.65,
    ).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut,
      ),
    ); //boxAnimation

    boxAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          boxController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          boxController.forward();
        }
      },
    );
    boxController.forward();

    //=======================  CAT  ===================
    catController = AnimationController(
      duration: Duration(milliseconds: 350),
      vsync: this,
    );

    catAnimation = Tween(begin: -35.0, end: -90.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  } // InitState

  onTap() {
    if (catAnimation.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else if (catAnimation.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation!'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
            clipBehavior: Clip.none,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          left: 0,
          right: 0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      width: 250.0,
      height: 250.0,
      color: Colors.brown.shade300,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 7.0,
      top: 4.5,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          width: 125,
          height: 10,
          color: Colors.brown.shade300,
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: boxAnimation.value,
            child: child,
            alignment: Alignment.topLeft,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 7.0,
      top: 4.5,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          width: 125,
          height: 10,
          color: Colors.brown.shade300,
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: -boxAnimation.value,
            child: child,
            alignment: Alignment.topRight,
          );
        },
      ),
    );
  }
}
