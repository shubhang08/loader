import 'dart:async';

import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _animationTranslateForward;
  late Animation<double> _animationGrowForward;
  late Animation<double> _animationRadeuceForward;

  late Animation<double> _animationTranslateBackward;
  late Animation<double> _animationGrowBackward;
  late Animation<double> _animationRadeuceBackward;
  late Animation<double> _translateInnerBall;







  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    _animationTranslateForward =
        Tween(begin: 0.0, end: 25.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
    _animationGrowForward = Tween(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.50, curve: Curves.easeInOut)));

    _animationRadeuceForward = Tween(begin: 1.05, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.50, 1.0, curve: Curves.easeInOut)));
    _animationTranslateBackward =
        Tween(begin: 25.0, end: 0.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
    _animationGrowBackward = Tween(begin: 1.05, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.50, curve: Curves.easeInOut)));

    _animationRadeuceBackward = Tween(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.50, 1.0, curve: Curves.easeInOut)));




  }

  @override
  void dispose() {
    _animationController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Center(
      child: Flow(
        delegate: LoaderDelegate(
          animationController: _animationController,
          animationTranslateForward: _animationTranslateForward,
          animationGrowForward: _animationGrowForward,
          animationReduceForward: _animationRadeuceForward,
          animationGrowBackward: _animationGrowBackward,
          animationReduceBackward: _animationRadeuceBackward,

          animationTranslateBackward: _animationTranslateBackward,
        ),

        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF37ffec),
            ),

          ),
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFf21458),
            ),

          ),
        ],
      ),
    );
  }
}

class LoaderDelegate extends FlowDelegate {
  final AnimationController animationController;
  final Animation<double> animationTranslateForward;
  final Animation<double> animationGrowForward;
  final Animation<double> animationReduceForward;

  final Animation<double> animationTranslateBackward;
  final Animation<double> animationGrowBackward;
  final Animation<double> animationReduceBackward;

  var firstBallindex = 0;
  var secondBallIndex = 1;



  LoaderDelegate(
      {required this.animationController,
        required this.animationTranslateForward,
        required this.animationGrowForward,
        required this.animationReduceForward,
        required this.animationGrowBackward,
        required this.animationReduceBackward,
        required this.animationTranslateBackward,

      })
      : super(repaint: animationController) {
    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.value = 0.0;
        animationController.animateTo(1.0);
        _reverseChildren();

      }
    });
  }

  _reverseChildren() {
    var tap = firstBallindex;
    firstBallindex = secondBallIndex;
    secondBallIndex = tap;
  }


  @override
  void paintChildren(FlowPaintingContext context) {
    context.paintChild(
      firstBallindex,
      transform: Matrix4.identity()
        ..translate(animationTranslateForward.value)
        ..scale(animationGrowForward.value)
        ..scale(animationReduceForward.value),
    );
    context.paintChild(
      secondBallIndex,
      transform: Matrix4.identity()
        ..translate(animationTranslateBackward.value)
        ..scale(animationGrowBackward.value)
        ..scale(animationReduceBackward.value),
    );
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
