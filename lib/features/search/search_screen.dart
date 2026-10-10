import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../services/search/search_service.dart';
import '../preview/preview_screen.dart';

class SearchScreen extends StatefulWidget { const SearchScreen({super.key}); @override State<SearchScreen> createState()=>_SearchScreenState(); }
class _SearchScreenState extends State<SearchScreen>{
 final c=TextEditingController(); final service=SearchService();
 bool loading=false; String? error; List<VideoSearchResult> results=[]; int request=0;
 Future<void> search(String value) async {
   final q=value.trim(); if(q.isEmpty){setState(()=>error='اكتب كلمات البحث أولاً.');return;}
   final current=++request; setState(()=>{loading=true,error=null,results=<VideoSearchResult>[]});
   try { final found=await service.search(q); if(!mounted||current!=request)return; setState(()=>results=found); if(found.isEmpty)error='لا توجد نتائج لهذا البحث.'; }
   catch(e){if(mounted&&current==request)setState(()=>error=e.toString().replaceFirst('Exception: ',''));}
   finally{if(mounted&&current==request)setState(()=>loading=false);}
 }
 @override void dispose(){c.dispose();super.dispose();}
 @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.all(18),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
  const Text('البحث',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)),const SizedBox(height:14),
  TextField(controller:c,onSubmitted:search,decoration:InputDecoration(hintText:'ابحث عن فيديو...',prefixIcon:const Icon(Icons.search),suffixIcon:IconButton(onPressed:()=>search(c.text),icon:const Icon(Icons.arrow_forward)))),
  const SizedBox(height:12),
  if(loading) const LinearProgressIndicator(),
  if(error!=null&&!loading) Padding(padding:const EdgeInsets.all(12),child:Text(error!,style:const TextStyle(color:AppColors.muted))),
  Expanded(child:results.isEmpty?Center(child:Column(mainAxisSize:MainAxisSize.min,children:[Icon(loading?Icons.cloud_download_outlined:Icons.manage_search,size:56,color:AppColors.muted),const SizedBox(height:12),Text(loading?'جارٍ البحث في المصادر العامة...':error??'ابحث بالكلمات العادية',style:const TextStyle(color:AppColors.muted),textAlign:TextAlign.center)])):ListView.separated(itemCount:results.length,separatorBuilder:(_,__)=>const SizedBox(height:8),itemBuilder:(context,i){final v=results[i];return Card(child:ListTile(leading: v.thumbnail.isEmpty?const Icon(Icons.video_library):Image.network(v.thumbnail,width:84,height:60,fit:BoxFit.cover,errorBuilder:(_,__,___)=>const Icon(Icons.video_library)),title:Text(v.title,maxLines:2,overflow:TextOverflow.ellipsis),subtitle:Text('${v.author}${v.durationSeconds==null?'':' • ${v.durationSeconds} ثانية'}'),trailing:IconButton(icon:const Icon(Icons.download_rounded,color:AppColors.coral),onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>PreviewScreen(url:'https://www.youtube.com/watch?v=${v.id}',platform:'YouTube'))))));})),
 ]));
}