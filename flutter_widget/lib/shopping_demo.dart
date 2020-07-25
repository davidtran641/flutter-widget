import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Product {
  const Product({this.name});

  final String name;
}

class ShoppingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShoppingList(
      products: <Product>[
        Product(name: 'Eggs'),
        Product(name: 'Flour'),
        Product(name: 'Chocolate chips'),
      ],
    );
  }
}

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();

  @override
  void initState() {
    print("_ShoppingListState initState");
    super.initState();
  }

  @override
  void dispose() {
    print("_ShoppingListState disposed");
    super.dispose();
  }

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (!inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  int _numItem() {
    return _shoppingCart.length;
  }

  @override
  Widget build(BuildContext context) {
    print("_ShoppingListState build");
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(icon: Icon(Icons.favorite),  onPressed: (){},),
              Container(
                child: Text("${_shoppingCart.length}"),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(8),
              )
            ],
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

// Items
typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({this.product, this.inCart, this.onCartChanged})
      : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }
}
