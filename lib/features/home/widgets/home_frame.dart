import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class HomeFrame extends StatefulWidget {
  const HomeFrame({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeFrame> createState() => _HomeFrameState();
}

class _HomeFrameState extends State<HomeFrame> {
  double _leftPosition = 20; // Position horizontale initiale de l'image
  bool _movingRight = true; // Indicateur pour savoir si l'image se déplace vers la droite ou vers la gauche
  late Timer _timer; // Timer pour mettre à jour la position de l'image

  @override
  void initState() {
    super.initState();
    // Démarre un Timer pour mettre à jour la position de l'image toutes les 1000 millisecondes
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (_leftPosition < 280 && _movingRight) {
          _leftPosition += 10; // Déplacer l'image vers la droite
        } else {
          _movingRight = false;
        }

        if (_leftPosition > 20 && !_movingRight) {
          _leftPosition -= 10; // Déplacer l'image vers la gauche
        } else {
          _movingRight = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Arrêter le Timer lorsque le widget est supprimé
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: const BoxDecoration(
        color: Color(0xffA8C69F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Align(  //NOM DU CAPYBARA
            alignment: Alignment.bottomCenter,
            child: Text(
              context.read<Capybara>().name,
              style: TextStyle(fontSize: 18),
            ),
          ),
          AnimatedPositioned(  //IMAGE DU CAPYBARA
            duration: const Duration(milliseconds: 1000),
            bottom: 0,
            left: _leftPosition,
            child: Image.asset('assets/bigger_capy.gif'),
          ),
        ],
      ),
    );
  }
}
