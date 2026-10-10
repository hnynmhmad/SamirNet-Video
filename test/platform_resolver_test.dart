import 'package:flutter_test/flutter_test.dart';
import 'package:samirnet_video/services/platform_resolver/platform_resolver.dart';
void main() {
 group('PlatformResolver', () {
  test('recognizes supported public platform domains', () {
   expect(PlatformResolver.resolve('https://youtu.be/abc'), 'YouTube');
   expect(PlatformResolver.resolve('https://www.tiktok.com/@user/video/1'), 'TikTok');
   expect(PlatformResolver.resolve('https://instagram.com/p/abc'), 'Instagram');
  });
  test('rejects malformed and non-http URLs', () {
   expect(PlatformResolver.isValidHttpUrl('not a link'), isFalse);
   expect(PlatformResolver.isValidHttpUrl('file:///tmp/video.mp4'), isFalse);
  });
  test('does not misclassify unrelated domains', () {
   expect(PlatformResolver.resolve('https://example.com/video'), 'مصدر ويب غير معروف');
  });
 });
}
