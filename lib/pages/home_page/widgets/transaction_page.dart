import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<String> list = List.generate(20, (i) => 'Transaction $i');

    return Container(
      width: size.width,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: size.width * .5,
                  height: size.height * .05,
                  color: Colors.deepPurple,
                  child: const Center(
                    child: Text(
                      'Saldo:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * .5,
                  height: size.height * .05,
                  child: const Center(
                    child: Text(
                      '1000.00',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(
                    Icons.money,
                    color: Colors.deepPurple,
                    size: 18,
                  ),
                  trailing: Text('${index * 25}'),
                  title:
                      Text(list[index], style: const TextStyle(fontSize: 13)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
