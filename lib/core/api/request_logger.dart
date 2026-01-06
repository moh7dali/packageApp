import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/app_log.dart';

class APILogger {
  final http.Request? request;
  final http.Response? response;
  final String apiTAG;

  APILogger(this.apiTAG, {this.request, this.response}) {
    if (request != null) {
      appLog(request!.url, tag: "Request - Url {{ $apiTAG  }}");
      appLog(json.encode(request!.headers), tag: "Request - Headers {{ $apiTAG  }}");
      appLog(json.encode(request!.url.queryParameters), tag: "Request - params {{ $apiTAG  }}");
      appLog(json.encode(request!.body), tag: "Request - Body {{ $apiTAG  }}");
    }
    if (response != null) {
      appLog(json.encode(response!.statusCode), tag: "Response - StatusCode {{ $apiTAG  }}");
      appLog(response!.body, tag: "Response - body {{ $apiTAG  }}");
    }
  }
}
