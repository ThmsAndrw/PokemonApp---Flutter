import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pokemon_provider.dart';

class TelaDetalhesPokemon extends StatefulWidget {
  final int idPokemon;

  const TelaDetalhesPokemon({
    super.key,
    required this.idPokemon,
  });

  @override
  State<TelaDetalhesPokemon> createState() {
    return _TelaDetalhesPokemonState();
  }
}

class _TelaDetalhesPokemonState extends State<TelaDetalhesPokemon> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PokemonProvider>().carregarDetalhes(widget.idPokemon);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PokemonProvider>();

    final pokemon = provider.pokemonSelecionado;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokédex',
        ),
        centerTitle: true,
      ),
      body: provider.carregando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : pokemon == null
              ? const Center(
                  child: Text(
                    'Pokémon não encontrado',
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // =============================
                      // CABEÇALHO
                      // =============================

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(25),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(
                            255,
                            230,
                            72,
                            72,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35),
                          ),
                        ),
                        child: Column(
                          children: [
                            // Número do Pokémon
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '#${pokemon['id']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // Imagem
                            Container(
                              width: 200,
                              height: 200,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Image.network(
                                  pokemon['imagem'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            // Nome
                            Text(
                              pokemon['nome'].toString().toUpperCase(),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Tipos
                            Wrap(
                              spacing: 10,
                              children: (pokemon['tipos'] as List).map(
                                (tipo) {
                                  return Chip(
                                    label: Text(
                                      tipo.toString().toUpperCase(),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                      ),

                      // =============================
                      // CONTEÚDO
                      // =============================

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // =============================
                            // INFORMAÇÕES
                            // =============================

                            const Text(
                              'Informações',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Row(
                              children: [
                                // ALTURA
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        15,
                                      ),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.height,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            '${pokemon['altura']}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            'Altura',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // PESO
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        15,
                                      ),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.monitor_weight,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            '${pokemon['peso']}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            'Peso',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // EXPERIÊNCIA
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        15,
                                      ),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            '${pokemon['experiencia']}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            'XP',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            // =============================
                            // ATRIBUTOS
                            // =============================

                            const Text(
                              'Atributos',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.favorite,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'HP',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${pokemon['hp']}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.flash_on,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Ataque',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${pokemon['ataque']}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.shield,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Defesa',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${pokemon['defesa']}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            // =============================
                            // HABILIDADES
                            // =============================

                            const Text(
                              'Habilidades',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: (pokemon['habilidades'] as List).map(
                                (habilidade) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        255,
                                        235,
                                        235,
                                        235,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Text(
                                      habilidade.toString().toUpperCase(),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            // =============================
                            // BOTÃO VOLTAR
                            // =============================

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Voltar para Pokédex',
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
