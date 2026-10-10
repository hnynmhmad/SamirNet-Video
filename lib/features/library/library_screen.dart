import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/database/app_database.dart';
import '../player/player_screen.dart';

class LibraryScreen extends StatefulWidget { const LibraryScreen({super.key}); @override State<LibraryScreen> createState()=>_LibraryScreenState(); }
class _LibraryScreenState extends State<LibraryScreen>{
 final search=TextEditingController(); Future<List<Map<String,Object?>>>? future;
 @override void initState(){super.initState();_refresh();}
 void _refresh()=>future=AppDatabase.instance.downloads(status:'completed');
 @override void dispose(){search.dispose();super.dispose();}
 @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.all(18),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
 const Text('تم تنزيلها',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)),const SizedBox(height:16),
 TextField(controller:search,onChanged:(_)=>setState((){}),decoration:const InputDecoration(prefixIcon:Icon(Icons.search),hintText:'ابحث في الملفات المحلية')),
 const SizedBox(height:12),
 Expanded(child:FutureBuilder<List<Map<String,Object?>>>(future:future,builder:(context,snapshot){
 if(snapshot.connectionState==ConnectionState.waiting)return const Center(child:CircularProgressIndicator());
 if(snapshot.hasError)return Center(child:Text('تعذر قراءة المكتبة: ${snapshot.error}'));
 final rows=(snapshot.data??[]).where((r)=>(r['title'] as String? ?? '').toLowerCase().contains(search.text.toLowerCase())).toList();
 if(rows.isEmpty)return const Center(child:Column(mainAxisSize:MainAxisSize.min,children:[Icon(Icons.video_library_outlined,size:58,color:AppColors.muted),SizedBox(height:10),Text('مكتبتك فارغة'),Text('ستظهر الملفات المحفوظة محلياً هنا',style:TextStyle(color:AppColors.muted))]));
 return ListView.separated(itemCount:rows.length,separatorBuilder:(_,__)=>const SizedBox(height:8),itemBuilder:(context,i){final r=rows[i];final path=r['file_path'] as String?;return Card(child:ListTile(leading:const Icon(Icons.video_file,color:AppColors.coral,size:34),title:Text(r['title'] as String? ?? 'ملف وسائط',maxLines:2,overflow:TextOverflow.ellipsis),subtitle:Text(path??'مسار الملف غير متاح'),trailing:PopupMenuButton<String>(onSelected:(v)async{if(v=='play'&&path!=null){await Navigator.push(context,MaterialPageRoute(builder:(_)=>PlayerScreen(filePath:path,title:r['title'] as String? ?? 'مشغل الوسائط')));}else if(v=='delete'){final id=r['id'] as int; if(path!=null){final f=File(path);if(await f.exists())await f.delete();}await AppDatabase.instance.deleteDownload(id);if(mounted)setState(_refresh);}else if(v=='details'&&context.mounted){showDialog(context:context,builder:(_)=>AlertDialog(title:Text(r['title'] as String? ?? 'تفاصيل الملف'),content:Text('الحجم: ${r['size_bytes']??'غير معروف'} بايت\nالصيغة: ${r['format']??'غير معروفة'}\nالمسار: ${path??'غير متاح'}')));}},itemBuilder:(_)=>const [PopupMenuItem(value:'play',child:Text('تشغيل')),PopupMenuItem(value:'details',child:Text('التفاصيل')),PopupMenuItem(value:'delete',child:Text('حذف الملف'))])));});
 }))
 ]));
}