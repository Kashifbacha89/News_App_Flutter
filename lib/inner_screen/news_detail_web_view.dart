import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/consts/utils.dart';
import 'package:news_app/services/global_methods.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
class NewsDetailWebViewScreen extends StatefulWidget {
  const NewsDetailWebViewScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<NewsDetailWebViewScreen> createState() => _NewsDetailWebViewScreenState();
}

class _NewsDetailWebViewScreenState extends State<NewsDetailWebViewScreen> {
  late WebViewController _controller;
  double _progress=0.0;
  @override
  Widget build(BuildContext context) {
    Color color=Utils(context).getColor;
    Size size=Utils(context).getScreenSize;
    return WillPopScope(
      onWillPop: ()async{
        if(await _controller.canGoBack()){
          _controller.goBack();
          //stay inside
          return false;
        }else{
          return true;
        }

      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'URL',
            style: GoogleFonts.lobster(
                textStyle: TextStyle(
                    color: color, fontSize: 20, letterSpacing: 0.6)),
          ),
          actions: [
            IconButton(
                onPressed: () async{
                  await _showModelSheetFct();
                },
                icon: const Icon(Icons.more_horiz),),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              color: _progress==1.0?Colors.transparent:Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: WebView(
                initialUrl: widget.url,
                zoomEnabled: true,
                onProgress: (progress){
                  setState(() {
                    _progress=progress/100;
                  });

                },
                onWebViewCreated: (controller){
                  _controller=controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _showModelSheetFct()async{

    await showModalBottomSheet(context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context){
      return Container(
       decoration: BoxDecoration(
         color: Theme.of(context).cardColor,
         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
       ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey
                ),
              ),
            ),
            const VerticalSpacing(20),
            const Text('More Option',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
            const VerticalSpacing(20),
            const Divider(thickness: 2,),
            const VerticalSpacing(20),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('share'),
              onTap: ()async{
                try{
                  await Share.share('url',subject: 'look what i made!');
                }catch(error){
                  GlobalMethods.errorDialog(errorMessage: error.toString(), context:context);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.open_in_browser),
              title: const Text('open in browser'),
              onTap: ()async{
                if(!await  launchUrl(Uri.parse(widget.url))){
                  throw 'could not  lunch ${widget.url }';
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('refresh'),
              onTap: ()async{
                try{
                  await _controller.reload();
                }catch(error){
                  GlobalMethods.errorDialog(errorMessage: error.toString(), context:context);
                }finally{
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );
        });
  }
}
