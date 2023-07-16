import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = ['Bananas', 'Chips', 'Pizza'];

  List<double> itemPrices = [1.25, 1.49, 2.99];

  final textController = TextEditingController();
  final priceController = TextEditingController();

  int? itemIndex;
  IconData buttonIcon = Icons.add;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        children: [
          Expanded(child: TextField(
            controller: textController,
          )),
          Expanded(child: TextField(
            controller: priceController,
          )),
          ElevatedButton(
            child: Icon(buttonIcon),
            onPressed: () {
              setState(() {
                if(itemIndex != null){
                  if(textController.text.isNotEmpty && priceController.text.isNotEmpty){
                    items[itemIndex!] = textController.text;
                    itemPrices[itemIndex!] = double.parse(priceController.text);
                  }
                  itemIndex = null;
                  buttonIcon = Icons.add;
                }else{
                  if(textController.text.isNotEmpty && priceController.text.isNotEmpty){
                    items.add(textController.text);
                    itemPrices.add(double.parse(priceController.text));
                  }
                }
                priceController.clear();
                textController.clear();
                
              });
            },
          ),
        ],
      )),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(child: ListTile(title: Text(items[index]),
          trailing: Text('\€${itemPrices[index]}'),
          onTap: () {
            itemIndex = index;
            setState(() {
              buttonIcon = Icons.save;
              textController.text = items[index];
              priceController.text = itemPrices[index].toString();
            });
          },
          onLongPress: () {
            setState(() {
              items.removeAt(index);
              itemPrices.removeAt(index);
            });
          },
          )
          );
        },

      ),
      
    );
  }
}