import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Our Tools',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/welcome.jpg',
              width: 300,
              height: 100,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToolButton(context, '/tool1', 'assets/images/duplicate.jpg', 'Duplicate Line Remover'),
                SizedBox(width: 20),
                _buildToolButton(context, '/tool2', 'assets/images/recipe.jpg', 'Recipe Finder Tool'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolButton(BuildContext context, String route, String imagePath, String text) {
    return HoverEffectButton(
      onTap: () => Navigator.pushNamed(context, route),
      image: imagePath,
      text: text,
    );
  }
}

class HoverEffectButton extends StatefulWidget {
  final VoidCallback onTap;
  final String image;
  final String text;

  HoverEffectButton({required this.onTap, required this.image, required this.text});

  @override
  _HoverEffectButtonState createState() => _HoverEffectButtonState();
}

class _HoverEffectButtonState extends State<HoverEffectButton> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        setState(() {
          scale = value ? 1.1 : 1.0; 
        });
      },
      child: Transform.scale(
        scale: scale,
        child: Column(
          children: [
            Container(
              width: 250,
              height: 250,
              child: Image.asset(widget.image),
            ),
            Text(widget.text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
