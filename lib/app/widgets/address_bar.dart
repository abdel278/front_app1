import 'package:flutter/material.dart';
import 'package:my_souq/components/declarations.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(gradient: Declarations.appBarGradient2),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Address of ${user.name}, ${user.address}',
                style: const TextStyle(fontWeight: FontWeight.w500,),
                overflow: TextOverflow.ellipsis,
                ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, top: 5),
            child: Icon(Icons.arrow_drop_down_outlined, size: 18,),
            ),
        ],
      ),
    );
  }
}
