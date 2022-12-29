import 'package:flutter/material.dart';
import 'package:my_souq/app/models/product.dart';
import 'package:my_souq/app/services/home_service.dart';
import 'package:my_souq/app/widgets/loader.dart';
import 'package:my_souq/app/widgets/single_product.dart';
import 'package:my_souq/components/declarations.dart';

class CategoryDealScreen extends StatefulWidget {
  const CategoryDealScreen({Key? key, required this.category}) : super(key: key);

  static const String routeName = "/category-deal";
  final String category;

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  List<Product>? productList;
  HomeService homeService = HomeService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    productList = await homeService.getCategoryProducts(
        context: context,
        category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: Declarations.appBarGradient
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.category,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: productList == null ? const Loader() :
      GridView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: productList!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final product = productList![index];
            return Column(
                children: [
                  SizedBox(
                    height: 140,
                    child: SingleProduct(
                      image: product.images[0],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          )
                      ),
                      Text(
                        '${product.price} EGP',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ]
            );
          }
      ),
    );
  }
}

