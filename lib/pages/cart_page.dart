import "package:minimalstore2/components/my_button.dart";
import "package:minimalstore2/models/product.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../components/my_drawer.dart";
import "../models/shop.dart";

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeItemfromCart(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Deseja remover esse item do carrinho?"),
        actions: [
          //botão cancelar
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          //botão confirmar
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);

              context.read<Shop>().removeFromCart(product);
            },
            child: const Text("Confirmar"),
          ),
        ],
      ),
    );
  }

  //Função para adicionar item ao carrinho
  void addItemToCart(BuildContext context, Product product) {
    context.read<Shop>().addToCart(product);
  }

  //diminuir itens no carrinho
  void decreaseItemToCart(BuildContext context, Product product) {
    context.read<Shop>().decrementFromCart(product);
  }

  void payButtonPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
            content:
                Text("Logo conectaremos esse app a uma solução de pagamento")));
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;

    double totalBill = cart.fold<double>(
        0, (previousValue, element) => previousValue + (element.totalPrice));
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Color.fromARGB(255, 209, 47, 47),
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Carrinho"),
          actions: [
            //botão carrinho de compras
            IconButton(
                onPressed: () => Navigator.pushNamed(context, "/shop_page"),
                icon: const Icon(Icons.home_outlined))
          ],
        ),
        drawer: const MyDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(children: [
          //listar o carrinho

          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Seu carrinho está vazio"),
                      Icon(Icons.mood_bad)
                    ],
                  ))
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];

                      return ListTile(
                          leading: Image.network(item.imagePath),
                          title: Text(item.name),
                          subtitle: Text(item.price.toStringAsFixed(2)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //botão remover do carrinho
                              IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () =>
                                      removeItemfromCart(context, item)),
                              //botão dimuir quantidade do carrinho
                              IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: item.quantity >= 2
                                      ? () => decreaseItemToCart(context, item)
                                      : () =>
                                          removeItemfromCart(context, item)),
                              //quantidade de itens no carrinho
                              Text(item.quantity.toString()),
                              //adicionar itens no carrinho
                              IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => addItemToCart(context, item))
                            ],
                          ));
                    }),
          ),

          //Botão de Pagamento
          Visibility(
            visible: cart.isNotEmpty,
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total R\$ ${totalBill.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                        MyButton(
                            onTap: () => payButtonPressed(context),
                            child: const Text("Pagamento")),
                      ],
                    ))),
          )
        ]));
  }
}
