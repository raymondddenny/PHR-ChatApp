import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CustomPhoneNumberTextfield extends StatelessWidget {
  const CustomPhoneNumberTextfield({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            child: CountryCodePicker(
              initialSelection: '+62',
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: '812-0000-0000',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
