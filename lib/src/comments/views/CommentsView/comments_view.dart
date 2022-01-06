import 'package:flutter/material.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: const Center(child: Text('Hello World')),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}