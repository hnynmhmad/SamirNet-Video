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
  static const _instances = ['https://inv.nadeko.net','https://invidious.nerdvpn.de','https://invidious.privacyredirect.com'];

  Future<List<VideoSearchResult>> search(String query) async {
    if (query.trim().isEmpty) return [];
    Object? lastError;
    for (final base in _instances) {
      try {
        final response = await _client.get(Uri.parse('$base/api/v1/search').replace(queryParameters:{'q':query.trim(),'type':'video'})).timeout(const Duration(seconds:8));
        if (response.statusCode != 200) { lastError = Exception('HTTP ${response.statusCode}'); continue; }
        final data = jsonDecode(response.body);
        if (data is! List) throw const FormatException('Unexpected search response');
        return data.whereType<Map<String,dynamic>>().where((e)=>e['videoId'] is String && e['title'] is String).map((e)=>VideoSearchResult(
          id:e['videoId'] as String, title:e['title'] as String, author:(e['author'] as String?) ?? '',
          thumbnail:(e['videoThumbnails'] is List && (e['videoThumbnails'] as List).isNotEmpty) ? ((e['videoThumbnails'] as List).last['url'] as String? ?? '') : '',
          durationSeconds:e['lengthSeconds'] is int ? e['lengthSeconds'] as int : null,
        )).toList();
      } catch (e) { lastError = e; }
    }
    throw Exception('تعذر البحث من المصادر العامة حالياً: $lastError');
  }
}