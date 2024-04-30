
class LocaleDioExceptions {
  static String getLocaleMessage(int code) {
    switch (code) {
      case 1001:
        return "The request to the server has been cancelled";
      case 1002:
        return "The connection to the server timed out";
      case 1003:
        return "Receive timeout regarding server";
      case 1004:
        return "bad request";
      case 1005:
        return "Unauthorized";
      case 1006:
        return "ممنوع";
      case 1008:
        return "Internal Server Error";
      case 1009:
        return "Wrong entry";
      case 1010:
        return "Something went wrong";
      case 1011:
        return "The API server timed out";
      case 1012:
        return "Offline";
      case 1013:
        return "An unexpected error occurred";
      case 1014:
        return "There's something wrong";
      case 1015:
        return "Unknown error";
      default:
        return "Unknown error";
    }
  }
}