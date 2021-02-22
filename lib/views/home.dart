import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Razorpay razorpay;
  TextEditingController textEditingControllerAmount = new TextEditingController();
  TextEditingController textEditingControllerName = new TextEditingController();
  TextEditingController textEditingControllerEmail = new TextEditingController();
  TextEditingController textEditingControllerMobile = new TextEditingController();

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
  }

  void handlerErrorFailure(PaymentFailureResponse response){
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void handlerExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  void openCheckout() async{
    var options = {
      "key" : "rzp_test_dNAQDDhQO4ieb8",
      "amount" : num.parse(textEditingControllerAmount.text)*100,
      "name" : "Sample App",
      "currency": "INR",
      "description" : "Demo Payment",
      "prefill" : {
          "contact" : textEditingControllerMobile.text,
          "email" : textEditingControllerEmail.text
      },
      "external" : {
        "wallets" : ["paytm"]
      }
    };
    try{
      razorpay.open(options);
    }catch(e){
      debugPrint(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor Pay"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingControllerAmount,
              decoration: InputDecoration(
                hintText: "Enter amount"
              ),
            ),
            TextField(
              controller: textEditingControllerName,
              decoration: InputDecoration(
                  hintText: "Enter name"
              ),
            ),
            TextField(
              controller: textEditingControllerEmail,
              decoration: InputDecoration(
                  hintText: "Enter email"
              ),
            ),
            TextField(
              controller: textEditingControllerMobile,
              decoration: InputDecoration(
                  hintText: "Enter mobile"
              ),
            ),
            SizedBox(height: 12,),
            RaisedButton(
              onPressed:(){
                openCheckout();
              } ,
              color: Colors.blue,
              child: Text("Pay" , style: TextStyle(
                color: Colors.white
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
