import 'package:flutter/material.dart';
import 'package:my_souq/app/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product, required this.isLiked}) : super(key: key);

  final Product product;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow> [
          BoxShadow(color: Colors.black12, blurRadius: 15, spreadRadius: 10),
        ]
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.amberAccent,
                        ),
                        Image.network(product.images[0])
                      ],
                    )
                ),
                Text(
                    product.name,
                   style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Best Sale',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                Text(
                  '${product.price} \$',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
              ],
            ),
            Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                  icon: Icon (
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color:  Colors.red,
                  ),
                  onPressed: () {},
                )
            ),
          ],
        ),
      ),

    );
  }
}
