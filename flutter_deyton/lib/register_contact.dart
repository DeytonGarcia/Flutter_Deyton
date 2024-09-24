import 'package:flutter_deyton/my_home_page.dart';
import 'package:flutter_deyton/text_box.dart';
import 'package:flutter/material.dart';

class RegisterOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterOrder();
}

class _RegisterOrder extends State<RegisterOrder> {
  late TextEditingController controllerDishName;
  late TextEditingController controllerQuantity;
  late TextEditingController controllerUnitPrice;

  @override
  void initState() {
    controllerDishName = new TextEditingController();
    controllerQuantity = new TextEditingController();
    controllerUnitPrice = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registrar Pedido de Menú"),
        ),
        body: ListView(
          children: [
            TextBox(controllerDishName, "Nombre del Plato"),
            TextBox(controllerQuantity, "Cantidad"),
            TextBox(controllerUnitPrice, "Precio Unitario"),
            ElevatedButton(
                onPressed: () {
                  String dishName = controllerDishName.text;
                  String quantity = controllerQuantity.text;
                  String unitPrice = controllerUnitPrice.text;

                  if (dishName.isNotEmpty &&
                      quantity.isNotEmpty &&
                      unitPrice.isNotEmpty) {
                    Navigator.pop(
                        context,
                        new MenuOrder(
                            dishName: dishName,
                            quantity: int.tryParse(quantity) ?? 0,
                            unitPrice: double.tryParse(unitPrice) ?? 0.0));
                  }
                },
                child: Text("Guardar Pedido")),
          ],
        ));
  }
}
