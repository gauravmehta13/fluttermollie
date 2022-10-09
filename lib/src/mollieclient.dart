import 'package:mollie_flutter/internal/customerhandler.dart';
import 'package:mollie_flutter/internal/invoicehandler.dart';
import 'package:mollie_flutter/internal/orderhandler.dart';
import 'package:mollie_flutter/internal/paymenthandler.dart';
import 'package:mollie_flutter/internal/subscriptionhandler.dart';

class MollieClient {
  Map<String, String>? headers;

  late OrderHandler orders;
  late CustomerHandler customers;
  late SubscriptionHandler subscription;
  late PaymentHandler payments;
  late InvoiceHandler invoiceHandler;

  static final MollieClient _instance = MollieClient._internal();

  factory MollieClient() => _instance;

  MollieClient._internal();

  /// Sets the api key
  void init(String apiKey) {
    headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    orders = OrderHandler(headers);
    customers = CustomerHandler(headers);
    subscription = SubscriptionHandler(headers);
    payments = PaymentHandler(headers);
    invoiceHandler = InvoiceHandler(headers);
  }
}
