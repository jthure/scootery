import 'dart:convert';

import 'package:http/http.dart' as http;

class ScooterRepo {
  Future<ScooterResponse> fetchScooters(
      double latitude, double longitude) async {
    final response = await http.post(
      Uri.https('flow-api.fluctuo.com', 'v1',
          {'access_token': 'fvX7CihmRb5aH6LsSMTe9259HGXIa5nI'}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'query':
            'query (\$lat: Float!, \$lng: Float!) {vehicles (lat: \$lat, lng: \$lng) {\r\n    id\r\n    type\r\n    attributes\r\n    lat\r\n    lng\r\n    provider {\r\n      name\r\n    }\r\n  }\r\n}',
        'variables': {
          'lat': latitude,
          'lng': longitude,
        }
      }),
    );

    if (response.statusCode == 200) {
      return ScooterResponse.fromJson(jsonDecode(response.body));
    } else {
      // print(response.bodyBytes.)
      throw Exception('Failed to load album');
    }
  }
}

class ScooterResponseItem {
  final String id;
  final double lat;
  final double lng;
  final String provider;
  final String type;

  ScooterResponseItem({
    required this.id,
    required this.lat,
    required this.lng,
    required this.provider,
    required this.type,
  });

  String assetKey() => "${type.toLowerCase()}_${provider.toLowerCase()}";

  factory ScooterResponseItem.fromJson(Map<String, dynamic> json) {
    return ScooterResponseItem(
        id: json['id'],
        lat: json['lat'],
        lng: json['lng'],
        provider: json['provider']['name'],
        type: json['type']);
  }
}

class ScooterResponse {
  final List<ScooterResponseItem> scooters;

  ScooterResponse({required this.scooters});

  factory ScooterResponse.fromJson(Map<String, dynamic> json) {
    var x = (json['data']['vehicles'] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    var scooters = x.map((e) => ScooterResponseItem.fromJson(e)).toList();
    return ScooterResponse(scooters: scooters);
  }
}
