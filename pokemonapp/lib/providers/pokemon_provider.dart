import 'package:flutter/material.dart';

import '../services/pokemon_service.dart';

class PokemonProvider extends ChangeNotifier {
  List<dynamic> pokemons = [];

  Map<String, dynamic>? pokemonSelecionado;

  bool carregando = false;

  Future<void> carregarPokemons() async {
    carregando = true;

    notifyListeners();

    pokemons = await PokemonService.buscarPokemons();

    carregando = false;

    notifyListeners();
  }

  Future<void> carregarDetalhes(
    int id,
  ) async {
    carregando = true;

    pokemonSelecionado = null;

    notifyListeners();

    pokemonSelecionado = await PokemonService.buscarDetalhes(
      id,
    );

    carregando = false;

    notifyListeners();
  }

  Future<void> carregarPesquisa(String pesquisa) async {
    carregando = true;

    notifyListeners();

    pokemons = await PokemonService.pesquisarPkmn(pesquisa);

    carregando = false;

    notifyListeners();
  }
}
