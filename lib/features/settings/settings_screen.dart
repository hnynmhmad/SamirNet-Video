import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../about/about_screen.dart';
class SettingsScreen extends StatefulWidget { const SettingsScreen({super.key}); @override State<SettingsScreen> createState()=>_SettingsScreenState(); }
class _SettingsScreenState extends State<SettingsScreen>{ ThemeMode mode=ThemeMode.system; @override Widget build(BuildContext context)=>Directionality(textDirection:TextDirection.rtl,child:Scaffold(appBar:AppBar(title:const Text('الإعدادات')),body:ListView(padding:const EdgeInsets.all(18),children:[
 const Text('إعدادات عامة',style:TextStyle(fontWeight:FontWeight.bold,color:AppColors.coral)),
 const SizedBox(height:8),Card(child:Column(children:[RadioListTile<ThemeMode>(value:ThemeMode.system,groupValue:mode,title:const Text('حسب النظام'),onChanged:(v)=>setState(()=>mode=v!)),RadioListTile<ThemeMode>(value:ThemeMode.light,groupValue:mode,title:const Text('الوضع الفاتح'),onChanged:(v)=>setState(()=>mode=v!)),RadioListTile<ThemeMode>(value:ThemeMode.dark,groupValue:mode,title:const Text('الوضع الداكن'),onChanged:(v)=>setState(()=>mode=v!))])),
 const Card(child:ListTile(leading:Icon(Icons.notifications_outlined),title:Text('إشعارات التنزيل'),subtitle:Text('تدار عند توفر خدمة التنزيل'))),
 Card(child:ListTile(leading:const Icon(Icons.info_outline),title:const Text('حول التطبيق'),trailing:const Icon(Icons.chevron_left),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const AboutScreen())))),
 const Card(child:ListTile(leading:Icon(Icons.folder_outlined),title:Text('مجلد الحفظ'),subtitle:Text('يتم تحديده عند تنفيذ خدمة التخزين'))),
 ])));
}
