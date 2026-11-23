import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/models/pokemon.dart';
import 'package:flutter_apps/widgets/type_chip.dart';

class DetailPage extends StatefulWidget {
  final Pokemon pokemon;
  final bool isFavorite;

  const DetailPage({
    super.key,
    required this.pokemon,
    required this.isFavorite,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSlider = widget.pokemon.movies
        .map<Widget>(
          (url) => Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E0D5), width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFFAF8F1),
                  child: const Center(
                    child: Icon(Icons.movie_outlined, color: Color(0xFF777777), size: 36),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, _isFavorite);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.pokemon.name,
            style: const TextStyle(
              fontFamily: 'PokemonSolid',
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color(0xFFF5C542),
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
            tooltip: 'Back',
            onPressed: () => Navigator.pop(context, _isFavorite),
          ),
          actions: [
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? const Color(0xFFE85D4A) : Colors.white,
              ),
              tooltip: _isFavorite ? 'Remove Favorite' : 'Add Favorite',
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 768) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE5E0D5),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Hero(
                              tag: widget.pokemon.name,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(19),
                                child: Image.asset(
                                  widget.pokemon.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE5E0D5),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.pokemon.name,
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: Color(0xFF292D32),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TypeChip(type: widget.pokemon.type),
                                  const SizedBox(height: 14),
                                  Text(
                                    "Base Power : ${widget.pokemon.basePower}",
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xFF292D32),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  const Text(
                                    "Deskripsi",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xFF292D32),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.pokemon.description,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      height: 1.5,
                                      color: Color(0xFF777777),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  const Text(
                                    "Skills",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xFF292D32),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: widget.pokemon.skills
                                        .map(
                                          (e) => Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFAF8F1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: const Color(0xFFE5E0D5),
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Color(0xFFF5C542),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  e,
                                                  style: const TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF292D32),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Featured Movies",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xFF292D32),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CarouselSlider.builder(
                                    options: CarouselOptions(
                                      aspectRatio: 2.2,
                                      enlargeCenterPage: false,
                                      viewportFraction: 1,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 4),
                                    ),
                                    itemCount: (widget.pokemon.movies.length / 2)
                                        .ceil(),
                                    itemBuilder: (context, index, realIdx) {
                                      final int first = index * 2;
                                      final int second = first + 1;
                                      final indices = [
                                        first,
                                        if (second <
                                            widget.pokemon.movies.length)
                                          second,
                                      ];
                                      return Row(
                                        children: indices.map((idx) {
                                          return Expanded(
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xFFE5E0D5),
                                                  width: 1,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                child: Image.network(
                                                  widget.pokemon.movies[idx],
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Container(
                                                    color:
                                                        const Color(0xFFFAF8F1),
                                                    height: 120,
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.movie_outlined,
                                                        color:
                                                            Color(0xFF777777),
                                                        size: 32,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Hero(
                            tag: widget.pokemon.name,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFE5E0D5),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.03),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(19),
                                child: Image.asset(
                                  widget.pokemon.image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          padding: const EdgeInsets.all(16.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFE5E0D5),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.pokemon.name,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Color(0xFF292D32),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TypeChip(type: widget.pokemon.type),
                              const SizedBox(height: 14),
                              Text(
                                "Base Power : ${widget.pokemon.basePower}",
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF292D32),
                                ),
                              ),
                              const SizedBox(height: 14),
                              const Text(
                                "Deskripsi",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF292D32),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.pokemon.description,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  height: 1.5,
                                  color: Color(0xFF777777),
                                ),
                              ),
                              const SizedBox(height: 14),
                              const Text(
                                "Skills",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF292D32),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: widget.pokemon.skills
                                    .map(
                                      (e) => Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFAF8F1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: const Color(0xFFE5E0D5),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 16,
                                              color: Color(0xFFF5C542),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              e,
                                              style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF292D32),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Featured Movies",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF292D32),
                                ),
                              ),
                              const SizedBox(height: 10),
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 200,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: true,
                                  autoPlayInterval:
                                      const Duration(seconds: 4),
                                  viewportFraction: 0.85,
                                ),
                                items: imageSlider,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
