import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestimonialsScreen extends StatefulWidget {
  @override
  _TestimonialsScreenState createState() => _TestimonialsScreenState();
}

class _TestimonialsScreenState extends State<TestimonialsScreen> {
  final _testimonialController = TextEditingController();
  List<dynamic> _testimonials = [];
  String? _errorMessage;

  Future<void> _fetchTestimonials() async {
    try {
      final response = await http.get(Uri.parse('http://mobilecomputing.my.id/api_rezza/get_testimonials.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _testimonials = data['testimonials'];
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load testimonials';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
      print(e);  // Log error for debugging
    }
  }

  Future<void> _addTestimonial(String testimonial) async {
    try {
      final response = await http.post(
        Uri.parse('http://mobilecomputing.my.id/api_rezza/add_testimonial.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'testimonial': testimonial}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          _fetchTestimonials();  // Fetch the updated list of testimonials
          _testimonialController.clear();  // Clear the input field
        } else {
          setState(() {
            _errorMessage = 'Failed to add testimonial: ${data['message']}';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to add testimonial';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
      print(e);  // Log error for debugging
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTestimonials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testimonials'),
        backgroundColor: Color(0xFF84547A),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _testimonialController,
              decoration: InputDecoration(
                labelText: 'Add your testimonial',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final testimonial = _testimonialController.text;
              if (testimonial.isNotEmpty) {
                _addTestimonial(testimonial);
              }
            },
            child: Text('Submit Testimonial'),
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _testimonials.length,
              itemBuilder: (context, index) {
                final testimonial = _testimonials[index];
                return ListTile(
                  title: Text(testimonial['testimonial']),
                  subtitle: Text(testimonial['created_at']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}