import 'package:aidmanager_mobile/shared/helpers/storage_helper.dart';
import 'package:dio/dio.dart';
import 'package:aidmanager_mobile/config/constants/environment.dart';

class HttpService {
  final Dio dio;
  static String? _token;

  HttpService()
      : dio = Dio(
          BaseOptions(
            baseUrl: Environment.baseUrl,
          ),
        ) {
    print('HttpService initialized');
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // verificamos si el token está en memoria
        // si no está en memoria, cargar el token desde el almacenamiento seguro
        // ignore: prefer_conditional_assignment
        if (_token == null) _token = await StorageHelper.getToken();

        // si el token está disponible lo agregamos a los encabezados de la solicitud
        if (_token != null) {
          options.headers['Authorization'] = 'Bearer $_token';
        }

        options.headers['Content-Type'] = 'application/json';
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // Save the token if it's present in the response headers
        if (response.headers['Authorization'] != null) {
          _token = response.headers['Authorization']!.first;
          await StorageHelper.saveToken(_token!);
        }
        return handler.next(response);
      },
    ));
  }
}
