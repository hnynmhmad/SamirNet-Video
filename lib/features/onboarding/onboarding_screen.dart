import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, required this.onStart});
  final VoidCallback onStart;
  @override
  Widget build(BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: Scaffold(
    body: SafeArea(child: Padding(padding: const EdgeInsets.all(28), child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 12),
        Column(children: [
          Container(width: 96, height: 96, decoration: BoxDecoration(color: AppColors.coral, borderRadius: BorderRadius.circular(28)), child: const Icon(Icons.download_rounded, color: Colors.white, size: 58)),
          const SizedBox(height: 18),
          const Text('SamirNet Video', style: TextStyle(fontSize: 31, fontWeight: FontWeight.w900, color: AppColors.ink)),
          const SizedBox(height: 8),
          Text('كل ما تريد من الفيديوهات في مكان واحد', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurfaceVariant)),
          const SizedBox(height: 24),
          const Wrap(spacing: 14, children: [Icon(Icons.smart_display, color: Colors.red, size: 30), Icon(Icons.music_video, color: AppColors.ink, size: 30), Icon(Icons.camera_alt, color: Colors.pink, size: 30), Icon(Icons.public, color: Colors.blue, size: 30)]),
        ]),
        Container(height: 180, width: 170, decoration: BoxDecoration(color: AppColors.coral.withValues(alpha: .08), borderRadius: BorderRadius.circular(32)), child: const Icon(Icons.smartphone_rounded, size: 130, color: AppColors.coral)),
        Column(children: [
          ElevatedButton(onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen())), child: const Text('ابدأ الآن  ›')),
          const SizedBox(height: 12),
          const Text('استخدم الروابط العامة التي يسمح المصدر بالوصول إليها', textAlign: TextAlign.center, style: TextStyle(color: AppColors.muted, fontSize: 12)),
        ])
      ],
    ))),
  ));
}
