class ResponseServices {
  int statusCode;
  dynamic data;
  ResponseServices({ required this.statusCode, this.data});
  String getResponseMessage(int statusCode) {
    switch (statusCode) {
      case 200:
        return "Success";
      case 400:
        return "Bad Request";
      case 401:
        return "Unauthorized";
      case 403:
        return "Forbidden";
      case 404:
        return "Not Found";
      case 500:
        return "Internal Server Error";
      default:
        return "Unknown Error";
    }
  }

}