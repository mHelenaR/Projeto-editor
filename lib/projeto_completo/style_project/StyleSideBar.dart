// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:editorconfiguracao/projeto_completo/style_project/style_colors.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

final StyleSideBar = SidebarXTheme(
  decoration: const BoxDecoration(
    color: purpleF99,
  ),
  textStyle: coresTexto,
  selectedTextStyle: coresTexto,
  itemTextPadding: formtLeft30,
  selectedItemTextPadding: formtLeft30,
  itemDecoration: BoxDecoration(
    border: Border.all(color: purpleF99),
  ),
  selectedItemDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    border: Border.all(
      color: actionColor.withOpacity(0.37),
    ),
    gradient: const LinearGradient(
      colors: [accentCanvasColor, purpleF99],
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.28),
        blurRadius: 30,
      ),
    ],
  ),
  iconTheme: const IconThemeData(
    color: white,
    size: 20,
  ),
);

const StyleExpandeSideBar = SidebarXTheme(
  width: 200,
  decoration: BoxDecoration(
    color: purpleF99,
  ),
  margin: EdgeInsets.only(right: 10),
);
