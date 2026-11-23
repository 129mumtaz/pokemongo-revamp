import 'package:flutter/material.dart';
import 'package:flutter_apps/data/pokemon_data.dart';
import 'package:flutter_apps/models/pokemon.dart';
import 'package:flutter_apps/pages/detail_page.dart';
import 'package:flutter_apps/widgets/pokemon_card.dart';
import 'package:flutter_apps/widgets/pokemon_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Pokemon> pokemon = dataPokemon;

  String _searchQuery = '';
  bool _showFavoriteOnly = false;
  final Set<String> _favoritePokemon = {};
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFavorite(String name) {
    setState(() {
      if (_favoritePokemon.contains(name)) {
        _favoritePokemon.remove(name);
      } else {
        _favoritePokemon.add(name);
      }
    });
  }

  Future<void> _openDetail(Pokemon pokemonItem, bool isFavorite) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(pokemon: pokemonItem, isFavorite: isFavorite),
      ),
    );

    if (result != null) {
      setState(() {
        if (result) {
          _favoritePokemon.add(pokemonItem.name);
        } else {
          _favoritePokemon.remove(pokemonItem.name);
        }
      });
    }
  }

  List<Pokemon> get _filteredPokemon {
    return pokemon.where((p) {
      final matchesSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery);
      final matchesFavorite =
          !_showFavoriteOnly || _favoritePokemon.contains(p.name);
      return matchesSearch && matchesFavorite;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredPokemon;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pokemon Go",
          style: TextStyle(
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
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              _showFavoriteOnly ? Icons.favorite : Icons.favorite_border,
              color: _showFavoriteOnly
                  ? const Color(0xFFE85D4A)
                  : Colors.white,
            ),
            tooltip: _showFavoriteOnly
                ? 'Show All'
                : 'Show Favorites Only',
            onPressed: () {
              setState(() {
                _showFavoriteOnly = !_showFavoriteOnly;
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.trim().toLowerCase();
                          });
                        },
                        style: const TextStyle(
                          color: Color(0xFF292D32),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFFFFFFF),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF376B4D),
                            size: 20,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    size: 18,
                                    color: Color(0xFF777777),
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                )
                              : null,
                          hintText: "Search Pokemon",
                          hintStyle: const TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E0D5),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF376B4D),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Tooltip(
                      message: _showFavoriteOnly
                          ? "Filter: Favorites Only (Active)"
                          : "Filter: Favorites Only (Inactive)",
                      child: Switch(
                        value: _showFavoriteOnly,
                        activeThumbColor: const Color(0xFF376B4D),
                        activeTrackColor: const Color(0xFF376B4D).withValues(alpha: 0.3),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: const Color(0xFFE5E0D5),
                        trackOutlineColor: WidgetStateProperty.resolveWith(
                          (states) => states.contains(WidgetState.selected)
                              ? const Color(0xFF376B4D)
                              : const Color(0xFFE5E0D5),
                        ),
                        thumbIcon: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return const Icon(
                              Icons.favorite,
                              size: 14,
                              color: Color(0xFFE85D4A),
                            );
                          }
                          return const Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Color(0xFF777777),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            _showFavoriteOnly = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: filteredList.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _showFavoriteOnly
                                    ? Icons.favorite_border
                                    : Icons.search_off,
                                size: 56,
                                color: const Color(0xFF777777).withValues(alpha: 0.5),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _showFavoriteOnly
                                    ? "Belum ada Pokémon favorit"
                                    : "Pokémon '$_searchQuery' tidak ditemukan",
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF777777),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth <= 500) {
                            return ListView.builder(
                              padding: const EdgeInsets.only(bottom: 16),
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                final item = filteredList[index];
                                final isFav = _favoritePokemon.contains(item.name);
                                return PokemonList(
                                  pokemon: item,
                                  isFavorite: isFav,
                                  onTap: () => _openDetail(item, isFav),
                                  isFavoriteTap: () => _toggleFavorite(item.name),
                                );
                              },
                            );
                          } else {
                            return GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 380,
                                mainAxisExtent: 295,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                final item = filteredList[index];
                                final isFav = _favoritePokemon.contains(item.name);
                                return PokemonCard(
                                  pokemon: item,
                                  type: item.type,
                                  isFavorite: isFav,
                                  onTap: () => _openDetail(item, isFav),
                                  onFavoriteTap: () => _toggleFavorite(item.name),
                                );
                              },
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
