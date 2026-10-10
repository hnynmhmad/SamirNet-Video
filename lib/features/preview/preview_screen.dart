import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.url, required this.platform});
  final String url;
  final String platform;

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: const Text('معاينة الرابط')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(22)),
            child: const Icon(Icons.play_circle_outline, color: Colors.white, size: 70),
          ),
          const SizedBox(height: 16),
          const Text('تم التحقق من صيغة الرابط', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _info('المنصة', platform),
          _info('الرابط', url),
          const SizedBox(height: 18),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('لم يتم استخراج عنوان الفيديو أو الجودات بعد. يتطلب ذلك محرك استخراج متوافقاً مع Android؛ لن نعرض معلومات أو خيارات تنزيل غير مؤكدة.'),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.link),
            label: const Text('تعديل الرابط'),
          ),
        ],
      ),
    ),
  );

  Widget _info(String title, String value) => Card(
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppColors.muted)),
          const SizedBox(height: 5),
          SelectableText(value),
        ],
      ),
    ),
  );
}