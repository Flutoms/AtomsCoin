import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Client httpClient;
  late Web3Client ethClient;
  bool data = false;
  final myAddress = '0xC20c2CaD10D60Beb3CF72677c114Ecb40cbfEb75';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(clipBehavior: Clip.none, children: [
      Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.all(20),
      ),
      Positioned(
        left: 25,
        top: 90,
        child: Column(
          children: [
            const Positioned(
              top: 90,
              left: 120,
              child: Text(
                '\$ATMCOIN',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 340,
              padding: EdgeInsets.symmetric(vertical: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, -2)),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Balance',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 15),
                  data == false
                      ? const Text(
                          '\$30000',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        )
                      : CircularProgressIndicator.adaptive()
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 310, left: 23, right: 23),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: const [
                  Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text('Refresh',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: const [
                  Icon(
                    Icons.call_made,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text('Deposit',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: const [
                  Icon(
                    Icons.call_received,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text('Withdraw',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      )
    ]));
  }
}
