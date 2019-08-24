

class HttpExceptionModel implements Exception{
  String message;

  HttpExceptionModel(this.message);

  @override
  String toString(){
    return message;
    /*super.toString();*/
  }

}