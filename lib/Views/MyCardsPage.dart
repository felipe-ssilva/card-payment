import 'package:cardpayment/widgets/card_back.dart';
import 'package:cardpayment/widgets/card_front.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyCardsPage extends StatefulWidget {
  @override
  _MyCardsPageState createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> with SingleTickerProviderStateMixin {
  double _rotationFactor = 0;
  TextEditingController _cardNumberController, _cvvController;
  AnimationController _flipAnimationController;
  Animation<double> _flipAnimation;
  FocusNode _cvvFocus;

  String _cardNumber = '';
  String _cvvNumber = '';

  _MyCardsPageState()
  {
    _cardNumberController = TextEditingController();
    _cvvController = TextEditingController();
    _cvvFocus = FocusNode();

    _cardNumberController.addListener((){
      _cardNumber = _cardNumberController.text;
      setState(() {
        
      });
    });

    _cvvController.addListener((){
      _cvvNumber = _cvvController.text;
      setState(() {
        
      });
    });

    _cvvFocus.addListener((){
      _cvvFocus.hasFocus
        ? _flipAnimationController.forward()
        : _flipAnimationController.reverse();
    });
  }

  @override

  void initState(){
    super.initState();

    _flipAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350)
    );

    _flipAnimation =
      Tween<double>(begin: 0, end: 1).animate(_flipAnimationController)
        ..addListener((){
          setState(() {
            
          });
        });

    _flipAnimationController.forward();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cards'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(pi * _flipAnimation.value),
              origin: Offset(MediaQuery.of(context).size.width / 2, 0),
              child: _flipAnimation.value < 0.5 ? CardFrontView(cardNumber: _cardNumber) : CardBackView(cvvNumber: _cvvNumber)
            ),
            // Slider(
            //   onChanged: (double value){
            //     setState(() {
            //       _rotationFactor = value;
            //     });
            //   },
            //   value: _rotationFactor
            // )
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Card Number'
                    ),
                    controller: _cardNumberController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Name on Card'
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Expiry Date'
                          )
                        )
                      ),
                      SizedBox(width: 32),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'CVV'
                          ),
                          controller: _cvvController,
                          focusNode: _cvvFocus,
                        )
                      ),
                    ]
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}