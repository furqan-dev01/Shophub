
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'products';

  // Get all products from Firestore
  static Stream<List<Product>> getAllProducts() {
    return _firestore
        .collection(_collectionName)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  // Get all products as a Future (for one-time fetch)
  static Future<List<Product>> getAllProductsOnce() async {
    try {
      final snapshot = await _firestore.collection(_collectionName).get();
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      // Error fetching products: $e
      return [];
    }
  }

  // Get featured products (for backward compatibility)
  static List<Product> getFeaturedProducts() {
    return [
      const Product(
        id: '1',
        name: 'Premium Wireless Headphones',
        description: 'High-quality wireless headphones with noise cancellation and premium audio quality.',
        price: 299.99,
        rating: 4.8,
        imageUrl: 'assets/images/headphones.png',
        category: 'Audio',
      ),
      const Product(
        id: '2',
        name: 'Smart Watch Pro',
        description: 'Advanced smartwatch with health monitoring, GPS, and premium build quality.',
        price: 399.99,
        rating: 4.7,
        imageUrl: 'assets/images/smartwatch.png',
        category: 'Wearables',
      ),
      const Product(
        id: '3',
        name: 'Ultra Laptop',
        description: 'Powerful ultrabook with premium design, long battery life, and high performance.',
        price: 1299.99,
        rating: 4.9,
        imageUrl: 'assets/images/laptop.png',
        category: 'Computers',
      ),
      const Product(
        id: '4',
        name: 'Wireless Speaker',
        description: 'Portable wireless speaker with exceptional sound quality and long battery life.',
        price: 199.99,
        rating: 4.6,
        imageUrl: 'assets/images/speaker.png',
        category: 'Audio',
      ),
    ];
  }

  // Add a product to Firestore
  static Future<void> addProduct(Product product) async {
    try {
      await _firestore.collection(_collectionName).add(product.toMap());
    } catch (e) {
      // Error adding product: $e
      rethrow;
    }
  }

  // Update a product in Firestore
  static Future<void> updateProduct(String productId, Product product) async {
    try {
      await _firestore.collection(_collectionName).doc(productId).update(product.toMap());
    } catch (e) {
      // Error updating product: $e
      rethrow;
    }
  }

  // Delete a product from Firestore
  static Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection(_collectionName).doc(productId).delete();
    } catch (e) {
      // Error deleting product: $e
      rethrow;
    }
  }
}
