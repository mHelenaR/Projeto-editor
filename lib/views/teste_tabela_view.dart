import 'package:flutter/material.dart';

class TesteTabela extends StatefulWidget {
  const TesteTabela({super.key});

  @override
  State<TesteTabela> createState() => _TesteTabelaState();
}

class _TesteTabelaState extends State<TesteTabela>
    with TickerProviderStateMixin {
  TabController getTabController() {
    return TabController(length: 3, vsync: this);
  }

  late TabController tabController = getTabController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Flexible(
                child: AppBar(
                  title: TabBar(
                    controller: tabController,
                    tabs: const [
                      Tab(text: '1'),
                      Tab(text: '2'),
                      Tab(text: '3'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const <Widget>[
              Text('teste 1'),
              Text('teste 2'),
              Text('teste 3'),
            ],
          ),
        ),
      ],
    );
  }
}
