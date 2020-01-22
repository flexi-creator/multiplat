import 'dart:io';

import 'package:flutter/foundation.dart';

// web friendly check for apple based platforms
bool isCupertino() => !kIsWeb && (Platform.isIOS || Platform.isMacOS);