import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

import 'pages/tela_pokemon.dart';
import 'providers/pokemon_provider.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => PokemonProvider(),
        child: const MeuApp(),
      ),
    ),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const TelaPokemon(),
    );
  }
}
