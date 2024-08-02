import 'package:flutter/material.dart';
import '../../widgets/card_custom.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: ListView(
        children: [
          CustomCard(
            title: 'Titulo uno',
            subtitle: 'Descipcion uno',
            icon: Icons.home,
          ),
          CustomCard(
            title: 'TItulo 2',
            subtitle: 'Descipcion dos',
            icon: Icons.star,
          ),
          CustomCard(
            title: 'titulo 3',
            subtitle: 'Descripcion tres',
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }
}
