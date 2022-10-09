import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mollie_flutter/src/mollieinvoice.dart';

class InvoiceHandler {
  final String _apiEndpoint = "https://api.mollie.com/v2/invoices";
  Map<String, String>? _headers;

  InvoiceHandler(Map<String, String>? headers) {
    _headers = headers;
  }

  /// Retrieve details of an invoice, using the invoice’s identifier.
  /// If you want to retrieve the details of an invoice by its invoice number, use the list endpoint with the reference parameter.
  Future<MollieInvoiceResponse?> getInvoice(String id) async {
    var res = await http.get(Uri.parse("$_apiEndpoint/$id"), headers: _headers);

    if (res.statusCode == 200) {
      return MollieInvoiceResponse.build(json.decode(res.body));
    } else {
      throw Exception("Error getting invoice ${res.statusCode} ${res.body}");
    }
  }

  /// Retrieve all invoices on the account. Optionally filter on year or invoice number.
  Future<List<MollieInvoiceResponse>> getInvoices(String reference, String year, String from, String limit) async {
    var res = await http.get(Uri.parse("$_apiEndpoint/invoices"), headers: _headers);

    if (res.statusCode == 200) {
      List<MollieInvoiceResponse> list = [];
      var data = json.decode(res.body);
      for (int i = 0; i < data["_embedded"]["invoices"].lenght; i++) {
        var node = data["_embedded"]["invoices"][i];
        list.add(MollieInvoiceResponse.build(node));
      }
      return list;
    } else {
      throw Exception("Error getting invoices ${res.statusCode} ${res.body}");
    }
  }
}
