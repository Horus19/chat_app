import 'package:chat_app/models/tutorDTO.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/reviewResponse.dart';
import '../services/review_service.dart';

class TutorDetailPage extends StatefulWidget {
  const TutorDetailPage({Key? key}) : super(key: key);

  @override
  _TutorDetailPageState createState() => _TutorDetailPageState();
}

class _TutorDetailPageState extends State<TutorDetailPage> {
  TutorDto get tutor => ModalRoute.of(context)!.settings.arguments as TutorDto;
  ReviewService _reviewService = ReviewService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/profile.png',
                  fit: BoxFit.cover,
                ),
                title: Text(tutor.nombre!),
              ),
              floating: true,
              elevation: 0,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    const Text(
                      'Descripción:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      tutor.descripcion!,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Materias:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: tutor.materias!.map((m) {
                        return Text(
                          '• ${m.nombre!}',
                          style: const TextStyle(fontSize: 16.0),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Costo sugerido:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          tutor.costo!,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Calificación:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          tutor.calificacion!,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Resenas:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    _createReviewsCarousel(),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _createRequestButton(context),
      ),
    );
  }

  /// Crea el botón para solicitar tutoría
  BottomAppBar _createRequestButton(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.grey[200],
      child: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'SolicitudTutoriaScreen',
                    arguments: tutor);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Solicitar tutoría',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Crea el carrusel de reviews
  /// [reviews] Lista de reviews a mostrar
  FutureBuilder<List<ReviewResponse>> _createReviewsCarousel() {
    return FutureBuilder<List<ReviewResponse>>(
      future: _reviewService.getReviewsByTutor(tutor.id ?? ''),
      builder:
          (BuildContext context, AsyncSnapshot<List<ReviewResponse>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final reviews = snapshot.data;
        if (reviews == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (reviews.isEmpty) return const Text('EL tutor no tiene reviews');
        return CarouselSlider(
          options: CarouselOptions(height: 200.0, enableInfiniteScroll: false),
          items: reviews.map((review) {
            return _createReviewCard(review);
          }).toList(),
        );
      },
    );
  }

  /// Crea tarjeta de review
  /// [review] Review a mostrar
  Card _createReviewCard(ReviewResponse review) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 2.0,
              spreadRadius: 1.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${review.estudiante}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                const SizedBox(width: 8.0),
                Text(
                  '${review.calificacion}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              '${review.comentario}',
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
