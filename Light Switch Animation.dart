import 'package:first_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//light switch animation

class LightSwitch extends StatefulWidget {
  const LightSwitch({Key? key}) : super(key: key);

  @override
  State<LightSwitch> createState() => _LightSwitchState();
}

class _LightSwitchState extends State<LightSwitch> {

  double containerHeight = 0;
  double stickHeight = 230;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: LightClipper(),
                child: AnimatedContainer(
                  curve: Curves.bounceOut,
                  duration: const Duration(milliseconds: 200),
                  color: Color(0xFFbe2ed6),
                  height: containerHeight,
                ),
              ),
            ),
          Positioned(
              top: size.height/3.6,
              right: 50,
              child: Container(
                padding: const EdgeInsets.all(5),
                height: 200,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(25)
                ),

          )),
          Positioned(
              top: 0,
              right: 55,
              child: Column(
                children: [
                  Container(
                    width: 4,
                    height: stickHeight,
                    color: containerHeight == 0 ? Color(0xFFbe2ed6) : Colors.white,
                  ),
                  GestureDetector(
                    onVerticalDragUpdate: (details){
                      setState(() {
                        stickHeight += details.delta.dy;
                      });
                    },
                    onVerticalDragEnd: (details){
                      if(stickHeight <= 300){
                        setState(() {
                          containerHeight = 0;
                          stickHeight = 230;
                        });
                      }
                      else{
                        setState(() {
                          containerHeight = size.height;
                          stickHeight = 365;
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: containerHeight == 0 ? Colors.orangeAccent : Colors.black,
                    ),
                  )
                ],
              )),
          Positioned(
            top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: Icon(Icons.arrow_back, size: 35, color: containerHeight == 0 ? Color(0xFFbe2ed6) : Colors.black,),
                title: Text("Code Room", style: TextStyle(fontSize: 30, color: containerHeight == 0 ? Color(0xFFbe2ed6) : Colors.black, fontWeight: FontWeight.w700),),
              ))
        ],
      ),
    );
  }
}

class LightClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    double control = height >= 700 ? 0 : 40;

    final path = Path();
    path.lineTo(0, control);
    path.relativeQuadraticBezierTo(width/2, -control, width, 0);
    path.relativeLineTo(0, height - control);
    path.lineTo(0, height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
