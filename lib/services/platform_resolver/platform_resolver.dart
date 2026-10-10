class PlatformResolver {
  static String? resolve(String input) {
    final uri = Uri.tryParse(input.trim());
    if (uri == null || !uri.hasScheme || (uri.scheme != 'https' && uri.scheme != 'http') || uri.host.isEmpty) return null;
    final host = uri.host.toLowerCase().replaceFirst(RegExp(r'^www\.'), '');
    if (host == 'youtube.com' || host.endsWith('.youtube.com') || host == 'youtu.be') return 'YouTube';
    if (host == 'tiktok.com' || host.endsWith('.tiktok.com')) return 'TikTok';
    if (host == 'instagram.com' || host.endsWith('.instagram.com')) return 'Instagram';
    if (host == 'snapchat.com' || host.endsWith('.snapchat.com')) return 'Snapchat';
    if (host == 'facebook.com' || host.endsWith('.facebook.com') || host == 'fb.watch') return 'Facebook';
    return 'مصدر ويب غير معروف';
  }
  static bool isValidHttpUrl(String input) {
    final uri = Uri.tryParse(input.trim());
    return uri != null && (uri.scheme == 'https' || uri.scheme == 'http') && uri.host.contains('.');
  }
}
