import 'package:exam/core/home_repo.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  int cartCount = 0;
  HomeRepo homeRepo;
  List<dynamic> products = [];
  bool isLoading = false;
  Map<int, int> addedProducts = {};
  String? errorMessage;

  HomeProvider({required this.homeRepo}) {
    loadProducts();
  }

  void addToCart() {
    cartCount++;
    notifyListeners();
  }

  void deleteFromCart() {
    cartCount--;
    notifyListeners();
  }

  void addProduct(int productId) {
    addedProducts[productId] = (addedProducts[productId] ?? 0) + 1;
    addToCart();
    notifyListeners();
  }

  void removeProduct(int productId) {
    if (addedProducts[productId]! > 1) {
      addedProducts[productId] = addedProducts[productId]! - 1;
    } else {
      addedProducts.remove(productId);
    }
    deleteFromCart();
    notifyListeners();
  }

  void delete(int productId) {
    cartCount -= addedProducts[productId]!;
    addedProducts.remove(productId);
    notifyListeners();
  }

  int getQuantity(int productId) {
    return addedProducts[productId] ?? 0;
  }

  List<dynamic> getCartProducts() {
    return products.where((product) {
      return addedProducts.containsKey(product['id']);
    }).toList();
  }

  double getTotalPrice() {
    double total = 0;
    for (var product in products) {
      int productId = product['id'];
      if (addedProducts.containsKey(productId)) {
        int quantity = addedProducts[productId]!;
        total += product['price'] * quantity;
      }
    }
    return total;
  }

  Future<void> loadProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      products = await homeRepo.getProducts();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to load products: ${e.toString()}';
      notifyListeners();
    }
  }
}
