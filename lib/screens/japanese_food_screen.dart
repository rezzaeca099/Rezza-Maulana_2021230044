import 'package:flutter/material.dart';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JapaneseFoodScreen extends StatefulWidget {
  @override
  _JapaneseFoodScreenState createState() => _JapaneseFoodScreenState();
}

class _JapaneseFoodScreenState extends State<JapaneseFoodScreen> {
  List<dynamic> _foods = [];
  bool _isLoading = true;
  bool _hasError = false;

  Future<void> _fetchFoods() async {
    try {
      final response = await http.get(Uri.parse('${Config.apiUrl}/get_foods.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _foods = data['foods'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load foods');
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print('Error fetching foods: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Japanese Food Menu'),
        backgroundColor: Color(0xFF84547A),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
          ? Center(child: Text('Failed to load foods'))
          : ListView.builder(
        itemCount: _foods.length,
        itemBuilder: (context, index) {
          final food = _foods[index];
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (food['image'] != null && food['image'].isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(
                      food['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food['name'] ?? 'No Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF84547A),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        food['description'] ?? 'No Description',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.restaurant_menu, color: Color(0xFF84547A)),
                          SizedBox(width: 5),
                          Text(
                            food['category'] ?? 'No Category',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}