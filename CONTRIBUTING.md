# Contributing to ShopHub

Thank you for your interest in contributing to ShopHub! This document provides guidelines and information for contributors.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.6.0 or higher)
- Dart SDK
- Git
- A code editor (VS Code, Android Studio, etc.)

### Setting Up Development Environment

1. **Fork the repository**
   - Click the "Fork" button on the GitHub repository page
   - Clone your forked repository locally

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/shophub.git
   cd shophub
   ```

3. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/shophub.git
   ```

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

5. **Set up Firebase**
   - Create your own Firebase project for development
   - Follow the setup instructions in the main README

## 📝 Development Guidelines

### Code Style
- Follow Dart/Flutter style guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

### Commit Messages
Use clear, descriptive commit messages:
```
feat: add product search functionality
fix: resolve image loading issue
docs: update README with new features
style: format code according to guidelines
```

### Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Write clean, well-documented code
   - Add tests if applicable
   - Update documentation if needed

3. **Test your changes**
   ```bash
   flutter test
   flutter analyze
   ```

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to the original repository on GitHub
   - Click "New Pull Request"
   - Select your branch and provide a clear description

## 🐛 Reporting Issues

### Bug Reports
When reporting bugs, please include:
- Clear description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Device/OS information

### Feature Requests
For new features, please include:
- Clear description of the feature
- Use case and benefits
- Any design mockups or examples

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── home.dart                 # Main home screen
├── models/                   # Data models
├── services/                 # Business logic
├── screens/                  # UI screens
└── widgets/                  # Reusable components
```

## 🧪 Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Writing Tests
- Write unit tests for business logic
- Write widget tests for UI components
- Aim for good test coverage

## 📚 Documentation

### Code Documentation
- Document public APIs
- Add inline comments for complex logic
- Keep README updated with new features

### API Documentation
- Document service methods
- Include parameter descriptions
- Provide usage examples

## 🔄 Release Process

1. Update version in `pubspec.yaml`
2. Update CHANGELOG.md
3. Create release tag
4. Deploy to platforms

## 📞 Getting Help

- Check existing issues and discussions
- Join our community discussions
- Contact maintainers for urgent issues

## 📋 Checklist for Contributors

Before submitting a PR, ensure:
- [ ] Code follows project style guidelines
- [ ] All tests pass
- [ ] Code is properly documented
- [ ] No breaking changes without discussion
- [ ] README updated if needed
- [ ] Commit messages are clear

## 🎉 Recognition

Contributors will be recognized in:
- CONTRIBUTORS.md file
- Release notes
- Project documentation

Thank you for contributing to ShopHub! 🚀
