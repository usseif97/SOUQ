import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.model}) : super(key: key);
  final model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 400.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: model.image != null
                        ? NetworkImage(model.image)
                        : NetworkImage('https://i.stack.imgur.com/mwFzF.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.name,
                  style: TextStyle(fontSize: 35.0),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'DESCRIPTION',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                child: Text(
                  model.description,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'PRICE',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  '${model.price}\$',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }
}
