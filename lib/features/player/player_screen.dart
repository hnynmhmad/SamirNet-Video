import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key, required this.filePath, this.title='مشغل الوسائط'});
  final String filePath, title;
  @override State<PlayerScreen> createState()=>_PlayerScreenState();
}
class _PlayerScreenState extends State<PlayerScreen> {
  VideoPlayerController? controller;
  String? error;
  @override void initState(){super.initState(); _init();}
  Future<void> _init() async {
    try {
      final file=File(widget.filePath);
      if(!await file.exists()) throw const FileSystemException('الملف غير موجود');
      final c=VideoPlayerController.file(file);
      await c.initialize();
      if(!mounted){await c.dispose();return;}
      setState(()=>controller=c);
      await c.play();
    } catch(e){if(mounted)setState(()=>error=e.toString());}
  }
  @override void dispose(){controller?.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>Directionality(textDirection:TextDirection.rtl,child:Scaffold(
    appBar:AppBar(title:Text(widget.title)),
    body:error!=null?Center(child:Padding(padding:const EdgeInsets.all(20),child:Text('تعذر تشغيل الملف: $error'))):
      controller==null?const Center(child:CircularProgressIndicator()):Column(mainAxisAlignment:MainAxisAlignment.center,children:[
        AspectRatio(aspectRatio:controller!.value.aspectRatio,child:VideoPlayer(controller!)),
        VideoProgressIndicator(controller!,allowScrubbing:true,padding:const EdgeInsets.all(16)),
        Row(mainAxisAlignment:MainAxisAlignment.center,children:[
          IconButton(onPressed:()=>controller!.seekTo(controller!.value.position-const Duration(seconds:10)),icon:const Icon(Icons.replay_10)),
          IconButton(onPressed:()=>setState(()=>controller!.value.isPlaying?controller!.pause():controller!.play()),icon:Icon(controller!.value.isPlaying?Icons.pause_circle:Icons.play_circle),iconSize:48),
          IconButton(onPressed:()=>controller!.seekTo(controller!.value.position+const Duration(seconds:10)),icon:const Icon(Icons.forward_10)),
        ]),
      ]),
  ));
}