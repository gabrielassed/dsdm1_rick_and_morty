import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/character.dart';
import '../services/firestore_service.dart';

class CharacterCard extends StatefulWidget {
  final Character character;
  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  final _fsService = FirestoreService();
  final _auth = FirebaseAuth.instance;
  bool _isFavorite = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    final user = _auth.currentUser;
    if (user == null) return;
    final fav = await _fsService.isFavorite(
      user.uid,
      widget.character.id.toString(),
    );
    setState(() => _isFavorite = fav);
  }

  Future<void> _toggleFavorite() async {
    final user = _auth.currentUser;
    if (user == null) return;
    setState(() => _loading = true);

    final charId = widget.character.id.toString();
    final userId = user.uid;
    try {
      if (_isFavorite) {
        await _fsService.removeFavorite(userId, charId);
      } else {
        await _fsService.addFavorite(userId, widget.character.toJson());
      }
      setState(() => _isFavorite = !_isFavorite);
    } catch (e) {
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                widget.character.image,
                height: 120,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.character.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color:
                              widget.character.status.toLowerCase() == 'alive'
                                  ? Colors.green
                                  : widget.character.status.toLowerCase() ==
                                      'dead'
                                  ? Colors.red
                                  : Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.character.status,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Espécie: ${widget.character.species}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 4,
            right: 4,
            child:
                _loading
                    ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: _toggleFavorite,
                    ),
          ),
        ],
      ),
    );
  }
}
