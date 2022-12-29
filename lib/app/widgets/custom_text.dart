import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  const CustomText({Key? key,
    required this.controller,
    required this.hinTxt,
    this.maxLines = 1,
    this.icon,
    this.isPassword = false
  })
      : super(key: key);

  final TextEditingController controller;
  final String hinTxt;
  final int maxLines;
  final IconData? icon;
  final bool isPassword;

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  bool invisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    invisible == widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: invisible,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
        suffixIcon: widget.isPassword ? IconButton(
            onPressed: () {
               setState(() {
                 invisible = !invisible;
               });
            },
            icon: Icon(invisible ? Icons.visibility_off_outlined : Icons.visibility_outlined)
        )  : null ,
        hintText: widget.hinTxt,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            )
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            )
        ),
      ),
      validator: (val) {
        if ( val == null || val.isEmpty) {
          return 'Enter your ${widget.hinTxt}';
        }
        return null;
      },
      maxLines: widget.maxLines,
    );
  }
}
