import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../../modules/shared/data/models/network_exception.dart';

class DioProvider extends Provider<Dio> {
  DioProvider({super.key})
      : super(
          create: (context) {
            final options = BaseOptions(
              baseUrl: 'https://api.github.com',
              contentType: 'application/json',
              connectTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 3),
            );

            final dio = Dio(options);

            dio.interceptors.addAll(
              [
                InterceptorsWrapper(
                  onError: (exception, handler) {
                    handler
                        .next(NetworkException(originalException: exception));
                  },
                ),
                LogInterceptor(),
              ],
            );

            return dio;
          },
        );
}
