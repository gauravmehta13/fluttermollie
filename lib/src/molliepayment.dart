import 'dart:convert';
import 'dart:developer';

import 'package:mollie_flutter/src/mollieamount.dart';
import 'package:mollie_flutter/src/molliedetails.dart';

class MolliePaymentRequest {
  MollieAmount? amount;
  String? description;
  String? webhookUrl;
  String? redirectUrl;
  String? method;
  dynamic metaData;

  MolliePaymentRequest({this.amount, this.redirectUrl, this.description, this.webhookUrl, this.method, this.metaData});

  String toJson() {
    return json.encode({
      "amount": amount!.toMap(),
      "redirectUrl": redirectUrl,
      "metadata": json.encode(metaData),
      "description": description,
      "webhookUrl": webhookUrl,
      "method": method
    });
  }
}

class MolliePaymentResponse {
  String? id;
  String? mode;
  String? createdAt;
  String? status;
  MollieAmount? amount;
  bool? isCancelable;
  String? sequenceType;
  MollieDetails? details;
  String? profileId;
  String? description;
  String? method;
  dynamic metaData;
  String? webhookUrl;
  String? customerUrl;
  String? redirectUrl;
  String? checkoutUrl;
  String? documentationUrl;
  String? selfUrl;

  MolliePaymentResponse.build(dynamic data) {
    log(data.toString());
    id = data["id"];
    mode = data["mode"];
    isCancelable = data["isCancelable"];
    createdAt = data["createdAt"];
    status = data["status"];
    amount = MollieAmount(value: data["amount"]["value"], currency: data["amount"]["currency"]);
    details = MollieDetails.fromMap(data["details"] ?? {});
    sequenceType = data["sequenceType"];
    metaData = data["metaData"];
    description = data["description"];
    redirectUrl = data["redirectUrl"];
    method = data["method"];
    webhookUrl = data["weebhookUrl"];

    if (data["_links"].containsKey("checkout")) checkoutUrl = data["_links"]["checkout"]["href"];

    if (data["_links"].containsKey("documentation")) documentationUrl = data["_links"]["documentation"]["href"];

    selfUrl = data["_links"]["self"]["href"];
  }
}
