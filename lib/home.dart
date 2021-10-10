import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool data = false;
  final myAddress = '0xC20c2CaD10D60Beb3CF72677c114Ecb40cbfEb75';
  final endPoint = 'https://rinkeby.infura.io/v3/d6c9f8e894fb4ac39c363072d50bcd15';
  final contractAddress = '0x9BEd6d009c4F3e874fb69184eB6AA47fe6B76a2d';
  late var myData;

  final moneyValue = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(endPoint, httpClient);
    getBalance(myAddress);
  }

  Future<DeployedContract> loadContract() async{
    String abi = await rootBundle.loadString("assets/abi.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, 'AtomsCoin'), EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async{
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<void> getBalance(String targetAddress) async{
   // EthereumAddress ethereumAddress = EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query('getBalance', []);
    myData = result[0];
    data = true;
    setState(() {

    });
  }

  // Future<String> depositCoin()async{
  //   var bigAmount = BigInt.from(int.parse(moneyValue.text));
  //   var response = await submit('depositBalance ', [bigAmount]);
  //   print(response);
  //   return response;
  // }
  //
  // Future<String>  withdrawCoin()async{
  //   var bigAmount = BigInt.from(int.parse(moneyValue.text));
  //   var response = await submit('withdrawBalance', [bigAmount]);
  //   print(response);
  //   return response;
  // }

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
                '\$ATOMCOIN',
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
                  data ?  Text( '\$$myData', style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        ) : CircularProgressIndicator.adaptive()
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
            InkWell(
              onTap: ()=> getBalance(myAddress),
              child: Container(
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
            ),
            InkWell(
              onTap: () => depositCoin(),
              child: Container(
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
            ),
            InkWell(
              onTap: ()=> withdrawCoin(),
              child: Container(
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
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 400, left: 50, right: 50),
        child: TextFormField(
          controller: moneyValue,
          keyboardType: TextInputType.number,
        ),
      )
    ]));
  }
}
