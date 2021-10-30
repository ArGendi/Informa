import 'dart:convert';
import 'package:http/http.dart' as http;

class WebServices {
  Future<http.Response> post(String url, data) async {
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(data),
    );
    return response;
  }

  Future<http.Response> postWithOrigin(String url, data) async {
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "origin": 'http://localhost',
        "Content-type": "application/json",
      },
      body: json.encode(data),
    );
    return response;
  }

  Future<http.Response> postWithBearerToken(String url, String token, data) async {
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        'authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    return response;
  }

  Future<http.Response> postWithAuth(String url, String key, data) async {
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        'api': key,
      },
      body: json.encode(data),
    );
    return response;
  }

  Future<http.Response> get(String url) async {
    var response = await http.get(
      Uri.parse(url),
      headers: {"Content-type": "application/json"},
    );
    return response;
  }

  Future<http.Response> getWithBearerToken(String url, String token) async {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        'authorization': 'Bearer $token',
      },
    );
    return response;
  }
  
  Future<http.Response> delete(String url) async{
    var response = await http.delete(
      Uri.parse(url),
      headers: {"Content-type": "application/json"},
    );
    return response;
  }

  Future<http.Response> update(String url, data) async{
    var response = await http.patch(
      Uri.parse(url),
      headers: {"Content-type": "application/json"},
      body: json.encode(data),
    );
    return response;
  }

  Future<http.Response> anotherDelete(String url, data) async{
    var response = await http.delete(
      Uri.parse(url),
      headers: {"Content-type": "application/json"},
      body: json.encode(data),
    );
    return response;
  }



}

