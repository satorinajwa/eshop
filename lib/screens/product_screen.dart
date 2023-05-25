import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import '../datas/cart_product.dart';
import '../datas/product_data.dart';
import '../models/cart_model.dart';
import '../models/user_model.dart';
import 'cart_screen.dart';
import 'login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  String size;
  final ProductData product;
  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text(
          product.title,
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) => NetworkImage(url)).toList(),
              dotSize: 9.0,
              dotSpacing: 16.0,
              dotBgColor: Colors.transparent,
              dotColor: Colors.pink,
              autoplay: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tailles disponibles',
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 32,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 6,
                      childAspectRatio: 0.6,
                    ),
                    children: product.sizes
                        .map(
                          (clothingSize) => GestureDetector(
                            onTap: () {
                              setState(() {
                                size = clothingSize;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                border: Border.all(
                                  color: clothingSize == size
                                      ? Colors.pink
                                      : Colors.grey[600],
                                  width: 3,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(clothingSize),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: size != null
                        ? () {
                            if (UserModel.of(context).isLoggedIn) {
                              var cartProduct = CartProduct();
                              cartProduct.size = size;
                              cartProduct.quantity = 1;
                              cartProduct.productId = product.id;
                              cartProduct.category = product.category;
                              cartProduct.productData = product;
                              CartModel.of(context).addCartItem(cartProduct);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn
                          ? 'AJOUTER AU PANIER'
                          : 'ENTRER POUR ACHETER',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
