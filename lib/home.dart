import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_clone/customSearchDelegate.dart';
import 'dart:convert';
import 'dart:async';

import 'package:youtube_clone/telas/inicio.dart';
import 'package:youtube_clone/telas/emAlta.dart';
import 'package:youtube_clone/telas/inscricoes.dart';
import 'package:youtube_clone/telas/biblioteca.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentIndex = 0;
  String _searchResult = '';

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      Inicio(_searchResult),
      EmAlta(),
      Inscricoes(),
      Biblioteca()
    ];

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/img/youtube.png',
          width: 98,
          height: 22,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cast),
            onPressed: () => {},
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () => {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String res = await showSearch(context: context, delegate: CustomSearchDelegate());
              setState(() {
                _searchResult = res;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () => {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[this.currentIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this.currentIndex,
        onTap: (index) {
          setState(() {
            this.currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            title: Text('Início'),
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            title: Text('Em alta'),
            icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
            title: Text('Inscrições'),
            icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
            title: Text('Biblioteca'),
            icon: Icon(Icons.folder)
          ),
        ]
      ),
    );
  }
}