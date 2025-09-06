import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/product.dart';
import 'services/product_service.dart';
import 'services/auth_service.dart';
import 'widgets/product_card.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchFocused = false;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Helper method to handle cart button click with authentication check
  void _handleAddToCart(Product product) {
    // Check if user is logged in
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User not logged in - show login message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please login first to add items to cart'),
          backgroundColor: Colors.orange,
          action: SnackBarAction(
            label: 'Login',
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
        ),
      );
    } else {
      // User is logged in - add to cart
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} added to cart!'),
          backgroundColor: const Color(0xFF8B5CF6),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: const Color(0xFFFAFAFA), // Light grey background
          body: Column(
            children: [
              // Fixed Header Section
              SafeArea(
                bottom: false,
                child: _buildHeader(snapshot.hasData, snapshot.data),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Hero Section
                      _buildHeroSection(),

                      const SizedBox(height: 60),

                      // Featured Products Section
                      _buildFeaturedProductsSection(),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isLoggedIn, User? user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5CF6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'ShopHub',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B5CF6),
                  ),
                ),
              ],
            ),

            // Center section - Welcome message when logged in, empty when not
            if (isLoggedIn && user != null) ...[
              Expanded(
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome back! ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                        TextSpan(
                          text: user.email ?? 'User',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ] else ...[
              // Empty space when not logged in
              Expanded(child: SizedBox()),
            ],

            // Right section - Conditional buttons based on login status
            if (!isLoggedIn) ...[
              // Login/Signup buttons when not logged in
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.person_outline,
                      size: 18,
                      color: Color(0xFF6B7280),
                    ),
                    label: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              // Logout button when logged in (with same design as Sign Up)
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _authService.signOut();
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error signing out: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),

          // Main heading
          const Text(
            'Discover Amazing Products',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B5CF6),
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Description text
          const Text(
            'Shop the latest tech products with premium quality and exceptional design.',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          const Text(
            'Find everything you need in one place.',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          // Search bar and filter button - Responsive Layout
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              final isSmallScreen = availableWidth < 500;

              if (isSmallScreen) {
                // Stack vertically on very small screens
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isSearchFocused
                              ? const Color(0xFF8B5CF6)
                              : const Color(0xFFE5E7EB),
                          width: _isSearchFocused ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _isSearchFocused
                                ? const Color(0xFF8B5CF6).withValues(alpha: 0.2)
                                : Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Icon(
                            Icons.search,
                            color: _isSearchFocused
                                ? const Color(0xFF8B5CF6)
                                : const Color(0xFF9CA3AF),
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onTap: () {
                                setState(() {
                                  _isSearchFocused = true;
                                });
                              },
                              onTapOutside: (event) {
                                setState(() {
                                  _isSearchFocused = false;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Search products...',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF374151),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5CF6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: const Text(
                          'Filter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // Horizontal layout for larger screens
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                          availableWidth * 0.8, // Use 80% of available width
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _isSearchFocused
                                    ? const Color(0xFF8B5CF6)
                                    : const Color(0xFFE5E7EB),
                                width: _isSearchFocused ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: _isSearchFocused
                                      ? const Color(0xFF8B5CF6).withValues(alpha: 0.2)
                                      : Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                Icon(
                                  Icons.search,
                                  color: _isSearchFocused
                                      ? const Color(0xFF8B5CF6)
                                      : const Color(0xFF9CA3AF),
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    onTap: () {
                                      setState(() {
                                        _isSearchFocused = true;
                                      });
                                    },
                                    onTapOutside: (event) {
                                      setState(() {
                                        _isSearchFocused = false;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Search products...',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF9CA3AF),
                                        fontSize: 16,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF374151),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 20,
                            ),
                            label: const Text(
                              'Filter',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProductsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Products',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF374151),
                ),
              ),
              StreamBuilder<List<Product>>(
                stream: ProductService.getAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${snapshot.data!.length} products',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Product Cards Grid - Responsive Layout with StreamBuilder
          StreamBuilder<List<Product>>(
            stream: ProductService.getAllProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Color(0xFF9CA3AF),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading products: ${snapshot.error}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9CA3AF),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {}); // Refresh the stream
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B5CF6),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: Color(0xFF9CA3AF),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No products available',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Check back later for new products!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final products = snapshot.data!;

              return LayoutBuilder(
                builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;

                  // Determine layout based on screen size
                  if (availableWidth < 600) {
                    // Small screens: 2 products per row
                    return Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: products.map((product) {
                        return SizedBox(
                          width: (availableWidth - 20) / 2, // Two cards per row
                          child: ProductCard(
                            product: product,
                            onAddToCart: () => _handleAddToCart(product),
                          ),
                        );
                      }).toList(),
                    );
                  } else if (availableWidth < 1000) {
                    // Medium screens: 3 products per row
                    return Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: products.map((product) {
                        return SizedBox(
                          width: (availableWidth - 40) / 3, // Three cards per row
                          child: ProductCard(
                            product: product,
                            onAddToCart: () => _handleAddToCart(product),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    // Large screens: 4 products per row
                    return Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: products.map((product) {
                        return SizedBox(
                          width: (availableWidth - 60) / 4, // Four cards per row
                          child: ProductCard(
                            product: product,
                            onAddToCart: () => _handleAddToCart(product),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
