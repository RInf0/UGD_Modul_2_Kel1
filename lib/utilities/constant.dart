import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

const cThemeColor = Color.fromARGB(255, 228, 105, 132);

const cAccentColor = Color(0xff0D8F83);

Image imageLogoAtmaHospital({double height = 50}) {
  return Image.asset(
    'image/logo/logo-atma-hospital.png',
    height: height.sp,
  );
}

Row textTitleAtmaHospital({double fontSize = 20}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'ATMA',
        style: TextStyle(
          fontSize: fontSize.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        'HOSPITAL',
        style: TextStyle(
          fontSize: fontSize.sp,
          fontWeight: FontWeight.w300,
          color: cAccentColor,
        ),
      )
    ],
  );
}

Text textSloganAtmaHospital({double fontSize = 15}) {
  return Text(
    'BETTER HEALTH, BETTER LIFE',
    style: TextStyle(
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w300,
    ),
  );
}

const SizedBox cSizedBox2 = SizedBox(
  height: 20,
);

const SizedBox cSizedBox = SizedBox(
  height: 20,
  width: 350,
  child: Divider(
    color: Colors.teal,
    thickness: 1.5,
  ),
);

const cTextStyle1 = TextStyle(
  // fontFamily: 'Anton',
  fontSize: 30,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.5,
);

const cTextStyle2 = TextStyle(
  // fontFamily: 'Source Sans Pro',
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const cTextStyle3 = TextStyle(
  // fontFamily: 'Source Sans Pro',
  fontSize: 18,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.6,
);

const cTextStyle4 = TextStyle(
  // fontFamily: 'Pacifico',
  fontSize: 40,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const cTextStyle5 = TextStyle(
  // fontFamily: 'Source Sans Pro',
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  letterSpacing: 2.5,
);
