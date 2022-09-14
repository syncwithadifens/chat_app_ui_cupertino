import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'users.dart';

const List<User> users = <User>[
  User('Rudi', Colors.greenAccent),
  User('Nana', Colors.green),
  User('Dino', Colors.black26),
  User('Asad', Colors.blue),
  User('Danang', Colors.amberAccent),
  User('Ali', Colors.purple),
  User('Adnan', Colors.pink),
  User('Ibnu', Colors.yellowAccent),
  User('Sambo', Colors.red),
  User('Puan', Colors.blueAccent),
  User('Owi', Colors.deepOrange),
  User('Bjiorka', Colors.cyan),
  User('Andyan', Colors.lightBlue),
  User('Bambang', Colors.deepPurpleAccent),
  User('Anang', Colors.indigoAccent),
];

class UserTile extends StatelessWidget {
  final User _product;

  const UserTile(this._product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: _product.backgroundColor,
            radius: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _product.name,
                style: const TextStyle(
                  color: CupertinoColors.black,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CupertinoChatPage extends StatefulWidget {
  const CupertinoChatPage({Key? key}) : super(key: key);

  @override
  CupertinoChatPageState createState() => CupertinoChatPageState();
}

class CupertinoChatPageState extends State<CupertinoChatPage> {
  List<User> _filteredUsers = users;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateUserList(String value) {
    debugPrint(value);

    if (value.isNotEmpty) {
      _filteredUsers = _filteredUsers
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      _controller.text = '';
      _filteredUsers = users;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: const Text('Chats'),
          leading: const Text(
            'Edit',
            style: TextStyle(color: CupertinoColors.link),
          ),
          middle: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CupertinoActivityIndicator(),
              SizedBox(width: 8),
              Text('Waiting for network')
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: ClipRect(
                child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CupertinoSearchTextField(
                controller: _controller,
                onChanged: (value) {
                  _updateUserList(value);
                },
                onSubmitted: (value) {
                  _updateUserList(value);
                },
                onSuffixTap: () {
                  _updateUserList('');
                },
              ),
            )),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 5,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return UserTile(_filteredUsers[index]);
            },
            childCount: _filteredUsers.length,
          ),
        ),
      ],
    );
  }
}
