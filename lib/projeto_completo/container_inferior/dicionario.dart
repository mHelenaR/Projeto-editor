import 'package:flutter/material.dart';

class TabelaDicionario extends StatefulWidget {
  const TabelaDicionario({Key? key}) : super(key: key);

  @override
  State<TabelaDicionario> createState() => _TabelaDicionarioState();
}

class _TabelaDicionarioState extends State<TabelaDicionario> {
  @override
  Widget build(BuildContext context) {
    return const ContainerDicionario();
  }
}

class ContainerDicionario extends StatelessWidget {
  const ContainerDicionario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.black,
    );
  }
}
