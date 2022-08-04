import 'package:flutter/cupertino.dart';

double tamanho(BuildContext context) {
  double heightScreen = MediaQuery.of(context).size.height;
  double widthScreen = MediaQuery.of(context).size.width;
  double screen = 0;
  if ((heightScreen < 960) && (heightScreen > 760)) {
    return screen = MediaQuery.of(context).size.height * 0.75;
  } else if ((heightScreen > 961)) {
    return screen = MediaQuery.of(context).size.height * 0.8;
  } else if (heightScreen < 760) {
    return screen = MediaQuery.of(context).size.height * 0.7;
  } else {
    return screen = MediaQuery.of(context).size.height * 0.7;
  }
}
