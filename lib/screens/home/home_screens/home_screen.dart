import 'dart:convert';

import 'package:ecommerce_app_isaatech/components/rating_widget.dart';
import 'package:ecommerce_app_isaatech/models/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import '/components/buttons.dart';
import '/components/main_page_product_card.dart';
import '/constants/dummy_data.dart';
import '/constants/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DataModel? model1;
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);

    DataModel model = DataModel.fromJson(response);
    setState(() {
      model1 = model;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();


  }


  @override
  Widget build(BuildContext context) {
    return model1 == null ? Center(child: CircularProgressIndicator(),) : Column(
      children: [
        const SearchBar(),
        8.heightBox,
         CategoriesCatalog(model: model1!,),
         ProductPageView(model: model1!,),

      ],
    ).py(8);
  }
}



class ProductPageView extends StatefulWidget {
  const ProductPageView({Key? key,required this.model}) : super(key: key);
  final DataModel model;
  @override
  State<ProductPageView> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends State<ProductPageView> {
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PageView.builder(
          controller: PageController(viewportFraction: 0.60, initialPage: 1),
          onPageChanged: (v) {
            setState(() {
              _currentPage = v;
            });
          },
          itemCount: widget.model.data.length,
          itemBuilder: (context, index) {
            return HomeScreenProductCard(
              index: index,
              name: widget.model.data[index].pName,
              p_cost: "${widget.model.data[index].pCost}",
              p_category: widget.model.data[index].pCategory,
              p_details: widget.model.data[index].pDetails,
              p_availability: "${widget.model.data[index].pAvailability}",
              isCurrentInView: _currentPage == index,
            );
          }),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade100,
            ),
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.search, color: Colors.grey)
                          .px(16),
                      const Flexible(
                        child: TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        16.widthBox,
        SizedBox(
          height: 40,
          width: 40,
          child: PrimaryShadowedButton(
            colors: [Colors.black54, Colors.black],
            onPressed: () {},
            child: Center(
              child: Icon(FontAwesomeIcons.slidersH,
                  size: 18, color: Theme.of(context).colorScheme.surface),
            ),
            borderRadius: 12,
            color: Colors.black,
          ),
        )
      ],
    ).px(24);
  }
}

class CategoriesCatalog extends StatefulWidget {
  const CategoriesCatalog({Key? key,required this.model}) : super(key: key);

  final DataModel model;

  @override
  _CategoriesCatalogState createState() => _CategoriesCatalogState();
}

class _CategoriesCatalogState extends State<CategoriesCatalog> {
  int _selectedCategory = 1;




  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.model.data.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: (index == 0)
                  ? const SizedBox(
                      width: 12,
                    )
                  : (_selectedCategory == index)
                      ? SizedBox(
                          height: 47,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryShadowedButton(
                                  child: Row(
                                    children: [
                                      Text(
                                        "${widget.model.data[index].pCategory}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ).px(8),
                                      12.widthBox,
                                    ],
                                  ),
                                  colors: [Colors.black54, Colors.black],
                                  onPressed: () {
                                    setState(() {
                                      _selectedCategory = index;
                                    });
                                  },
                                  borderRadius: 80,
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ],
                          ),
                        )
                      : SizedBox(
                height: 47,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryShadowedButton(
                        child: Row(
                          children: [
                            Text(
                              "${widget.model.data[index].pCategory}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ).px(8),
                            12.widthBox,
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedCategory = index;
                          });
                        },
                        borderRadius: 80,
                        colors: [Colors.white,Colors.white54],
                        color:Colors.white),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class WhiteCategoryButton extends StatelessWidget {
  const WhiteCategoryButton({Key? key, required this.updateCategory,required this.Name})
      : super(key: key);

  final Function() updateCategory;
  final String Name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47,
      height: 47,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 24)
          ]),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: updateCategory,
        child: Text(
          Name,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ).px(8),
      ),
    );
  }
}
