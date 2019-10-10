import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:study/core/model/word.dart';
import 'package:study/core/services/firebase_service.dart';

import 'add_word.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final service = FirebaseService.getInstance();
  List<Word> _list = [];
  UnmodifiableListView<Word> get items => UnmodifiableListView(_list);
  AnimationController controller;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getServiceList();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
  }

  Future<void> getServiceList() async {
    _list = await service.getWordList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: showBottomDialog),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _card(items[index], index);
                },
              ),
      ),
    );
  }

  Future<void> navigateAddPage() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WordAddView(),
        settings: RouteSettings(arguments: items.length)));

    await getServiceList();
  }

  void showBottomDialog() {
    showModalBottomSheet(
        builder: (context) => Container(
              height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    onTap: () async {
                      Navigator.of(this.context).pop();
                      await navigateAddPage();
                    },
                    title: Text("Kelime ekle"),
                    leading: Icon(Icons.send),
                  )
                ],
              ),
            ),
        context: context);
  }

  Widget get _appBar => AppBar(
        title: Text("Flutter Turkiye"),
        actions: <Widget>[
          IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.arrow_menu,
              progress: controller,
            ),
            onPressed: () {
              if (controller.value == 1) {
                controller.reverse();
              } else {
                controller.forward();
              }
            },
          )
        ],
      );

  // Widget get _bottomAppBar => BottomAppBar(
  //       shape: CircularNotchedRectangle(),
  //       child: TabBar(
  //         tabs: <Widget>[
  //           Tab(
  //             child: Icon(Icons.ac_unit),
  //           ),
  //           Tab(
  //             text: "s",
  //           ),
  //         ],
  //       ),
  //     );

  Widget _card(Word item, int index) {
    return Dismissible(
      key: Key("$index"),
      secondaryBackground: Container(
        width: 100,
        child: Icon(Icons.radio),
      ),
      onDismissed: (direction) async {
        await removeData(item.key,index);
      },
      dragStartBehavior: DragStartBehavior.down,
      background: Container(
        color: Colors.red,
      ),
      child: Card(
        elevation: 10,
        borderOnForeground: false,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        child: ListTile(
          title: Text(item.name),
          subtitle: Text("$index"),
          trailing: Image.network(item.image),
        ),
      ),
    );
  }

  Future<void> removeData(String key,int index) async {
    await service.removeWord(key: key);
    _list.removeAt(index);
  }
}
