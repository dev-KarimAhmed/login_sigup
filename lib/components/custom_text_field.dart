import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({super.key, required this.hintText, this.isHidden , this.onChanged , this.controller});
 final String hintText;
  bool? isHidden = false;
 Function(String)? onChanged;
 TextEditingController? controller;


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        // validator: (data){
        //   if(data!.isEmpty){
        //     return 'This field is required';
        //   }
        // },
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText: widget.isHidden ?? false,
        style: TextStyle(color: Colors.white, fontSize: 18),
        cursorColor: Colors.white,
        cursorHeight: 25,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          )),
        ),
      ),
    );
  }
}

