import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/widgets/agree_to_the_personal_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/widgets/auth_text_field.dart';

class SignUpCredientals extends StatelessWidget {
  const SignUpCredientals({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthTextField(
          title: 'Name',
          hintText: 'Enter your name',
          onChanged: (String p1) {},
        ),

        16.verticalSpace,
        AuthTextField(
          title: 'Email',
          hintText: 'Enter your email',
          onChanged: (String p1) {},
        ),

        16.verticalSpace,

        AuthTextField(
          title: 'Password',
          hintText: 'Enter your password',
          isSecured: true,
          onChanged: (String p1) {},
        ),
        16.verticalSpace,

        AuthTextField(
          title: 'Confirm Password',
          hintText: 'Enter your password',
          isSecured: true,
          onChanged: (String p1) {},
        ),
        16.verticalSpace,
        AgreeToThePersonalData(),
      ],
    );
  }
}
