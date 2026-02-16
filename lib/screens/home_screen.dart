import 'package:exam/provider/home_provider.dart';
import 'package:exam/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'Home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: false,
        title: Image.asset('assets/logo.png', width: 86, height: 41),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    'assets/shopping_basket.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                if (homeProvider.cartCount > 0)
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${homeProvider.cartCount}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              'Recommendations',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: homeProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : homeProvider.errorMessage != null
                  ? Center(
                      child: Text(
                        homeProvider.errorMessage!,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : homeProvider.products.isEmpty
                  ? Center(
                      child: Text(
                        'No products available',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : GridView.builder(
                      itemCount: homeProvider.products.length,
                      itemBuilder: (context, index) {
                        var product = homeProvider.products[index];
                        int productId = product['id'];
                        int quantity = homeProvider.getQuantity(productId);
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEBEBEB),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Image.network(
                                    product['image'],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(
                                          Icons.photo,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  product['title'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                                child: Row(
                                  spacing: 4,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      "${product['rating']['rate']}",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "(${product['rating']['count']} reviews)",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${product['price']} EGP",
                                      style: TextStyle(fontWeight: FontWeight.bold,),
                                    ),
                                    quantity > 0
                                        ? Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(
                                                color: Color(0xFFF4F4F4),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    homeProvider.removeProduct(productId,);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFEBEBEB),
                                                      borderRadius: BorderRadius.circular(4,),
                                                    ),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.black,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                                                  child: Text(
                                                    '$quantity',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    homeProvider.addProduct(productId,);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF004AAC),
                                                      borderRadius: BorderRadius.circular(4,),
                                                    ),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : IconButton(
                                            icon: ImageIcon(
                                              AssetImage('assets/add_to_cart.png',),
                                              color: Color(0xFF004AAC),
                                            ),
                                            onPressed: () {
                                              homeProvider.addProduct(
                                                productId,
                                              );

                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(28,),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(16,),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            product['title'],
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 16,
                                                              color: Colors.black,
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          SizedBox(height: 8),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Added to cart',
                                                                style: TextStyle(
                                                                  color: Colors.grey,
                                                                ),
                                                              ),
                                                              SizedBox(width: 4,),
                                                              Image.asset(
                                                                'assets/check_mark.png',
                                                                width: 24,
                                                                height: 24,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 24),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pushNamed(context, CartScreen.routeName,);
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(16,),
                                                                    color: Color(0xFF004AAC,),
                                                                  ),
                                                              child: Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(16.0,),
                                                                  child: Text(
                                                                    'View Cart',
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Colors.white,
                                                                      fontSize: 18,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 16),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(context,);
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(16,),
                                                                color: Colors.white,
                                                                border: Border.all(
                                                                  color: Color(0xFF004AAC,),
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(16.0,),
                                                                  child: Text(
                                                                    'Continue Shopping',
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Color(0xFF004AAC,),
                                                                      fontSize: 18,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
