import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mollie_flutter/src/molliepayment.dart';

/// TODO: https://stackoverflow.com/questions/52073350/php-mollie-payments-recurring-billing

class PaymentHandler {
  final String _apiEndpoint = "https://api.mollie.com/v2/payments";

  Map<String, String>? _headers;

  PaymentHandler(Map<String, String>? headers) {
    _headers = headers;
  }

  /// Payment creation is elemental to the Mollie API: this is where most payment implementations start off.
  /// Once you have created a payment, you should redirect your customer to the URL in the _links.checkout property from the response.
  /// To wrap your head around the payment process, an explanation and flow charts can be found in the Payments API Overview.
  Future<MolliePaymentResponse> create(MolliePaymentRequest payment) async {
    var res = await http.post(Uri.parse(_apiEndpoint), headers: _headers, body: payment.toJson());

    if (res.statusCode == 200 || res.statusCode == 201) {
      dynamic data = json.decode(res.body);
      return MolliePaymentResponse.build(data);
    } else {
      throw Exception("Error getting payment ${res.statusCode} ${res.body}");
    }
  }

  /// Retrieve a single payment object by its payment token.
  Future<MolliePaymentResponse> get(String paymentId) async {
    var res = await http.get(
      Uri.parse("$_apiEndpoint/$paymentId"),
      headers: _headers,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      dynamic data = json.decode(res.body);
      return MolliePaymentResponse.build(data);
    } else {
      throw Exception("Error getting payment ${res.statusCode} ${res.body}");
    }
  }

  /// Some payment methods are cancellable for an amount of time, usually until the next day. Or as long as the payment status is open.
  /// Payments may be canceled manually from the Dashboard, or automatically by using this endpoint.
  /// The isCancelable property on the Payment object will indicate if the payment can be canceled.
  Future<MolliePaymentResponse> cancel(String paymentId) async {
    var res = await http.delete(
      Uri.parse("$_apiEndpoint/$paymentId"),
      headers: _headers,
    );

    dynamic data = json.decode(res.body);

    return MolliePaymentResponse.build(data);
  }

  /// This endpoint can be used to update some details of a created payment.
  /// You can update weebhookUrl, redirectUrl, description and metadata
  Future<MolliePaymentResponse> update(String paymentId, Map map) async {
    var res = await http.patch(Uri.parse("$_apiEndpoint/$paymentId"), headers: _headers, body: json.encode(map));

    dynamic data = json.decode(res.body);

    return MolliePaymentResponse.build(data);
  }

  /// Retrieve all payments.
  /// TODO fix payments attributes changing depending on order or payment api
  Future<List<MolliePaymentResponse>> listPayments() async {
    var res = await http.get(
      Uri.parse(_apiEndpoint),
      headers: _headers,
    );

    List<MolliePaymentResponse> subs = [];

    dynamic data = json.decode(res.body);

    for (int i = 0; i < data["count"]; i++) {
      subs.add(MolliePaymentResponse.build(data["_embedded"]["payments"][i]));
    }

    return subs;
  }
}
