import 'package:flutter/cupertino.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class AnalyticProvider extends ChangeNotifier {
  static final String _token = "91e549a9b34761555454b543233828bb";
  static Mixpanel? mixpanel;

  AnalyticProvider.init() {
    Mixpanel.init(_token, trackAutomaticEvents: true)
        .then((value) => mixpanel = value);
  }

  static track(String event, {Map<String, dynamic>? properties}) {
    mixpanel?.track(event, properties: properties);
  }
}
