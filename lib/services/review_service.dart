import 'dart:convert';

import 'package:http/http.dart' as http;

import '../environment.dart';
import '../models/reviewRequest.dart';
import '../models/reviewResponse.dart';
import 'auth_service.dart';

class ReviewService {
  /// Metodo para crear una review
  /// [reviewRequest] es el objeto que se envia en la peticion http
  Future<http.Response> createReview(ReviewRequest reviewRequest) async {
    try {
      final response =
          await http.post(Uri.parse('${Environment.coreBack}review'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $AuthService.getToken()',
              },
              body: json.encode(reviewRequest.toJson()));
      if (response.statusCode != 201) {
        throw Exception('Error al crear la review');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Metodo para obtener todas las reviews de un tutor
  /// [tutorId] es el id del tutor
  Future<List<ReviewResponse>> getReviewsByTutor(String tutorId) async {
    try {
      final response = await http.get(
        Uri.parse('${Environment.coreBack}review/tutor/$tutorId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $AuthService.getToken()',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error al obtener reviews');
      }
      final List<dynamic> reviewsJson = json.decode(response.body);
      final List<ReviewResponse> reviews =
          reviewsJson.map((json) => ReviewResponse.fromJson(json)).toList();
      return reviews;
    } catch (e) {
      rethrow;
    }
  }
}
