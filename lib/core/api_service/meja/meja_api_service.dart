import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://192.168.100.200:3000/api/tables";

  Future<List<Map<String, dynamic>>> getTablesByProfileId(int profileId) async {
    final response = await http.get(Uri.parse('$baseUrl/profile/$profileId'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch tables');
    }
  }

  Future<Map<String, dynamic>> createTable(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create table');
    }
  }

  Future<void> updateTable(int idTable, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$idTable'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update table');
    }
  }

  // Tambahkan metode untuk mengupdate status tabel
  Future<void> updateTableStatus(int idTable, String status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$idTable/status'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': status}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update table status');
    }
  }

}
