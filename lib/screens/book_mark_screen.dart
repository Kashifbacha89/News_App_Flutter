import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/widgets/artical_widget.dart';
import 'package:news_app/widgets/empty_screen.dart';

import '../consts/utils.dart';
class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Scaffold(
      appBar:  AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Bookmarks',
          style: GoogleFonts.lobster(
              textStyle: TextStyle(
                  color: color, fontSize: 20, letterSpacing: 0.6)),
        ),

      ),
      body:const EmptyNewsWidget(text: "you did\'t add anything to your bookmark yet! ",
          imagePath: 'assets/images/bookmark.png')
      // ListView.builder(
      //     itemCount: 20,
      //     itemBuilder: (ctx,index){
      //   return const ArticlesWidget();
      // }),
    );
  }
}
