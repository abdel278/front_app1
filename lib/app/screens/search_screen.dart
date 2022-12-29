import 'package:flutter/material.dart';
import 'package:my_souq/app/models/product.dart';
import 'package:my_souq/app/services/home_service.dart';
import 'package:my_souq/app/widgets/loader.dart';
import 'package:my_souq/app/widgets/product_card.dart';
import 'package:my_souq/app/widgets/single_product.dart';
import 'package:my_souq/components/declarations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.searchTxt}) : super(key: key);

  static const String routeName = "/search-screen";
  final String searchTxt;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? productList;
  HomeService homeService = HomeService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    productList = await homeService.searchForProducts(
        context: context,
        txt: widget.searchTxt);
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
              'Search result for ${widget.searchTxt}',
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
            return ProductCard(isLiked: false,product: product,);
          }
      ),
    );
  }
}
