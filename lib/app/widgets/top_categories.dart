import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/category_deal_screen.dart';
import 'package:my_souq/components/declarations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({Key? key}) : super(key: key);

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  void toCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealScreen.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:AppLocalizations.of(context)!.localeName == "ar" ? 70 : 65,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: Declarations.catImages.length,
          itemExtent: 80,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                toCategoryPage(
                  context,
                  Declarations.catImages[index]['title']!
                );
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      Declarations.catImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  const SizedBox(height:4,),
                  Text(getName(Declarations.catImages[index]['title']!, context))
                ],
              ),
            );
          }
      ),
    );
  }

  String getName(String theName,BuildContext context) {
    switch(theName) {
      case "Mobiles":
        return AppLocalizations.of(context)!.mobiles;
      case "Appliances":
        return AppLocalizations.of(context)!.appliances;
      case "Fashion":
        return AppLocalizations.of(context)!.fashion;
      case "Essentials":
        return AppLocalizations.of(context)!.essentials;
      case "Computers":
        return AppLocalizations.of(context)!.computers;
      default:
        return "";
    }
  }
}
