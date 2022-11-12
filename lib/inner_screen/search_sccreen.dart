import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/consts/styles.dart';
import 'package:news_app/consts/utils.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/widgets/empty_screen.dart';
import 'package:news_app/widgets/vertical_spacing.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  late final FocusNode focusNode;
  @override
  void initState() {
    _searchController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _searchController.dispose();
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).getColor;
    Size size = Utils(context).getScreenSize;
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        focusNode.unfocus();
                        Navigator.pop(context);
                      },
                      child: const Icon(IconlyLight.arrowLeft2,size: 30,)),
                  Flexible(
                      child: TextField(
                    focusNode: focusNode,
                    controller: _searchController,
                    style: TextStyle(color: color),
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    onEditingComplete: () {},
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          bottom: 8 / 5,
                        ),
                        hintText: 'Search',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                focusNode.unfocus();
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.red,
                              )),
                        )),
                  ))
                ],
              ),
            ),
            const VerticalSpacing(10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.count(
                  itemCount: searchKeywords.length ,
                  mainAxisSpacing: 4,
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  itemBuilder: (ctx, index){
                    return GestureDetector(
                      onTap: (){},
                      child:Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                           border: Border.all(color: color),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(searchKeywords[index],style: GoogleFonts.lobster(
                            textStyle: const TextStyle(fontSize: 16)
                          ),),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            //const EmptyNewsWidget(text: 'Oops no result found', imagePath: 'assets/images/search.png')
          ],
        ),
      ),
    ));
  }
}
