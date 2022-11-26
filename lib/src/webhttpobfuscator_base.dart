// TODO: Put public facing types in this file.

import 'package:dio/dio.dart';

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}

class HttpObfuscatorClient with DioMixin {

  @override
  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {



    return Response(requestOptions: RequestOptions(path: path));
  }
}