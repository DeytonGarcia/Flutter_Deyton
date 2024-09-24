import 'package:flutter_deyton/message_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deyton/register_contact.dart';
import 'package:flutter_deyton/modify_contac.dart';

class MyHomePage extends StatefulWidget {
  final String _title;
  MyHomePage(this._title);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MenuOrder> orders = [
    MenuOrder(dishName: 'Pizza', quantity: 2, unitPrice: 12.50),
    MenuOrder(dishName: 'Hamburguesa', quantity: 1, unitPrice: 8.00),
    MenuOrder(dishName: 'Tacos', quantity: 3, unitPrice: 10.00),
    MenuOrder(dishName: 'Sushi', quantity: 5, unitPrice: 15.00)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ModifyOrder(orders[index])))
                  .then((newOrder) {
                if (newOrder != null) {
                  setState(() {
                    orders.removeAt(index);
                    orders.insert(index, newOrder);

                    messageResponse(
                        context, newOrder.dishName + " ha sido modificado...!");
                  });
                }
              });
            },
            onLongPress: () {
              removeOrder(context, orders[index]);
            },
            title: Text(orders[index].dishName),
            subtitle: Text(
                'Cantidad: ${orders[index].quantity}, Precio: \$${orders[index].unitPrice.toStringAsFixed(2)}'),
            leading: CircleAvatar(
              child: Text(orders[index].dishName.substring(0, 1)),
            ),
            trailing: Icon(
              Icons.fastfood,
              color: Colors.green,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RegisterOrder()))
              .then((newOrder) {
            if (newOrder != null) {
              setState(() {
                orders.add(newOrder);
                messageResponse(
                    context, newOrder.dishName + " ha sido guardado...!");
              });
            }
          });
        },
        tooltip: "Agregar Pedido",
        child: Icon(Icons.add),
      ),
    );
  }

  removeOrder(BuildContext context, MenuOrder order) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Eliminar Pedido"),
              content: Text("¿Está seguro de eliminar el pedido de " +
                  order.dishName +
                  "?"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      orders.remove(order);
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "Eliminar",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ));
  }
}

class MenuOrder {
  var dishName;
  var quantity;
  var unitPrice;

  MenuOrder({this.dishName, this.quantity, this.unitPrice});
}
