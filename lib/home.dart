
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Client httpClient;
  late Web3Client ethClient;
  final myAddress = '0xC20c2CaD10D60Beb3CF72677c114Ecb40cbfEb75';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
