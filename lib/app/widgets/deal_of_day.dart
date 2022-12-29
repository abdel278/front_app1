import 'package:flutter/material.dart';
import 'package:my_souq/app/models/product.dart';
import 'package:my_souq/app/screens/product_details_screen.dart';
import 'package:my_souq/app/services/home_service.dart';
import 'package:my_souq/app/widgets/loader.dart';
import 'package:my_souq/app/widgets/product_card_horizontal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  List<Product>? productList;
  HomeService homeService = HomeService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    productList = await homeService.dealOfProducts(
        context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment:AppLocalizations.of(context)!.localeName == 'ar' ?
          Alignment.topRight : Alignment.topLeft  ,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child:  Text(
            AppLocalizations.of(context)!.dealOfTheDay,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
            height: 500,
            width: double.infinity,
            child: productList == null ? const Loader() : ListView.builder(
              itemCount: productList!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ProductDetailScreen.routeName,
                      arguments: productList![index],
                    );
                  },
                  child: ProductCardHorizontal(
                    product: productList![index],
                  ),
                );
              },)
        )
      ],
    );
  }
}



