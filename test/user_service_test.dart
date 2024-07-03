import 'package:DemoApp/config/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('UserService', () {
    late MockDio mockDio;
    late UserService userService;

    setUp(() {
      mockDio = MockDio();
      userService = UserService(mockDio);
    });

    test('should return a list of users when the API call is successful',
        () async {
      // Arrange
      final expectedUserList = [
        {
          'id': '1',
          'lastName': 'Doe',
          'firstName': 'John',
          'email': 'john.doe@example.com',
          'picture': 'https://example.com/profile.jpg',
          'latitude': 40.730610,
          'longitude': -73.935242,
        },
        {
          'id': '2',
          'lastName': 'Smith',
          'firstName': 'Jane',
          'email': 'jane.smith@example.com',
          'picture': 'https://example.com/profile2.jpg',
          'latitude': 37.7749,
          'longitude': -122.4194,
        },
        {
          'id': '2',
          'lastName': 'Smith1',
          'firstName': 'Jane1',
          'email': 'jane.smith@example.com',
          'picture': 'https://example.com/profile2.jpg',
          'latitude': 37.7749,
          'longitude': -122.4194,
        },
      ];

      when(mockDio.get('/users')).thenAnswer((_) async => Response(
            data: expectedUserList,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/users'),
          ));

      // Act
      final userList = await userService.fetchUserList(mockDio);

      // Assert
      expect(userList, equals(expectedUserList));
    });

    test('should throw an exception when the API call fails', () async {
      // Arrange
      when(mockDio.get('/users'))
          .thenThrow(DioError(requestOptions: RequestOptions(path: '/users')));

      // Act & Assert
      expect(() => userService.fetchUserList(mockDio), throwsException);
    });

    test('should return an empty list when the API response is empty',
        () async {
      // Arrange
      when(mockDio.get('/users')).thenAnswer((_) async => Response(
            data: [],
            statusCode: 200,
            requestOptions: RequestOptions(path: '/users'),
          ));

      // Act
      final userList = await userService.fetchUserList(mockDio);

      // Assert
      expect(userList, isEmpty);
    });
  });
}
