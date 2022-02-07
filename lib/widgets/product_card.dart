import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  const ProductCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 400,
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: const [
            _BackgroundImage(),
            _ProductDetails(),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag()
            ),
            Positioned(
              top: 0,
              left: 0,
              child: _NotAvailable()
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 7),
        blurRadius: 10
      )
    ]
  );

}

class _NotAvailable extends StatelessWidget {

  const _NotAvailable({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('No disponible', style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
      height: 70,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
    );
  }

}

class _PriceTag extends StatelessWidget {

  const _PriceTag({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$155.99', style: TextStyle(color: Colors.white, fontSize: 20))
        ),
      ),
      height: 70,
      width: 100,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
    );
  }

}

class _ProductDetails extends StatelessWidget {

  const _ProductDetails({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'PC Gamer',
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'ID PC',
              style: TextStyle(fontSize: 12, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );

}

class _BackgroundImage extends StatelessWidget {

  const _BackgroundImage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: const SizedBox(
        height: 400,
        width: double.infinity,
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}