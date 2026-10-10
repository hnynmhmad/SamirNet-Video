import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../paste_link/paste_link_screen.dart';
import '../search/search_screen.dart';
import '../downloads/downloads_screen.dart';
import '../library/library_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final _pages = const [DownloadsScreen(), SearchScreen(), PasteLinkScreen(), LibraryScreen()];
  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(
        title: const Row(children: [Icon(Icons.download_rounded, color: AppColors.coral), SizedBox(width: 8), Text('SamirNet Video', style: TextStyle(fontWeight: FontWeight.w900))]),
        actions: [IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())), icon: const Icon(Icons.settings_outlined))],
      ),
      body: _index == 0 ? _home() : _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.folder_open_outlined), selectedIcon: Icon(Icons.folder), label: 'تنزيلاتي'),
          NavigationDestination(icon: Icon(Icons.search), label: 'البحث'),
          NavigationDestination(icon: Icon(Icons.add_circle), label: 'إرسال رابط'),
          NavigationDestination(icon: Icon(Icons.download_done), label: 'تم تنزيلها'),
        ],
      ),
    ),
  );
  Widget _home() => ListView(padding: const EdgeInsets.all(16), children: [
    TextField(readOnly: true, onTap: () => setState(() => _index = 2), decoration: const InputDecoration(prefixIcon: Icon(Icons.link), hintText: 'ابحث عن فيديو أو ألصق رابطاً...')),
    const SizedBox(height: 16),
    Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.coral, Color(0xFFFF7A59)]), borderRadius: BorderRadius.circular(22)), child: const Row(children: [Icon(Icons.play_circle_fill, color: Colors.white, size: 54), SizedBox(width: 12), Expanded(child: Text('أسهل طريقة لتنزيل الفيديوهات والملفات', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))])),
    const SizedBox(height: 16),
    GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.25, children: [
      _tile(Icons.link, 'إرسال الرابط', 'تحليل رابط عام', () => setState(() => _index = 2)),
      _tile(Icons.search, 'البحث', 'البحث عبر الويب', () => setState(() => _index = 1)),
      _tile(Icons.downloading, 'التنزيلات', 'إدارة التنزيلات', () => setState(() => _index = 0)),
      _tile(Icons.video_library_outlined, 'تم تنزيلها', 'مكتبتك المحلية', () => setState(() => _index = 3)),
    ]),
    const SizedBox(height: 18), const Text('أحدث التنزيلات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    const SizedBox(height: 12), const Card(child: Padding(padding: EdgeInsets.all(24), child: Column(children: [Icon(Icons.inbox_outlined, size: 42, color: AppColors.muted), SizedBox(height: 8), Text('لا توجد تنزيلات بعد'), Text('ستظهر ملفاتك هنا بعد حفظها بنجاح', style: TextStyle(color: AppColors.muted))]))),
  ]);
  Widget _tile(IconData icon, String title, String subtitle, VoidCallback tap) => InkWell(onTap: tap, borderRadius: BorderRadius.circular(20), child: Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: AppColors.coral, size: 30), const SizedBox(height: 8), Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 12))]))));
}
