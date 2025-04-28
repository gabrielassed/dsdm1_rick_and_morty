import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/api_service.dart';
import '../widgets/character_card.dart';

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({Key? key}) : super(key: key);

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  final ApiService _api = ApiService();
  final ScrollController _scrollController = ScrollController();

  final List<Character> _characters = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _fetchPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage() async {
    setState(() => _isLoading = true);
    try {
      final fetched = await _api.fetchCharacters(page: _currentPage);
      if (fetched.isEmpty) {
        _hasMore = false;
      } else {
        _currentPage++;
        _characters.addAll(fetched);
      }
    } catch (e) {
      _hasMore = false;
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: _characters.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < _characters.length) {
          return CharacterCard(character: _characters[index]);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
