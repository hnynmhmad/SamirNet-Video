import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VideoSearchResult {
  const VideoSearchResult({required this.id, required this.title, required this.author, required this.thumbnail, this.durationSeconds});
  final String id, title, author, thumbnail;
  final int? durationSeconds;
}

class SearchService {
  SearchService({http.Client? client}) : _client = client ?? http.Client();
  final http.Client _client;

  // These are current public instances listed by the Invidious project.
  static const _instances = <String>[
    'https://inv.nadeko.net',
    'https://invidious.nerdvpn.de',
    'https://invidious.tiekoetter.com',
    'https://yt.chocolatemoo53.com',
  ];

  Future<List<VideoSearchResult>> search(String query) async {
    final q = query.trim();
    if (q.isEmpty) return <VideoSearchResult>[];

    Object? lastError;
    for (final base in _instances) {
      try {
        final uri = Uri.parse('$base/api/v1/search').replace(
          queryParameters: <String, String>{'q': q, 'type': 'video'},
        );
        final response = await _client.get(uri, headers: const {
          'Accept': 'application/json',
          'User-Agent': 'SamirNetVideo/1.0',
        }).timeout(const Duration(seconds: 4));
        if (response.statusCode != 200) {
          lastError = 'HTTP ${response.statusCode}';
          continue;
        }
        final decoded = jsonDecode(response.body);
        if (decoded is! List) {
          lastError = 'صيغة استجابة غير متوقعة';
          continue;
        }
        final results = <VideoSearchResult>[];
        for (final item in decoded) {
          if (item is! Map<String, dynamic> ||
              item['videoId'] is! String ||
              item['title'] is! String) {
            continue;
          }
          final thumbs = item['videoThumbnails'];
          var thumbnail = '';
          if (thumbs is List && thumbs.isNotEmpty) {
            final last = thumbs.last;
            if (last is Map<String, dynamic> && last['url'] is String) {
              thumbnail = last['url'] as String;
            }
          }
          results.add(VideoSearchResult(
            id: item['videoId'] as String,
            title: item['title'] as String,
            author: item['author'] as String? ?? '',
            thumbnail: thumbnail,
            durationSeconds: item['lengthSeconds'] is int
                ? item['lengthSeconds'] as int
                : null,
          ));
        }
        return results;
      } on TimeoutException {
        lastError = 'انتهت مهلة الاتصال';
      } catch (error) {
        lastError = error;
      }
    }
    throw Exception('تعذر البحث عبر المصادر العامة. آخر خطأ: $lastError');
  }
}
