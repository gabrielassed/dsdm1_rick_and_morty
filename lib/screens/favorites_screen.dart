import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';
import '../models/character.dart';
import '../widgets/character_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final fsService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Meus Favoritos'),
      ),
      body:
          user == null
              ? const Center(child: Text('Usuário não autenticado'))
              : StreamBuilder<List<Map<String, dynamic>>>(
                stream: fsService.favoritesStream(user.uid),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snap.hasError) {
                    return Center(child: Text('Erro: ${snap.error}'));
                  }
                  final maps = snap.data ?? [];
                  final favorites = maps
                      .map((m) => Character.fromJson(m))
                      .toList(growable: false);

                  if (favorites.isEmpty) {
                    return const Center(
                      child: Text('Você ainda não favoritou ninguém'),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: favorites.length,
                    itemBuilder:
                        (context, i) => CharacterCard(character: favorites[i]),
                  );
                },
              ),
    );
  }
}
