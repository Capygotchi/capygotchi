import 'package:flutter/foundation.dart' show kIsWeb;

class constants {
  static const String basePath = kIsWeb ? 'http://localhost:1234' : '';
}