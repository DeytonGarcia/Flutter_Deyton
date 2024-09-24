import 'package:flutter_deyton/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deyton/text_box.dart';

class ModifyOrder extends StatefulWidget {
  final MenuOrder _menuOrder;
  ModifyOrder(this._menuOrder);

  @override
  State<StatefulWidget> createState() => _ModifyOrderState();
}

class _ModifyOrderState extends State<ModifyOrder> {
  late TextEditingController controllerDishName;
  late TextEditingController controllerQuantity;
  late TextEditingController controllerUnitPrice;

  @override
  void initState() {
    MenuOrder order = widget._menuOrder;
    controllerDishName = TextEditingController(text: order.dishName);
    controllerQuantity = TextEditingController(text: order.quantity.toString());
    controllerUnitPrice = TextEditingController(text: order.unitPrice.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar Pedido de Menú"),
      ),
      body: ListView(
        children: [
          TextBox(controllerDishName, "Nombre del Plato"),
          TextBox(controllerQuantity, "Cantidad"),
          TextBox(controllerUnitPrice, "Precio Unitario"),
          ElevatedButton(
              onPressed: () {
                String dishName = controllerDishName.text;
                int quantity = int.tryParse(controllerQuantity.text) ?? 0;
                double unitPrice = double.tryParse(controllerUnitPrice.text) ?? 0.0;

                if (dishName.isNotEmpty && quantity > 0 && unitPrice > 0) {
                  Navigator.pop(
                    context,
                    MenuOrder(
                      dishName: dishName,
                      quantity: quantity,
                      unitPrice: unitPrice,
                    ),
                  );
                }
              },
              child: Text("Guardar Pedido")),
        ],
      ),
    );
  }
}
