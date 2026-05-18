import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/networking/api_constant.dart';

class TokenRefreshInterceptor extends QueuedInterceptor {
  final Dio dio;

  TokenRefreshInterceptor({required this.dio});

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = CacheHelper().getData(key: ApiKey.refresh_token);

      if (refreshToken != null && refreshToken.toString().isNotEmpty) {
        try {
          final refreshDio = Dio();

          final String refreshUrl =
              '${Endpoints.baseUrl}${Endpoints.refreshToken}';

          debugPrint("Refreshing token using URL: $refreshUrl");

          final response = await refreshDio.post(
            refreshUrl,
            queryParameters: {'refresh_token': refreshToken.toString()},
          );

          if (response.statusCode == 200 && response.data != null) {
            final newAccessToken =
                response.data['access_token']?.toString() ?? '';

            final newRefreshToken =
                response.data['refresh_token']?.toString() ?? '';

            if (newAccessToken.isNotEmpty) {
              debugPrint("Token refreshed successfully!");

              await CacheHelper().saveData(
                key: ApiKey.access_token,
                value: newAccessToken,
              );

              if (newRefreshToken.isNotEmpty) {
                await CacheHelper().saveData(
                  key: ApiKey.refresh_token,
                  value: newRefreshToken,
                );
              }

              final requestOptions = err.requestOptions;

              requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';

              final filePath = requestOptions.extra['filePath'];

              if (filePath != null) {
                requestOptions.data = FormData.fromMap({
                  "file": await MultipartFile.fromFile(
                    filePath,
                    filename: "plant.jpg",
                  ),
                });
              }

              final clonedResponse = await dio.fetch(requestOptions);

              return handler.resolve(clonedResponse);
            }
          }
        } catch (e) {
          debugPrint("Token refresh call failed: $e");

          await _forceLogout();

          return handler.next(err);
        }
      } else {
        debugPrint("No refresh token found. Forcing logout...");

        await _forceLogout();
      }
    }

    return super.onError(err, handler);
  }

  Future<void> _forceLogout() async {
    await CacheHelper().removeData(key: ApiKey.access_token);

    await CacheHelper().removeData(key: ApiKey.refresh_token);

    await CacheHelper().removeData(key: ApiKey.email);

    await CacheHelper().removeData(key: ApiKey.name);
  }
}
