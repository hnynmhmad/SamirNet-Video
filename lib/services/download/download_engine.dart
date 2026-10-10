import 'dart:io';
import 'package:http/http.dart' as http;
import '../../data/database/app_database.dart';
import '../platform_resolver/platform_resolver.dart';

class DownloadEngine {
  DownloadEngine({http.Client? client, AppDatabase? database}) : _client=client ?? http.Client(), _db=database ?? AppDatabase.instance;
  final http.Client _client;
  final AppDatabase _db;

  /// This intentionally downloads only direct media URLs. Web-page extraction
  /// (yt-dlp) is not claimed to work on Android until a compatible runtime is bundled and tested.
  Future<int> downloadDirectMedia(String url, Directory targetDirectory, {String? title}) async {
    final platform = PlatformResolver.resolve(url);
    if (!PlatformResolver.isValidHttpUrl(url) || platform == null || platform == 'مصدر ويب غير معروف') {
      throw const FormatException('الرابط غير صالح أو مصدره غير مدعوم.');
    }
    final id = await _db.addDownload(title:title ?? 'ملف وسائط',url:url,platform:platform,status:'downloading');
    try {
      final response = await _client.get(Uri.parse(url)).timeout(const Duration(seconds:30));
      if (response.statusCode < 200 || response.statusCode >= 300) throw HttpException('HTTP ${response.statusCode}');
      final type = response.headers['content-type'] ?? '';
      if (!type.startsWith('video/') && !type.startsWith('audio/') && !type.contains('octet-stream')) {
        throw const FormatException('هذا رابط صفحة ويب وليس رابط ملف وسائط مباشر. استخراج صفحات المنصات غير متاح في هذا الإصدار.');
      }
      await targetDirectory.create(recursive:true);
      final name = 'samirnet_${DateTime.now().millisecondsSinceEpoch}${type.contains('audio') ? '.audio' : '.mp4'}';
      final file = File('${targetDirectory.path}/$name');
      await file.writeAsBytes(response.bodyBytes,flush:true);
      await _db.updateDownload(id, {'title':title ?? name,'status':'completed','file_path':file.path,'size_bytes':await file.length(),'format':file.path.split('.').last});
      return id;
    } catch (e) {
      await _db.updateDownload(id, {'status':'failed','error':e.toString()});
      rethrow;
    }
  }
}