import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/services/app_exceptions.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(State initialState) : super(initialState);

  /// HANDLE ERROR EXCEPTION
  /// [BadRequestException] will throw when bad request
  /// [FetchDataException]  will throw when occurred exception during fetching data
  /// [ApiNotRespondingException] Server not responding or sending timeout
  /// [NotFoundException] will throw when URL not found
  ///error = {NoSuchMethodError} NoSuchMethodError: Class 'Response<dynamic>' has no instance getter 'bodyBytes'.\nReceiver: Instance of 'Response<dynamic>'\nTried… View
  String handleError(error) {
    if (error is BadRequestException) {
      return error.message.toString();
    } else if (error is FetchDataException) {
      return error.message.toString();
    } else if (error is ApiNotRespondingException) {
      return error.message.toString();
    } else if (error is NotFoundException) {
      return error.message.toString();
    } else if (error is ResponseException) {
      return error.message.toString();
    } else {
      return 'Unknown Exception';
    }
  }
}
