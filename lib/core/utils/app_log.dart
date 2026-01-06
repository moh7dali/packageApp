import 'dart:developer';

appLog(dynamic message, {String tag = "Jarwan", bool isError = false, dynamic trace}) {
  if (isError) {
    String stars = "***************************************";
    log(stars, name: tag, error: "$message\n $trace ");
    log(stars, name: tag);
  } else {
    print("[$tag] $message");
    // log("$message", name: tag);
  }
}
