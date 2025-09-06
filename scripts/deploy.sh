#!/bin/bash

# ShopHub Deployment Script
echo "🚀 Deploying ShopHub..."

# Build for web
echo "🌐 Building for web..."
flutter build web --release --base-href="/shophub/"

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Web build successful!"
    echo "📁 Build files are in build/web/"
    echo ""
    echo "For GitHub Pages deployment:"
    echo "1. Push your changes to the main branch"
    echo "2. GitHub Actions will automatically deploy to Pages"
    echo "3. Your app will be available at: https://YOUR_USERNAME.github.io/shophub/"
else
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi
