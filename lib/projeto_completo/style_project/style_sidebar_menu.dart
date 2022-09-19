import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';

final temaMenu = SidebarXTheme(
  decoration: const BoxDecoration(
    color: purpleF99,
  ),
  textStyle: coresTexto,
  selectedTextStyle: coresTexto,
  itemTextPadding: formatLeft30,
  selectedItemTextPadding: formatLeft30,
  itemDecoration: BoxDecoration(
    border: Border.all(color: purpleF99),
  ),
  selectedItemDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    border: Border.all(
      color: itemMenuOpacity,
    ),
    gradient: const LinearGradient(
      colors: [itemMenuCor1, purpleF99],
    ),
    boxShadow: [
      BoxShadow(
        color: black.withOpacity(0.28),
        blurRadius: 30,
      ),
    ],
  ),
  iconTheme: const IconThemeData(
    color: white,
    size: 20,
  ),
);

const backgroundMenu = SidebarXTheme(
  width: 200,
  decoration: BoxDecoration(
    color: purpleF99,
  ),
  margin: formatRight10,
);
