 import 'window.dart';

class WindowListener{

    Function(Application)? onClose;
    Function(Application)? onResize;
    Function(Application)? onHide;


    WindowListener({this.onClose, this.onResize, this.onHide});

  void onWindowClose(Application windowBody){
            onClose!(windowBody);
    }


}