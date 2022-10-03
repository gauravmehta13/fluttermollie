import 'package:mollie_flutter/internal/customerhandler.dart';
import 'package:mollie_flutter/internal/invoicehandler.dart';
import 'package:mollie_flutter/internal/orderhandler.dart';
import 'package:mollie_flutter/internal/paymenthandler.dart';
import 'package:mollie_flutter/internal/subscriptionhandler.dart';

class MollieClient {
  var headers;

  OrderHandler? orders;
  CustomerHandler? customers;
  SubscriptionHandler? subscription;
  PaymentHandler? payments;
  InvoiceHandler? invoiceHandler;

  static final MollieClient _instance = MollieClient._internal();

  factory MollieClient() => _instance;

  MollieClient._internal();

  /// Sets the api key
  void init(String apiKey) {
    headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + apiKey,
    };

    orders = OrderHandler(headers);
    customers = CustomerHandler(headers);
    subscription = SubscriptionHandler(headers);
    payments = PaymentHandler(headers);
    invoiceHandler = InvoiceHandler(headers);
  }
}
