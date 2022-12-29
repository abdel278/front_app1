import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_souq/app/models/product.dart';
import 'package:my_souq/app/services/product_services.dart';
import 'package:my_souq/app/widgets/stars_bar.dart';
import 'package:my_souq/components/declarations.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  static const String routeName = '/product-detail';
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductServices productServices = ProductServices();
  double avgRating = 0;
  double userRating = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double totalRating =0;
    var user = Provider.of<UserProvider>(context, listen: false).user;
    for (int i = 0; i < widget.product.rating!.length; i ++) {
      totalRating += widget.product.rating![i].rating;
      if ( widget.product.rating![i].userId == user.id) {
        userRating = widget.product.rating![i].rating;
      }
    }
    if (totalRating > 0) {
      avgRating = totalRating /  widget.product.rating!.length;
    }
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
              'Detail For ${widget.product.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                  StarsBar(rating: avgRating),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map(
                    (i) {
                  return Builder(
                    builder: (BuildContext context) =>
                        Image.network(
                          i,
                          fit: BoxFit.contain,
                          height: 200,
                        ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price: ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '\$${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
                initialRating: userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) {
                  return const Icon(Icons.star, color: Colors.amber,);
                },
                onRatingUpdate: (rating) {
                      productServices.rateProduct(
                          context: context,
                          product: widget.product,
                          rating: rating
                      );
                }
            )
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.deepPurpleAccent,
        activeForegroundColor: Colors.white,
        buttonSize: const Size(56, 56),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () {},
        onClose: () {},
        elevation: 8.0,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.shopping_cart_outlined),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Add to Cart',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              productServices.addProductToCart(
                  context: context,
                  product: widget.product,
                  qty: 1
              );
              //Navigator.pop(context);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.monetization_on_outlined),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Buy Now',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}
