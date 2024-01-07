import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prashant Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Pagination(length: 13),
    );
  }
}

class Pagination extends StatefulWidget {
  final int length;

  Pagination({required this.length});

  @override
  _PaginationState createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int itemsPerPage = 4;
  int currentPage = 1;

  List<int> itemList = List.generate(10, (index) => index + 1);

  List<int> getCurrentPageItems() {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;

    if (endIndex > widget.length) {
      int remainingItems = endIndex - widget.length;
      return itemList.sublist(startIndex, widget.length) +
          itemList.sublist(0, remainingItems);
    }
    return itemList.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          TextFormField(controller: TextEditingController(),),

          Expanded(
            child: ListView.builder(
              itemCount: getCurrentPageItems().length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item ${getCurrentPageItems()[index]}'),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: currentPage > 1
                    ? () {
                  setState(() {
                    currentPage--;
                  });
                }
                    : null,
                child: Text('Prev'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: currentPage <
                    (widget.length / itemsPerPage).ceil()
                    ? () {
                  setState(() {
                    currentPage++;
                  });
                }
                    : null,
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}