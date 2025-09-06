#!/bin/bash

# ShopHub Setup Script
echo "🚀 Setting up ShopHub project..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Check Flutter version
echo "📱 Flutter version:"
flutter --version

# Get dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Check for Firebase configuration
if [ ! -f "lib/firebase_options.dart" ]; then
    echo "⚠️  Firebase configuration not found."
    echo "Please run 'flutterfire configure' to set up Firebase."
fi

# Run analysis
echo "🔍 Running code analysis..."
flutter analyze

# Run tests
echo "🧪 Running tests..."
flutter test

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Configure Firebase (if not done already)"
echo "2. Run 'flutter run' to start the app"
echo "3. For web deployment, push to main branch"
