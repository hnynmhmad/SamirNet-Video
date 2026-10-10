import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
class SearchScreen extends StatefulWidget { const SearchScreen({super.key}); @override State<SearchScreen> createState()=>_SearchScreenState(); }
class _SearchScreenState extends State<SearchScreen>{ final c=TextEditingController(); String? message;
 @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.all(18),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
  const Text('البحث',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)),const SizedBox(height:14),
  TextField(controller:c,onSubmitted:(_)=>setState(()=>message='البحث المباشر غير متاح حالياً: لا يوجد محرك بحث مدمج متوافق ومختبر.'),decoration:InputDecoration(hintText:'ابحث عن فيديو...',prefixIcon:const Icon(Icons.search),suffixIcon:IconButton(onPressed:()=>setState(()=>message='اكتب كلمات البحث ثم اضغط Enter.'),icon:const Icon(Icons.arrow_forward)))),
  const SizedBox(height:18),Expanded(child:Center(child:Column(mainAxisSize:MainAxisSize.min,children:[const Icon(Icons.manage_search,size:56,color:AppColors.muted),const SizedBox(height:12),Text(message??'ابحث بالكلمات العادية',style:const TextStyle(color:AppColors.muted),textAlign:TextAlign.center)])))
 ]));
}
