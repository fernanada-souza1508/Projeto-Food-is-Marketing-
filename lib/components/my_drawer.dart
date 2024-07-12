import "package:flutter/material.dart";
import "package:minimalstore2/themes/theme_provider.dart";
import "package:minimalstore2/themes/themes.dart";
import "package:provider/provider.dart";
import "my_list_tile.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        //muda a cor do my drawer//
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                DrawerHeader(
                    child: Center(
                        child: Image.asset(
                          'logo.png'
                ))),

                const SizedBox(height: 25),
                MyListTile(
                  text: "Comprar",
                  icon: Icons.home,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/shop_page");
                  },
                ),
                MyListTile(
                    text: "Carrinho",
                    icon: Icons.shopping_cart,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/cart_page");
                    })
              ]),
              Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    children: [
                      MyListTile(
                          text: "Sair",
                          icon: Icons.logout,
                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                              context, "/intro_page", (route) => false)),
                              MyListTile(
                                text: theme == lightMode ? "Modo Escuro" 
                                : "Modo Claro" ,
                              icon: theme == lightMode
                              ? Icons.toggle_on_outlined
                              : Icons.toggle_off_outlined,
                               onTap:() {
                                Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme();
                               })
                    ],
                  ))
            ]));
  }
}
