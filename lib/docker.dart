import 'package:flutter/material.dart';
import 'dart:math';

class Docker extends StatefulWidget {
  @override
  _DockerState createState() => _DockerState();
}

class _DockerState extends State<Docker> {

  static const rad = 20.0;
  static const defaultSize = 40.0;
  static const off = 5.0;
  var _offest = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.7,
      child: Stack(
        children: [

          Positioned(
            bottom: 0,
left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color.lerp(Colors.blue, Colors.transparent, 0.8),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(rad),
                      topRight: Radius.circular(rad),
                      bottomLeft: Radius.circular(rad),
                      bottomRight: Radius.circular(rad)
                  ),
                ),
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: getList()
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(rad),
                      topRight: Radius.circular(rad),
                      bottomLeft: Radius.circular(rad),
                      bottomRight: Radius.circular(rad)
                  ),
                ),
                child: MouseRegion(

                  onHover: (event){
                    setState(() {
                      _offest = event.position.dx;
                    });
                  },
                  onExit: (event){
                    setState(() {
                      _offest = 0 ;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double getButtons(int i){
      if(_offest==0) return 0 ;
      var size = i+1 - 8*(_offest/(MediaQuery.of(context).size.width*0.8));
      size = sqrt(size*size);
      size = sqrt((7 - size)*(7 - size))/2;
      return exp(size*1.2) ;
  }

  List<Widget> getList(){
    List<Widget> list = [];
    for(int  i = 1 ; i<8;i++){
      list.add(Container(
        margin: EdgeInsets.only(bottom: getButtons(i)/4),
        height: getButtons(i) + defaultSize,
        width: getButtons(i) + defaultSize,
        color: Colors.red,
      ),);
    }
    return list ;

  }
}
