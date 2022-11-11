// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';

double tamanho(BuildContext context) {
  double heightScreen = MediaQuery.of(context).size.height;
  double widthScreen = MediaQuery.of(context).size.width;
  double screen = 0;

  if ((heightScreen < 780) && (heightScreen > 760)) {
    return screen = MediaQuery.of(context).size.height * 0.78;
  } else if ((heightScreen > 780) && (heightScreen < 900)) {
    return screen = MediaQuery.of(context).size.height * 0.8;
  } else if ((heightScreen > 900) && (heightScreen < 950)) {
    return screen = MediaQuery.of(context).size.height * 0.8;
  } else if ((heightScreen < 780)) {
    return screen = MediaQuery.of(context).size.height * 0.75;
  } else if ((heightScreen < 700)) {
    return screen = MediaQuery.of(context).size.height * 0.7;
  } else {
    return screen = MediaQuery.of(context).size.height * 0.83;
  }
}
