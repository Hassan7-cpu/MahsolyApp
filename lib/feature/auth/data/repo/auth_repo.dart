import 'package:dio/dio.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/networking/dio_client.dart';
import 'package:save_plant/feature/auth/data/models/user_model.dart';

class AuthRepo {
Future<dynamic>signIn(String email, String password) async {
final response=await   DioClient(dio: Dio()).post(
  Endpoints.signIn,
  data: {
    ApiKey.email: email,
    ApiKey.password: password,
  },
);

}


Future<dynamic>signUp(String name,String email, String password,String phone) async {
final response=await   DioClient(dio: Dio()).post(    
  Endpoints.signUp,
  data: {
    ApiKey.name:name,
    ApiKey.email: email,
    ApiKey.password: password,
    ApiKey.phone: phone,
  },
);
}




}