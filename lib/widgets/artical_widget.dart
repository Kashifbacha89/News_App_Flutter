import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/consts/styles.dart';
import 'package:news_app/consts/utils.dart';
import 'package:news_app/inner_screen/blog_detail_screen.dart';
import 'package:news_app/inner_screen/news_detail_web_view.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
class ArticlesWidget extends StatelessWidget {
  const ArticlesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=Utils(context).getScreenSize;
    final newsModelProvider=Provider.of<NewsModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, NewsDetailScreen.routeName,
            arguments: newsModelProvider.publishedAt);

          },
          child: Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 60,
                  height: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding:const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FancyShimmerImage(
                          height: size.height*0.12,
                          width: size.height*0.12,
                      imageUrl: newsModelProvider.urlToImage,
                      )
                          //imageUrl: 'https://cdn.pixabay.com/photo/2015/02/22/09/32/news-644847_960_720.jpg'),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                             Text(
                               newsModelProvider.title,
                               //'Title'*100,
                             maxLines: 2,
                             overflow: TextOverflow.ellipsis,
                             textAlign: TextAlign.justify,

                             style: smallTextStyle,),
                          const VerticalSpacing(10),
                           Align(
                            alignment: Alignment.topRight,
                            child: Text('🕒 ${newsModelProvider.readingTimeText}'),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child:  NewsDetailWebViewScreen(
                                          url:newsModelProvider.url
                                        ),
                                        inheritTheme: true,
                                        ctx: context),
                                  );
                                },
                                    icon: const Icon(Icons.link),),
                                 Text(newsModelProvider.dateToShow,style: smallTextStyle,)

                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
