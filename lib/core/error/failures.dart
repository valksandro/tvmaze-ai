abstract class Failure {
  String getMessage();
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({this.message = ''});
  @override
  String getMessage() => message;
}

