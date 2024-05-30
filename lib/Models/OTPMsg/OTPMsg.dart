class OTPMsg {
  String? send;
  String? message;
  int? id;
  String? exception;
  int? statuscode;
  String? error;
  OTPMsg(
      {required this.message,
      required this.send,
      required this.id,
      required this.statuscode,
      required this.exception,
      this.error
      });
  factory OTPMsg.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["sent"] == "true") {
      return OTPMsg(
          message: jsons["message"],
          send: jsons["sent"],
          id: jsons["id"],
          statuscode: stcode,
          exception: null,
          error: jsons["error"],);
    } else {
      return OTPMsg(
          send: null,
          message: null,
          id: null,
          statuscode: stcode,
          exception: "Something Went Wrong",
            error: jsons["error"],);
    }
  }
  factory OTPMsg.exception(String jsons, int stcode) {
    return OTPMsg(
        message: null,
        statuscode: stcode,
        send: null,
        exception: jsons,
        id: null,
          error: null);
  }

  factory OTPMsg.error(String jsons) {
    return OTPMsg(
        message: null,
        statuscode: null,
        send: null,
        exception: null,
        id: null,
        error: jsons,
        );
  }
}
