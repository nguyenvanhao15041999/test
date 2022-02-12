import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {

static AnimationController controller;
  static Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700)
    );
    controller.addStatusListener((status) async {
      if(status == AnimationStatus.completed){
        await Future.delayed(Duration(seconds: 1));
        controller.reset();
      }
    });
    setRotation(90);
  }
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  void setRotation(int degrees) {
    final angle = degrees * pi / 180;
    animation = Tween<double>(begin: 0, end: angle).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    final degrees = 90;
    final angle = degrees * pi / 180;
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotate Image'),
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(64),
          child: Column(
            children: [
              AnimatedBuilder(animation: animation,
                child: Image.network(
                  'https://png.pngtree.com/png-clipart/20190916/original/pngtree-beautiful-and-beautiful-gift-box-png-image_4586626.jpg',
                  fit: BoxFit.cover,
                  height: 250,
                  width: 250,
                ),
              builder: (context, child) =>
                  Transform.rotate(angle: animation.value,
                    child: child,),
              ),
              SizedBox(height: 32,),
              ElevatedButton(style:ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(52),
                textStyle: TextStyle(fontSize: 24)
              ),
              onPressed: (){
                setRotation(180);
                controller.forward(from: 0);
              }, child: Text('rotate'))
            ],
          )
      ),
    );
  }
}
