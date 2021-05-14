import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService{

  AnalyticsService(this.analytics,this.observer);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  Future<void> sendAnalyticsOpenApp(String appName) async {
    await analytics.logEvent(
      name: 'OpenApp',
      parameters: <String, dynamic>{
        'appName': appName,
      },
    );
  }

  Future<void> sendWindowsXPCrash(String appName) async {
    await analytics.logEvent(
      name: 'WindowsXPCrash',
      parameters: <String, dynamic>{
        'appName': appName,
      },
    );
  }
  Future<void> sendOpenUrl(String url) async {
    await analytics.logEvent(
      name: 'LaunchUrl',
      parameters: <String, dynamic>{
        'url': url,
      },
    );
  }

}