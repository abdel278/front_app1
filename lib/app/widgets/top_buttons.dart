import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/admin_screen.dart';
import 'package:my_souq/app/services/auth_service.dart';
import 'package:my_souq/app/widgets/account_button.dart';
import 'package:my_souq/components/utils.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: "wish list",
              onClik: () {},
            ),
            AccountButton(
              text: "log out",
              onClik: () {
                showAlertDialog(
                    context, () {
                       authService.logOut(context);
                    },
                    'Stop',
                    'Do you want to log out ?'
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              text: "admin Tools",
              onClik: () {
                if (user.type == "admin") {
                  Navigator.pushNamed(context, AdminScreen.routeName);
                } else {
                  showAlertDialog2(
                      context, 'Stop', 'you don\'t have an access permission');
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
