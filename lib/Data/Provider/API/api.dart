import 'package:dio/dio.dart';

const baseUrl = 'https://api.pexels.com/v1/';

class ApiClient {
  static Dio dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      //connectTimeout: 5000,// 60 seconds
      receiveDataWhenStatusError: true,
      sendTimeout: Duration(milliseconds: 10000),
      //5s
      receiveTimeout: Duration(milliseconds: 60000),
      connectTimeout: Duration(milliseconds: 10000),
      headers: {
        "Authorization":
            "Rs83LUyKpnbTdGwiScHICXFIl8sbbNNeyfe2vQ6gqM5fobTTAqY2VYVn",
      },
      // 60 seconds
      validateStatus: (status) {
        return status! < 500;
      }));

  Future<Response?> get(
    String url, {
    dynamic param,
  }) async {
    try {
      print("token ${dio.options.headers.toString()}");
      Response response = await dio.get(url, queryParameters: param);
      return response;
    } on DioException catch (e) {
      print("error DIO");
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response!.statusCode == 500 || e.response!.statusCode == 404) {
          print(e.response!.data);
          print(e.response!.headers);
          print(e.response!.requestOptions);
        }
      } else {
        print(e.requestOptions);
        print(e.message);
        return Response(
            statusCode: e.response?.statusCode ?? 500,
            statusMessage: e.message,
            requestOptions: e.requestOptions);
      }
    }
    return null;
  }
}
