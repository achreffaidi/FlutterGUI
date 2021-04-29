import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywebsite/windows/WindowListener.dart';

abstract class WindowBody extends StatefulWidget {


        String? title;
        WindowListener? listener;
        WindowBody({Key? key, this.title, this.listener}) : super(key: key);

  void setListener(WindowListener listener){
    this.listener = listener;
  }


}


abstract class WindowBodyState extends State<WindowBody> {

  late double windowWidth ;
  late double windowHeight ;


  @override
  void initState() {
    super.initState();
     windowWidth = getWidth();
     windowHeight = getHeight();
  }



  @override
  Widget build(BuildContext context) {

   

    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            _getHeader(),
            _getBody(),
          ],
        ),
      ),
    );
  }

  _getHeader() {
    return Container(
      width: windowWidth,
      height: 40,
      color: Colors.blueGrey,
      child: AppBar(
        title: Text(widget.title!),
        leading: Row(
          children: [
            _getCircleButton(Colors.red, Icons.close,callback: (){
              widget.listener!.onWindowClose(widget);
            }),
            _getCircleButton(Colors.orangeAccent, Icons.remove),
            _getCircleButton(Colors.green, Icons.fullscreen)
          ],
        ),
      ),
    );

  }

  _getBody() {
    return GestureDetector(
      onVerticalDragDown: (_) {},
      onHorizontalDragDown: (_) {},
      child: Container(

          child: getApp()),
    );
  }

  double getWidth();
  double getHeight();
  Widget getApp();


  

  _getCircleButton(Color color, IconData iconData, {VoidCallback? callback}){

    return InkResponse(
      onTap: callback,
      child: new Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        width: 12,
        height: 12,
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          size: 10,
          color: Color.lerp(Colors.black, Colors.transparent, 0.5),
        ),
      ),
    );

  }

}
