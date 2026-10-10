import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_theme.dart';
import '../../services/platform_resolver/platform_resolver.dart';
import '../preview/preview_screen.dart';

class PasteLinkScreen extends StatefulWidget { const PasteLinkScreen({super.key}); @override State<PasteLinkScreen> createState()=>_PasteLinkScreenState(); }
class _PasteLinkScreenState extends State<PasteLinkScreen>{
 final _controller=TextEditingController(); bool _busy=false; String? _error;
 Future<void> _paste() async { final data=await Clipboard.getData('text/plain'); if(data?.text!=null) _controller.text=data!.text!; }
 Future<void> _analyze() async {
  if(_busy)return; final link=_controller.text.trim();
  if(!PlatformResolver.isValidHttpUrl(link)){setState(()=>_error='أدخل رابطاً صحيحاً يبدأ بـ https:// أو http://');return;}
  setState(() { _busy = true; _error = null; });
  try { final platform=PlatformResolver.resolve(link); if(!mounted)return;
   await Navigator.push(context,MaterialPageRoute(builder:(_)=>PreviewScreen(url:link,platform:platform??'مصدر غير معروف')));
  } finally { if(mounted)setState(()=>_busy=false); }
 }
 @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.all(18),child:ListView(children:[
  const Text('إرسال الرابط',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)),const SizedBox(height:8),
  const Text('أدخل رابطاً عاماً لتحقق من صيغته ومصدره.',style:TextStyle(color:AppColors.muted)),
  const SizedBox(height:22),TextField(controller:_controller,keyboardType:TextInputType.url,decoration:InputDecoration(hintText:'الصق الرابط هنا...',prefixIcon:const Icon(Icons.link),suffixIcon:IconButton(onPressed:_paste,icon:const Icon(Icons.content_paste)))),
  if(_error!=null) Padding(padding:const EdgeInsets.only(top:10),child:Text(_error!,style:const TextStyle(color:AppColors.coral))),
  const SizedBox(height:14),ElevatedButton(onPressed:_busy?null:_analyze,child:_busy?const SizedBox(height:22,width:22,child:CircularProgressIndicator(strokeWidth:2,color:Colors.white)):const Text('إرسال وتحليل الرابط')),
  const SizedBox(height:22),const Text('المنصات التي يمكن التعرف عليها',style:TextStyle(fontWeight:FontWeight.bold)),
  const Card(child:Padding(padding:EdgeInsets.all(16),child:Wrap(spacing:18,runSpacing:12,children:[_Platform('YouTube',Icons.smart_display),_Platform('TikTok',Icons.music_video),_Platform('Instagram',Icons.camera_alt),_Platform('Snapchat',Icons.photo_camera),_Platform('Facebook',Icons.public)]))),
  const SizedBox(height:12),const Card(child:Padding(padding:EdgeInsets.all(16),child:Text('تنبيه: التعرّف على المنصة لا يعني أن المحتوى قابل للتنزيل. لا يدعم التطبيق تجاوز تسجيل الدخول أو المحتوى الخاص.'))),
 ]));
}
class _Platform extends StatelessWidget { const _Platform(this.name,this.icon); final String name; final IconData icon; @override Widget build(BuildContext context)=>Column(mainAxisSize:MainAxisSize.min,children:[Icon(icon,color:AppColors.coral,size:25),Text(name,style:const TextStyle(fontSize:11))]);}
