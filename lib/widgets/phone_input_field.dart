import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneInputField extends StatelessWidget {
  final Function(String)? onChanged;

  const PhoneInputField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: UnderlineInputBorder(),
      ),
      initialCountryCode: 'LK',
      onChanged: (phone) {
        if (onChanged != null) {
          onChanged!(phone.completeNumber);
        }
      },
    );
  }
}
