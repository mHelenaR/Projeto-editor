import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

final StyleSideBar = SidebarXTheme(
  decoration: const BoxDecoration(
    color: canvaCores,
  ),
  textStyle: coresTexto,
  selectedTextStyle: coresTexto,
  itemTextPadding: formtLeft30,
  selectedItemTextPadding: formtLeft30,
  itemDecoration: BoxDecoration(
    border: Border.all(color: canvaCores),
  ),
  selectedItemDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    border: Border.all(
      color: actionColor.withOpacity(0.37),
    ),
    gradient: const LinearGradient(
      colors: [accentCanvasColor, canvaCores],
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
    color: canvaCores,
  ),
  margin: EdgeInsets.only(right: 10),
);
