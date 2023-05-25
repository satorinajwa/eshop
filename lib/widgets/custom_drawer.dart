import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/user_model.dart';
import '../screens/login_screen.dart';
import '../tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[100],
                Colors.grey[50],
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.only(top: 20),
                height: 160,
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'Eshop',
                        style: TextStyle(
                          fontFamily: 'Cookie',
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                // ignore: lines_longer_than_80_chars
                                'Bonjour, ${!model.isLoggedIn ? '' : model.userData['name']}',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn
                                      ? 'Se connecter ou inscrire'
                                      : 'Sortir',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  if (!model.isLoggedIn) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  } else {
                                    model.signOut();
                                  }
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.pink),
              DrawerTile(
                Icons.home,
                'Commencer',
                pageController,
                0,
              ),
              DrawerTile(
                Icons.list,
                'Products',
                pageController,
                1,
              ),
              DrawerTile(
                Icons.location_on,
                'Store',
                pageController,
                2,
              ),
              DrawerTile(
                Icons.shopping_cart,
                'Orders',
                pageController,
                3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
