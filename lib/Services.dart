import 'dart:convert';

import 'package:http/http.dart' as http; // add the http plugin in pubspec.yaml file.

import 'Employee.dart';

class Services {
  static const ROOT = 'http://192.168.2.148:8090/projects/fluttersample.php';
  static const Root1 = 'https://api.everydaysuccessteam.com/user/v1/common/gettoprankers';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  // Method to create the table Employees.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');

      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  /* static Future<List<Employee>> getEmployees() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('getEmployees Response: ${response.body}');
      List<Employee> list = getEmployees1();
      print(list.length);
      return list;
      */ /*  if (200 == response.statusCode) {
        List<Employee> list = parseResponse(response.body);
        return list;
      } else {
        return List<Employee>();
      }*/ /*
    } catch (e) {
      return List<Employee>(); // return an empty list on exception/error
    }
  }*/

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  // Method to add employee to the database...
  static Future<String> addEmployee(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('addEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Employee in Database...
  static Future<String> updateEmployee(String empId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('updateEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to Delete an Employee from Database...
  static Future<String> deleteEmployee(String empId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      final response = await http.post(ROOT, body: map);
      print('deleteEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }

  static Future<List<Employee>> getEmployees1() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.get(Root1, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6eyJhZmZpbGlhdGVfaWQiOjE5MTYsImFmZmlsaWF0ZV9uYW1lIjoidGVzdG1hbmFnZXIyIiwiYWZmaWxpYXRlX2VtYWlsIjoiZWxpdGVtbG1zb2Z0d2FyZUBnbWFpbC5jb20iLCJhZmZpbGlhdGVfZmlyc3RfbmFtZSI6ImVsaXRlbWxtc29mdHdhcmVAZ21haWwuY29tIiwiYWZmaWxpYXRlX2xhc3RfbmFtZSI6InRlc3QgbWFuYWdlciIsInNwb25zb3JfbmFtZSI6IkV2ZXJ5RGF5U3VjY2Vzc1RlYW0iLCJhZmZpbGlhdGVfcGhvbmUiOiIyMTIxMjEyMTIxIiwiYWZmaWxpYXRlX3Bhc3N3b3JkIjoiJDJiJDEwJERWUnovckE5LnVTSWJPS2w2MlJOUWU2SG5aYW40bC9JLlAxdWFKUWdFVUxSNEcxSDNMem9TIiwiYWZmaWxpYXRlX2xldmVsIjoxLCJhZmZpbGlhdGVfcHJvZmlsZV9waWMiOiJodHRwczovL2FwaS5ldmVyeWRheXN1Y2Nlc3N0ZWFtLmNvbS9mdHAvdXBsb2Fkcy9hdmF0YXItMi5wbmciLCJ3cF9zaG9wX2lkIjowLCJhZmZpbGlhdGVfc3RhdHVzIjoiQWN0aXZlIiwicGFja2FnZV9pZCI6MywiY2FtcGFpZ25fc3RhdHVzIjoiU3RhcnRlZCJ9LCJpYXQiOjE2MDEyNzI3NjcsImV4cCI6MTYzMjgwODc2N30.Hg-5pukw_MqmjuaFM3ZRRvqBw-IEPJwWBjKffOLlaI0"
      });
      print('getEmployees Response: ${response.body}');
      List<Employee> list = _parseJsonForCrosswords(response.body.toString());

      return list;
    } catch (e) {
      return List<Employee>();
    }
  }

  static List<Employee> _parseJsonForCrosswords(String jsonString) {
    Map<String, dynamic> decodedMap = jsonDecode(jsonString);
    List<dynamic> dynamicList = decodedMap['data'];

    List<Employee> students = new List<Employee>();

    dynamicList.forEach((i) {
      Employee s = Employee.fromJson(i);
      students.add(s);
    });

    return students;
  }
}
