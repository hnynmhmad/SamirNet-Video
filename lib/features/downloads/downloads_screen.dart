import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(18),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('التنزيلات', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
      const SizedBox(height: 16),
      const Row(children: [Expanded(child: Chip(label: Text('جاري التنزيل'))), SizedBox(width: 8), Expanded(child: Chip(label: Text('مكتملة')))]),
      const Expanded(child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.downloading, size: 58, color: AppColors.muted),
        SizedBox(height: 10),
        Text('لا توجد تنزيلات حالياً'),
        Text('ستظهر حالة التنزيل الحقيقية هنا', style: TextStyle(color: AppColors.muted)),
      ]))),
    ]),
  );
}