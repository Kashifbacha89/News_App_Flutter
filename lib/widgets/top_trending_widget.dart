import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/consts/utils.dart';
import 'package:news_app/inner_screen/blog_detail_screen.dart';
import 'package:news_app/inner_screen/news_detail_web_view.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =Utils(context).getScreenSize;
    final Color color =Utils(context).getColor;
    final newsModelProvider=Provider.of<NewsModel>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, NewsDetailScreen.routeName,
              arguments: newsModelProvider.publishedAt);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    height: size.height*0.33,
                    width: double.infinity,
                    imageUrl: newsModelProvider.urlToImage,

                    //imageUrl: 'https://cdn.pixabay.com/photo/2015/02/22/09/32/news-644847_960_720.jpg',
                    boxFit: BoxFit.fill,

                  ),

                ),
                 Padding(
                  padding:  const EdgeInsets.all(8.0),
                  child:  Text(newsModelProvider.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                 Row(
                   children: [
                     IconButton(onPressed: (){
                       Navigator.push(context, PageTransition(child:  NewsDetailWebViewScreen(
                         url: newsModelProvider.url,
                       ),
                           type: PageTransitionType.rightToLeft));
                     }, icon: const Icon(Icons.link)),
                     const Spacer(),
                      Text(newsModelProvider.dateToShow,style: GoogleFonts.montserrat(fontSize: 15),),
                   ],
                 )

              ],
            )),
      ),
    );
  }
}
