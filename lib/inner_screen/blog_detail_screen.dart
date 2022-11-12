import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/consts/styles.dart';
import 'package:news_app/consts/utils.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:provider/provider.dart';
class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({Key? key}) : super(key: key);
  static const routeName='/NewsDetailScreen';

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  String? publishedAt;
  @override
  void didChangeDependencies() {
    publishedAt=ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    Color color=Utils(context).getColor;
    Size size=Utils(context).getScreenSize;
    final newsProvider=Provider.of<NewsProvider>(context);
    final currentNews=newsProvider.findByDate(publishedAt: publishedAt);
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(currentNews.authorName,
        textAlign: TextAlign.center,
        style: TextStyle(color: color),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(IconlyLight.arrowLeft,color: color,),),
      ) ,
      body: ListView(
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
          child: Column(
            children: [
              Text(currentNews.title,textAlign: TextAlign.justify,style: titleTextStyle,),
              const VerticalSpacing(10),
              Row(
                children: [
                  Text(currentNews.dateToShow,style: smallTextStyle,),
                  const Spacer(),
                  Text(currentNews.readingTimeText,style: smallTextStyle,)
                ],
              ),
              const VerticalSpacing(20),
              
            ],

          ),),
          Stack(children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: FancyShimmerImage(imageUrl: currentNews.urlToImage,
                boxFit: BoxFit.fill,
                errorWidget: Image.asset('assets/images/empty_image.png'),),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Card(
                        elevation: 10,
                        shape: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(IconlyLight.send,size: 28,color: color,),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Card(
                        elevation: 10,
                        shape: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(IconlyLight.bookmark,size: 28,color: color,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],),
          const VerticalSpacing(20),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const TextContent(
                label: 'Description',
                fontSize: 20,
                 fontWeight: FontWeight.bold,
                
              ),
              const VerticalSpacing(10),
              TextContent(label:currentNews.description,
                fontWeight: FontWeight.normal,fontSize: 18),
              const VerticalSpacing(20),
               const TextContent(label:'Content',fontSize: 20,fontWeight: FontWeight.bold),
              const VerticalSpacing(10),
              TextContent(label:currentNews.content,fontWeight: FontWeight.normal,fontSize: 18),
            ],
          ),),

        ],
      ),
    );
  }
  
}
class TextContent extends StatelessWidget {
  const TextContent({Key? key, required this.label, required this.fontSize, required this.fontWeight}) : super(key: key);
  final String label;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      label,
      textAlign: TextAlign.justify,
      style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: fontSize,fontWeight: fontWeight)),
    );
  }
}

