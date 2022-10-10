import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mollie_flutter/mollie.dart';

void main() => runApp(MaterialApp(initialRoute: "home", routes: {
      "home": (context) => MyApp(),
      "done": (context) => ShowOrderStatus()
    }));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<MolliePaymentResponse> payments;

  @override
  void initState() {
    super.initState();
    //only client example
    client.init('test_HbkjP7PuCPwdveGWG2UffGTdkmd8re');
  }

  MollieOrderRequest o = new MollieOrderRequest(
      amount: MollieAmount(value: "1396.00", currency: "EUR"),
      orderNumber: "901",
      redirectUrl: "molli://payment-return",
      locale: "de_DE",
      webhookUrl: 'http://blackboxshisha.herokuapp.com/mollie/order/status',
      billingAddress: new MollieAddress(
        organizationName: 'Mollie B.V.',
        streetAndNumber: 'Keizersgracht 313',
        city: 'Amsterdam',
        region: 'Noord-Holland',
        postalCode: '1234AB',
        country: 'DE',
        title: 'Dhr.',
        givenName: 'Piet',
        familyName: 'Mondriaan',
        email: 'piet@mondriaan.com',
        phone: '+31309202070',
      ),
      shippingAddress: new MollieAddress(
        organizationName: 'Mollie B.V.',
        streetAndNumber: 'Keizersgracht 313',
        city: 'Amsterdam',
        region: 'Noord-Holland',
        postalCode: '1234AB',
        country: 'DE',
        title: 'Dhr.',
        givenName: 'Piet',
        familyName: 'Mondriaan',
        email: 'piet@mondriaan.com',
        phone: '+31309202070',
      ),
      products: [
        MollieProductRequest(
          type: 'physical',
          sku: '5702016116977',
          name: 'LEGO 42083 Bugatti Chiron',
          productUrl: 'https://shop.lego.com/nl-NL/Bugatti-Chiron-42083',
          imageUrl:
              'https://sh-s7-live-s.legocdn.com/is/image//LEGO/42083_alt1?',
          quantity: 2,
          vatRate: '21.00',
          unitPrice: MollieAmount(
            currency: 'EUR',
            value: '399.00',
          ),
          totalAmount: MollieAmount(
            currency: 'EUR',
            value: '698.00',
          ),
          discountAmount: MollieAmount(
            currency: 'EUR',
            value: '100.00',
          ),
          vatAmount: MollieAmount(
            currency: 'EUR',
            value: '121.14',
          ),
        ),
        MollieProductRequest(
          type: 'physical',
          sku: '5702016116977',
          name: 'LEGO 42083 Bugatti Chiron',
          productUrl: 'https://shop.lego.com/nl-NL/Bugatti-Chiron-42083',
          imageUrl:
              'https://sh-s7-live-s.legocdn.com/is/image//LEGO/42083_alt1?',
          quantity: 2,
          vatRate: '21.00',
          unitPrice: MollieAmount(
            currency: 'EUR',
            value: '399.00',
          ),
          totalAmount: MollieAmount(
            currency: 'EUR',
            value: '698.00',
          ),
          discountAmount: MollieAmount(
            currency: 'EUR',
            value: '100.00',
          ),
          vatAmount: MollieAmount(
            currency: 'EUR',
            value: '121.14',
          ),
        )
      ]);

  Future<void> createOrder(MollieOrderRequest order) async {
    //Test
    MollieSubscriptionRequest s = new MollieSubscriptionRequest(
      amount: MollieAmount(
        currency: 'EUR',
        value: '25.00',
      ),
      times: 4,
      interval: '3 months',
      description: 'Quarterly payment',
      webhookUrl: 'https://webshop.example.org/subscriptions/webhook/',
    );

    MolliePaymentRequest r = new MolliePaymentRequest(
      amount: MollieAmount(
        currency: 'EUR',
        value: '30.00',
      ),
      description: 'My first payment',
      redirectUrl: 'https://webshop.example.org/order/12345/',
      webhookUrl: 'https://webshop.example.org/payments/webhook/',
    );

    // client-server example
    // var orderResponse = await http.post(
    //   Uri.parse(
    //     "http://blackboxshisha.herokuapp.com/mollie/create/order",
    //   ),
    //   headers: {"Content-Type": "application/json"},
    //   body: order.toJson(),
    // );
    // var data = jsonDecode(orderResponse.body);
    // print("RECEIVED DATA FROM BACKEND");
    // print(data);
    // if (data["name"] != "ApiError") {
    //   MollieOrderResponse res = MollieOrderResponse.build(data);
    //   log(res.checkoutUrl);
    //   Mollie.setCurrentOrder(res);
    //   Mollie.startPayment(res.checkoutUrl);
    // } else {
    //   print("FAILED RESPONSE: ${data["title"]}");
    // }

    //only client example

    client.init("test_HbkjP7PuCPwdveGWG2UffGTdkmd8re");

    var createdOrder = await client.orders.create(order);
    log(createdOrder.checkoutUrl);
    Mollie.setCurrentOrder(createdOrder);
    Mollie.startPayment(createdOrder.checkoutUrl);
  }

  @override
  Widget build(BuildContext context) {
    return MollieCheckout(
      order: o,
      onMethodSelected: (order) {
        createOrder(order);
      },
      useCredit: true,
      usePaypal: true,
      useApplePay: true,
      useSofort: true,
      useSepa: true,
      useIdeal: true,
      child: MollieCheckoutOptions(
        order: o,
        style: CheckoutStyle(
          buttonColor: Colors.white,
        ),
        onMethodSelected: (order) {
          createOrder(order);
        },
      ),
    );
  }

  void listPayments() async {
    payments = await client.payments.listPayments();
    setState(() {});
  }
}

class ShowOrderStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MollieOrderStatus(
      orders: [Mollie.getCurrentOrder()],
      onSelectOrder: (order) {
        client.orders.get(order.id).then((value) {
          log(value.status);
        });
      },
    );
  }
}
