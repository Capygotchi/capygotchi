import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math';

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
  bool _isMoving = true; // Indicateur pour savoir si l'image est en mouvement ou figée
  late Timer _timer; // Timer pour mettre à jour la position de l'image
  final _random = Random(); // Générateur de nombre aléatoire

  @override
  void initState() {
    super.initState();
    // Démarre un Timer pour mettre à jour la position de l'image toutes les 1000 millisecondes
    _timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
        setState(() {
          _isMoving = _random.nextDouble() > 0.2; // 20% de chance que le capybara se fige
          if (_isMoving) {
            if (_leftPosition < MediaQuery.of(context).size.width - 100 && _movingRight) {
              _leftPosition += 10; // Déplacer l'image vers la droite
            } else {
              _movingRight = false;
            }
            if (_leftPosition > 20 && !_movingRight) {
              _leftPosition -= 10; // Déplacer l'image vers la gauche
            } else {
              _movingRight = true;
            }
          } else {
            _leftPosition = _leftPosition; // Ne pas bouger
            };
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
            alignment: Alignment.topCenter,
            child: Text(
              context.read<Capybara>().name,
              style: TextStyle(fontSize: 18),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            bottom: 0,
            left: _leftPosition,
            child: _isMoving
                ? Transform(
                    transform: _movingRight ? Matrix4.rotationY(3.14159) : Matrix4.rotationY(0),
                    alignment: Alignment.center,
                    child: Image.asset('assets/walk_left.gif'),
                )
                : Transform(
                    transform: _movingRight ? Matrix4.rotationY(3.14159) : Matrix4.rotationY(0),
                    alignment: Alignment.center,
                    child:Image.asset('assets/stand_left.gif'),
                ),
          ),

        ],
      ),
    );
  }
}
