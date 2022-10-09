import 'package:flutter/material.dart';
import 'package:mollie_flutter/mollie.dart';

enum PaymentOptions {
  paypal(name: "PayPal", icon: "assets/icons/paypal.png", method: "paypal"),
  creditcard(name: "Credit Card", icon: "assets/icons/credit_card.png", method: "creditcard"),
  giropay(name: "Giropay", icon: "assets/icons/giropay.png", method: "giropay"),
  ideal(name: "iDEAL", icon: "assets/icons/ideal.png", method: "ideal"),
  bancontact(name: "Bancontact", icon: "assets/icons/bancontact.png", method: "bancontact"),
  kbc(name: "KBC", icon: "assets/icons/kbc.png", method: "kbc"),
  belfius(name: "Belfius", icon: "assets/icons/belfius_pay.png", method: "belfius"),
  sofort(name: "SOFORT", icon: "assets/icons/sofort.png", method: "sofort"),
  sepa(name: "SEPA", icon: "assets/icons/sepa.png", method: "banktransfer"),
  applepay(name: "Apple Pay", icon: "assets/icons/applepay.png", method: "applepay");

  final String? name;
  final String? icon;
  final String? method;

  const PaymentOptions({this.name, this.icon, this.method});
}

class MollieCheckoutOptions extends StatefulWidget {
  final CheckoutStyle? style;
  final MollieOrderRequest order;
  final List<PaymentOptions> paymentOptions;
  final void Function(MollieOrderRequest)? onMethodSelected;

  const MollieCheckoutOptions(
      {super.key,
      required this.order,
      this.style,
      this.onMethodSelected,
      this.paymentOptions = const [
        PaymentOptions.paypal,
        PaymentOptions.creditcard,
        PaymentOptions.giropay,
        PaymentOptions.ideal,
        PaymentOptions.bancontact,
        PaymentOptions.kbc,
        PaymentOptions.belfius,
        PaymentOptions.sofort,
      ]});

  @override
  State<MollieCheckoutOptions> createState() => _MollieCheckoutOptionsState();
}

class _MollieCheckoutOptionsState extends State<MollieCheckoutOptions> {
  List<Widget> paymentMethods = [];
  CheckoutStyle? style;

  void _setMethod(String? method) {
    widget.order.method = method;
    widget.onMethodSelected?.call(widget.order);
  }

  void _buildPaymentMethods() {
    style = widget.style ??
        CheckoutStyle(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text("Checkout"),
            ),
            buttonColor: Colors.black,
            textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));

    for (int i = 0; i < widget.paymentOptions.length; i++) {
      PaymentOptions m = widget.paymentOptions[i];

      paymentMethods.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
            dense: true,
            tileColor: style?.buttonColor,
            leading: m.icon != null
                ? Image.asset(
                    m.icon!,
                    package: 'mollie_flutter',
                    width: 30,
                    height: 30,
                  )
                : null,
            title: Text(m.name!, style: style?.textStyle),
            onTap: () {
              _setMethod(m.method);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.grey[300]!),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: Colors.black,
            )),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _buildPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: paymentMethods,
    );

    //if (widget.style != null && widget.style.appBar != null) {
    //  return Scaffold(
    //      appBar: widget.style.appBar,
    //      body: SingleChildScrollView(
    //        child: Column(
    //          children: <Widget>[
    //            Container(
    //                margin: const EdgeInsets.only(bottom: 40, top: 40),
    //                child: Text("Select a payment method.")),
    //            Container(
    //                child: Column(
    //              children: paymentMethods,
    //            ))
    //          ],
    //        ),
    //      ));
    //}
//
    //return SingleChildScrollView(
    //  child: Column(
    //    children: <Widget>[
    //      Container(
    //          margin: const EdgeInsets.only(bottom: 40, top: 40),
    //          child: Text("Select a payment method.")),
    //      Container(
    //          child: Column(
    //        children: paymentMethods,
    //      ))
    //    ],
    //  ),
    //);
  }
}
