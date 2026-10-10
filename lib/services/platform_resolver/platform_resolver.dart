class PlatformResolver {
  static String? resolve(String input) {
    final uri = Uri.tryParse(input.trim());
    if (!_isSafeHttpUri(uri)) return null;

    final host = uri!.host.toLowerCase().replaceFirst(RegExp(r'^www\.'), '');
    if (host == 'youtube.com' || host.endsWith('.youtube.com') || host == 'youtu.be') return 'YouTube';
    if (host == 'tiktok.com' || host.endsWith('.tiktok.com')) return 'TikTok';
    if (host == 'instagram.com' || host.endsWith('.instagram.com')) return 'Instagram';
    if (host == 'snapchat.com' || host.endsWith('.snapchat.com')) return 'Snapchat';
    if (host == 'facebook.com' || host.endsWith('.facebook.com') || host == 'fb.watch') return 'Facebook';
    return 'مصدر ويب غير معروف';
  }

  static bool isValidHttpUrl(String input) => _isSafeHttpUri(Uri.tryParse(input.trim()));

  static bool _isSafeHttpUri(Uri? uri) {
    if (uri == null || !uri.hasAuthority) return false;
    if (uri.scheme != 'https' && uri.scheme != 'http') return false;
    if (uri.host.isEmpty || uri.userInfo.isNotEmpty) return false;
    if (!uri.host.contains('.') && uri.host != 'localhost') return false;
    return true;
  }
}