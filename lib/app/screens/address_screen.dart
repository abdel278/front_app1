import 'package:flutter/material.dart';
import 'package:my_souq/app/services/product_services.dart';
import 'package:my_souq/app/widgets/custom_button.dart';
import 'package:my_souq/app/widgets/custom_text.dart';
import 'package:my_souq/components/declarations.dart';
import 'package:my_souq/components/utils.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  static const String routeName = '/address';
  final String totalAmount;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final ProductServices productServices = ProductServices();
  final TextEditingController addressTxt = TextEditingController();
  final TextEditingController homeTxt = TextEditingController();
  final TextEditingController areaTxt = TextEditingController();
  final TextEditingController specialTxt = TextEditingController();
  final _addressFormScreen = GlobalKey<FormState>();

  void payPressed(String theAddress, String paymentMethod) {
    bool formOk = addressTxt.text.isNotEmpty ||
        homeTxt.text.isNotEmpty ||
        areaTxt.text.isNotEmpty ||
        specialTxt.text.isNotEmpty;
    if (formOk) {
      if (_addressFormScreen.currentState!.validate()) {
        theAddress =
            " ${addressTxt.text} , ${homeTxt.text} , ${areaTxt.text} ,${specialTxt.text} ,";
      } else {
        showAlertDialog2(context, 'Stop', 'Fill all address info');
      }
    } else {
      if (theAddress.isEmpty) {
        showAlertDialog2(context, 'Stop', 'Fill all address info');
      }
    }
    productServices.saveUserAddress(context: context, address: theAddress);
    productServices.setAnOrder(
        context: context,
        address: theAddress,
        totalPrice: double.parse(widget.totalAmount),
        paymentMethod: paymentMethod);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressTxt.dispose();
    homeTxt.dispose();
    areaTxt.dispose();
    specialTxt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var address =
        Provider.of<UserProvider>(context, listen: false).user.address;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: Declarations.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Add your Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Or you have new address',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                  key: _addressFormScreen,
                  child: Column(
                    children: [
                      CustomText(
                          controller: addressTxt,
                          hinTxt: 'Address,',
                          icon: Icons.home_outlined),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                          controller: homeTxt,
                          hinTxt: 'Home, Number',
                          icon: Icons.streetview_outlined),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                          controller: areaTxt,
                          hinTxt: 'Area, Street',
                          icon: Icons.add_business_rounded),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                          controller: specialTxt,
                          hinTxt: 'Special Mark',
                          icon: Icons.mark_as_unread_outlined),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {
                          payPressed(address, "CASH");
                        },
                        text: 'Cash on delivery',
                        icon: Icons.money,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
