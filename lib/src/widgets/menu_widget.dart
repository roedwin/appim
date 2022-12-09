import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/menu.jpeg'), fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text('Home'),
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
          ),
          ListTile(
            leading: Icon(
              Icons.people_alt_sharp,
              color: Colors.blue,
            ),
            title: Text('Usuarios'),
            onTap: () => Navigator.pushReplacementNamed(context, 'cobradores'),
          ),
          ListTile(
            leading: Icon(
              Icons.map,
              color: Colors.blue,
            ),
            title: Text('Zona'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.emoji_people_sharp,
              color: Colors.blue,
            ),
            title: Text('Clientes'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.attach_money,
              color: Colors.blue,
            ),
            title: Text('Cobros'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.library_books,
              color: Colors.blue,
            ),
            title: Text('Plan'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.money_off_csred_rounded,
              color: Colors.blue,
            ),
            title: Text('Incentivos'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.picture_as_pdf,
              color: Colors.blue,
            ),
            title: Text('Reporte'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            title: Text('Acerca de'),
            onTap: () => Navigator.pushReplacementNamed(context, 'settings'),
          ),
        ],
      ),
    );
    ;
  }
}
