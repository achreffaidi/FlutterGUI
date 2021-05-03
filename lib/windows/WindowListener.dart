 import 'window.dart';

class WindowListener{

    Function(Application)? onClose;
    Function(Application)? onResize;
    Function(Application)? onHide;
    Function(Application)? onAppCrash;

    WindowListener({this.onClose, this.onResize, this.onHide,this.onAppCrash});



}