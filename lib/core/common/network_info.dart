abstract class DataState {
 
}

class DataSuccess extends DataState {
  final dynamic data;
  DataSuccess({required this.data});
}


class DataError extends DataState {
    final String error;
  DataError({required this.error});
}

