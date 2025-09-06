# ShopHub - E-commerce Flutter App

A modern, responsive e-commerce application built with Flutter and Firebase. ShopHub allows users to browse products, manage authentication, and provides a seamless shopping experience across all devices.

## 🚀 Features

### Core Functionality
- **Product Display**: Browse all products from Firestore database
- **Real-time Updates**: Products automatically update when Firestore data changes
- **Responsive Design**: Optimized for mobile, tablet, and desktop screens
- **User Authentication**: Login and signup functionality with Firebase Auth
- **Cart Integration**: Add products to cart(only msg, with login verification)

### UI/UX Features
- **Modern Design**: Clean, professional interface with purple theme
- **Loading States**: Smooth loading indicators and error handling
- **Empty States**: User-friendly messages when no products are available
- **Responsive Grid**: 
  - Small screens (< 600px): 2 products per row
  - Medium screens (600px - 1000px): 3 products per row
  - Large screens (> 1000px): 4 products per row
- **Image Support**: Displays product images from URLs with fallback icons

## 📱 Screenshots

The app features a beautiful, modern interface with:
- Hero section with search functionality
- Product grid with responsive layout
- Authentication screens (Login/Signup)
- Loading and error states

## 🛠️ Tech Stack

- **Frontend**: Flutter 3.6.0+
- **Backend**: Firebase
- **Database**: Cloud Firestore
- **Authentication**: Firebase Auth
- **State Management**: Flutter StatefulWidget
- **UI Framework**: Material Design 3

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  firebase_core: ^2.27.1
  firebase_auth: ^4.17.9
  cloud_firestore: ^4.15.9

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.6.0 or higher)
- Dart SDK
- Firebase project
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd shophub
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication (Email/Password)
   - Enable Firestore Database
   - Place them in the appropriate platform folders

4. **Configure Firebase**
   - The `firebase_options.dart` file should be automatically generated
   - Ensure your Firebase project is properly linked

5. **Run the app**
   ```bash
   flutter run
   ```

## 🗂️ Project Structure

```
lib/
├── main.dart                 # App entry point and Firebase initialization
├── firebase_options.dart     # Firebase configuration
├── home.dart                 # Main home screen with product display
├── models/
│   └── product.dart          # Product data model
├── services/
│   ├── auth_service.dart     # Authentication service
│   └── product_service.dart  # Product data service (Firestore)
├── screens/
│   ├── login_screen.dart     # User login screen
│   └── signup_screen.dart    # User registration screen
└── widgets/
    └── product_card.dart     # Reusable product card component
```

## 🔧 Configuration

### Firestore Database Structure

Create a collection named `products` in your Firestore database with the following document structure:

```json
{
  "name": "Product Name",
  "description": "Product description",
  "price": 99.99,
  "rating": 4.5,
  "imageUrl": "https://example.com/image.jpg",
  "category": "Category Name"
}
```

### Authentication Setup

1. Go to Firebase Console → Authentication
2. Enable Email/Password authentication
3. Configure any additional settings as needed

## 🎨 Customization

### Theme Colors
The app uses a purple theme (`#8B5CF6`). To change colors, update the color values in:
- `lib/main.dart` (ThemeData)
- `lib/home.dart` (UI components)
- `lib/widgets/product_card.dart` (Product cards)

### Product Categories
Add new product categories by updating the `_getProductIcon()` method in `lib/widgets/product_card.dart`.

## 📱 Responsive Design

The app automatically adapts to different screen sizes:

- **Mobile (< 600px)**: 2 products per row
- **Tablet (600px - 1000px)**: 3 products per row  
- **Desktop (> 1000px)**: 4 products per row

## 🔐 Authentication Flow

1. **Unauthenticated Users**: Can browse products but need to login to add to cart
2. **Login Required**: Cart button shows login prompt for unauthenticated users
3. **Authenticated Users**: Can add products to cart and access full functionality

## 🛒 Cart Functionality

- **Login Verification**: Users must be logged in to add items to cart
- **Visual Feedback**: Success/error messages for cart actions
- **Quick Login**: Direct login access from cart prompts

## 🐛 Troubleshooting

### Common Issues

1. **Firebase Connection Issues**
   - Verify `firebase_options.dart` is properly generated
   - Check Firebase project configuration
   - Ensure internet connectivity

2. **Build Issues**
   - Run `flutter clean` and `flutter pub get`
   - Check Flutter and Dart SDK versions
   - Verify all dependencies are compatible

3. **Authentication Issues**
   - Ensure Firebase Auth is enabled
   - Check email/password authentication is configured
   - Verify user credentials


## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


Made with ❤️ using Flutter and Firebase