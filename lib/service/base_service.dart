import 'dart:convert';

import 'package:akbank_stock/constant/service.dart';
import 'package:http/http.dart';

class BaseService {
  makeGetRequest({String endpoint}) async {
    return get(serviceUrl + endpoint, headers: {'Authorization': 'R29vZCBMdWNr'}).then((value) => jsonDecode(value.body));
  }
}
