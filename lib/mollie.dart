library molli;

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mollie_flutter/src/mollieclient.dart';
import 'package:mollie_flutter/src/mollieorder.dart';

export 'package:mollie_flutter/src/mollie_checkout_options.dart';
export 'package:mollie_flutter/src/mollieaddress.dart';
export 'package:mollie_flutter/src/mollieamount.dart';
export 'package:mollie_flutter/src/molliecheckout.dart';
export 'package:mollie_flutter/src/molliecustomer.dart';
export 'package:mollie_flutter/src/mollieinvoice.dart';
export 'package:mollie_flutter/src/mollieinvoiceline.dart';
export 'package:mollie_flutter/src/mollieorder.dart';
export 'package:mollie_flutter/src/mollieorderline.dart';
export 'package:mollie_flutter/src/mollieorderstatus.dart';
export 'package:mollie_flutter/src/molliepayment.dart';
export 'package:mollie_flutter/src/mollieproduct.dart';
export 'package:mollie_flutter/src/mollieshipment.dart';
export 'package:mollie_flutter/src/molliesubscription.dart';

MollieClient client = new MollieClient();

class Mollie {
  static const MethodChannel _channel = const MethodChannel('mollie');

  /// Opens the browser to process the payment. Returns after payment is done.
  static Future<void> startPayment(String checkoutUrl) async {
    return await _channel.invokeMethod('startPayment', {"checkoutUrl": checkoutUrl});
  }

  static MollieOrderResponse? _currentOrder;

  static MollieOrderResponse? getCurrentOrder() => _currentOrder;

  static MollieOrderResponse setCurrentOrder(MollieOrderResponse order) => _currentOrder = order;
}
