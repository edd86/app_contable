import 'package:app_contable/providers/transactions_provider.dart';
import 'package:app_contable/variables/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  final titleStyle = const TextStyle(
    fontSize: 12,
    color: Colors.deepPurple,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                  child: Center(
                    child: Consumer<TransactionsProvider>(
                      builder: (context, transactionProvider, child) {
                        final saldo = transactionProvider.saldo;
                        return Text(
                          '$saldo',
                          style: TextStyle(
                            color:
                                saldo >= 0.0 ? Colors.deepPurple : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Consumer<TransactionsProvider>(
              builder: (context, transactionsProvider, child) {
                final transactions = transactionsProvider.transactions;
                if (transactions == null) {
                  return const Center(
                    child: Text('Error al cargar transacciones'),
                  );
                }
                if (transactions.isEmpty) {
                  return const Center(
                    child: Text('No hay transacciones registradas'),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: transactions.length,
                    itemBuilder: (context, i) {
                      final transaction = transactions[i];
                      return ListTile(
                        leading: Icon(
                          Icons.money,
                          color: transaction.type == 'expense'
                              ? Colors.red
                              : Colors.deepPurple,
                          size: 18,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                GlobalVariables.dateToString(
                                    DateTime.parse(transaction.date)),
                                style: titleStyle),
                            Text(
                              GlobalVariables.timeToString(
                                  DateTime.parse(transaction.date)),
                              style: titleStyle,
                            ),
                          ],
                        ),
                        subtitle: Text(transaction.description ?? ''),
                        trailing: Text(
                          transaction.amount.toString(),
                          style: TextStyle(
                              color: transaction.type == 'expense'
                                  ? Colors.red
                                  : Colors.deepPurple),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
