
import 'dart:convert';

import 'package:DemoApp/models/user.dart';

import 'APIService.dart';

class UserService{
   Future<List<User>> getUserList() async {

       final response = await APIService.instance.request(
         '/templates/-xdNcNKYtTFG/data',
         DioMethod.get,
         contentType: 'application/json',
       );
       if (response.statusCode == 200) {
         print('API call successful: ${response.data}');
         List<User> list = UserFromJson(jsonEncode(response.data));
         return list;
       } else {
         print('API call failed: ${response.statusMessage}');
          throw Exception('Network error occurred:');
     }
   }

}