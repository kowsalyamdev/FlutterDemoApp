import 'dart:convert';
import '../models/user.dart';
import '../util/Constants.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';

class UserService {
  final Dio _dio;

  UserService([Dio? dio]) : _dio = dio ?? Dio();

  Future<List<User>> getUserList() async {
    final response = await ApiClient.instance.request(
      Constants.SUFFIX,
      DioMethod.get,
      contentType: 'application/json',
    );
    if (response.statusCode == 200) {
      print('API call successful');
      List<User> list = UserFromJson(jsonEncode(response.data));
      return list;
    } else {
      print('API call failed: ${response.statusMessage}');
      throw Exception('Network error occurred:');
    }
  }

  Future<List<Map<String, dynamic>>> fetchUserList(Dio dio) async {
    final response = await dio.get('/users');
    return List<Map<String, dynamic>>.from(response.data);
  }
}
