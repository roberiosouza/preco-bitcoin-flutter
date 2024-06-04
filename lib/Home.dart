import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _preco = 0;
  Future<Map> _consultarBitcoin() async {
    var url = Uri.parse("https://blockchain.info/ticker");
    http.Response respose = await http.get(url);
    return json.decode(respose.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: Image.asset("images/bitcoin.png"),
          ),
          FutureBuilder(
              future: _consultarBitcoin(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case (ConnectionState.none):
                  case (ConnectionState.active):
                  case (ConnectionState.waiting):
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case (ConnectionState.done):
                    _preco = snapshot.data!["BRL"]["buy"];
                }
                return Text(
                  "R\$ ${_preco.toString()}",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                );
              }),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _consultarBitcoin();
                });
              },
              child: Text(
                "Consultar",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.orange)),
            ),
          )
        ],
      ),
    );
  }
}
