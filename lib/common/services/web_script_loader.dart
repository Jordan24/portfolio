import 'package:flutter/foundation.dart';
import 'package:portfolio/env.dart';
import 'package:web/web.dart' as web;

void injectGoogleMapsScript() {
  if (kIsWeb) {
    final apiKey = Env.googleMapsApiKey;
    final script = web.HTMLScriptElement()
      ..id = 'google-maps-script'
      ..src = 'https://maps.googleapis.com/maps/api/js?key=$apiKey';

    final head = web.document.head;
    if (head?.querySelector('#google-maps-script') == null) {
      head?.append(script);
    }
  }
}
