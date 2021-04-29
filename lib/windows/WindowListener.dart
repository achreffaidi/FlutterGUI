 import 'window.dart';

class WindowListener{

    Function(WindowBody)? onClose;
    Function(WindowBody)? onResize;
    Function(WindowBody)? onHide;


    WindowListener({this.onClose, this.onResize, this.onHide});

  void onWindowClose(WindowBody windowBody){
            onClose!(windowBody);
    }


}