import 'dart:io';

import 'package:path/path.dart';
import 'package:supapet/utils.dart';
import 'package:uuid/uuid.dart';

class StoreHandler {
  static String get bucketName => 'supapet';

  static String getFilePath(File file) {
    var ext = extension(file.path);
    return Uuid().v4() + ext;
  }

  static String getPublicUrl(String path) {
    return supabaseClient.storage
        .from(bucketName)
        .getPublicUrl(path.replaceAll('$bucketName/', ''));
  }

  static Future<String> storeFile(File file) async {
    try {
      var res = await supabaseClient.storage
          .from(bucketName)
          .upload(getFilePath(file), file);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
