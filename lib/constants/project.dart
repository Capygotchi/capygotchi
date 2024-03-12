import 'package:flutter/foundation.dart' show kIsWeb;

class Constants {
  static const String basePath = kIsWeb ? 'http://localhost:1234' : '';
}