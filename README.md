# Common UI

A professional, reusable Flutter UI package providing well-designed, injection-friendly widgets following **SOLID principles**.

## Overview

`common_ui` provides a curated collection of production-ready widgets that streamline common UI patterns while maintaining clean architecture and flexibility. Each widget supports dependency injection for styling and behavior, making it easy to customize and test.

## Features

- 🎨 **CommonButton** – Flexible button widget with gradient support, loading states, and icon placement
- 📝 **CommonTextField** – Robust text input with built-in validators, input formatters, and custom styling
- 🖼️ **CommonUniversalImage** – Single widget for network, asset, file, or custom image sources
- ✅ **Built-in Validators** – Email, mobile, regex patterns, and custom validators
- 🎯 **SOLID Design** – Dependency injection, separation of concerns, and easy testing
- 📦 **Zero External Dependencies** – Minimal, focused dependencies (cached_network_image, flutter_cache_manager)
- 🔄 **Backward Compatible** – Deprecated aliases for smooth migrations

## Getting Started

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  common_ui:
    path: ./common_ui  # or version from pub.dev
```

Then run:

```bash
flutter pub get
```

### Basic Imports

```dart
import 'package:common_ui/common_ui.dart';
```

## Widgets

### 1. CommonButton

A flexible, styled button widget with support for gradients, loading states, and icons.

#### Basic Usage

```dart
CommonButton(
  text: 'Submit',
  onPressed: () {
    print('Button pressed!');
  },
)
```

#### With Custom Style

```dart
CommonButton(
  text: 'Login',
  onPressed: () => _handleLogin(),
  style: CommonButtonStyle(
    primaryColor: Colors.blue,
    secondaryColor: Colors.deepBlue,
    textColor: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  fontSize: 16,
  height: 56,
  borderRadius: 12,
  useGradient: true,
)
```

#### With Icons

```dart
CommonButton(
  text: 'Send',
  onPressed: () {},
  leadingIcon: const Icon(Icons.send, color: Colors.white),
  trailingIcon: const Icon(Icons.arrow_forward, color: Colors.white),
)
```

#### Loading State

```dart
CommonButton(
  text: 'Processing...',
  onPressed: () {},
  isLoading: isLoading,
  customLoadingWidget: SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
      strokeWidth: 2.5,
      valueColor: AlwaysStoppedAnimation(Colors.white),
    ),
  ),
)
```

#### Outline/Border Style

```dart
CommonButton(
  text: 'Cancel',
  onPressed: () {},
  isBorder: true,
  style: CommonButtonStyle(
    primaryColor: Colors.grey,
    borderColor: Colors.grey,
  ),
)
```

#### With Haptic Feedback

```dart
CommonButton(
  text: 'Tap Me',
  onPressed: () => print('Tapped!'),
  onFeedback: () => HapticFeedback.lightImpact(),
)
```

---

### 2. CommonTextField

A robust text field widget with built-in validation, formatting, and custom styling.

#### Basic Usage

```dart
CommonTextField(
  controller: _controller,
  title: 'Email',
  hintText: 'Enter your email',
)
```

#### With Validation

```dart
CommonTextField(
  controller: _emailController,
  title: 'Email',
  hintText: 'user@example.com',
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Email is required';
    if (!AppRegex.email.hasMatch(value!)) {
      return 'Please enter a valid email';
    }
    return null;
  },
)
```

#### With Input Formatters

```dart
CommonTextField(
  controller: _phoneController,
  title: 'Phone Number',
  keyboardType: TextInputType.phone,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
  ],
)
```

#### Custom Style

```dart
CommonTextField(
  controller: _controller,
  title: 'Username',
  style: CommonTextFieldStyle(
    borderColor: Colors.blue,
    fillColor: Colors.grey[100],
    borderRadius: 12,
  ),
)
```

#### Password Field

```dart
CommonTextField(
  controller: _passwordController,
  title: 'Password',
  obscureText: true,
  suffix: IconButton(
    icon: Icon(Icons.visibility),
    onPressed: () {},
  ),
)
```

---

### 3. CommonUniversalImage

A unified widget for displaying images from multiple sources with automatic placeholder and error handling.

#### Network Image

```dart
CommonUniversalImage(
  imageUrl: 'https://example.com/image.jpg',
  height: 200,
  width: 200,
  fit: BoxFit.cover,
)
```

#### Asset Image

```dart
CommonUniversalImage(
  assetPath: 'assets/images/logo.png',
  height: 100,
  width: 100,
)
```

#### File from Device

```dart
import 'dart:io';

File pickedFile = /* image from image_picker */;

CommonUniversalImage(
  file: pickedFile,
  height: 150,
  width: 150,
  fit: BoxFit.cover,
)
```

#### Custom ImageProvider

```dart
CommonUniversalImage(
  imageProvider: MemoryImage(imageBytes),
  height: 100,
  width: 100,
)
```

#### With Custom Placeholder/Error

```dart
CommonUniversalImage(
  imageUrl: 'https://example.com/image.jpg',
  errorWidget: Container(
    color: Colors.grey[200],
    child: Center(
      child: Icon(Icons.broken_image, color: Colors.grey),
    ),
  ),
  isShowLoader: true,
  borderRadius: 8,
)
```

#### Custom Border Radius

```dart
CommonUniversalImage(
  assetPath: 'assets/avatar.png',
  height: 80,
  width: 80,
  borderRadius: 40, // Circular
)
```

---

## Validators

Pre-built validators for common use cases:

```dart
import 'package:common_ui/common_ui.dart';

// Email validation
String? emailError = AppValidators.email('user@example.com');

// Mobile validation (10 digits)
String? mobileError = AppValidators.mobile('9876543210');

// Required field validation
String? requiredError = AppValidators.required(value, 'Field name');

// Regex validation
String? regexError = AppValidators.regex(
  value,
  AppRegex.panCard,
  'Invalid PAN format',
);
```

### Available Regex Patterns

```dart
AppRegex.email;           // Email pattern
AppRegex.mobile;          // 10-digit mobile
AppRegex.panCard;         // Indian PAN card
AppRegex.aadhaar;         // 12-digit Aadhaar
AppRegex.voterId;         // Voter ID
AppRegex.ifsc;            // IFSC bank code
AppRegex.bankAccount;     // Bank account number
AppRegex.pinCode;         // 6-digit PIN
AppRegex.passwordStrong;  // Strong password (8+ chars, uppercase, lowercase, digit, special)
AppRegex.name;            // Alphanumeric with common special chars
```

### Input Formatters

```dart
// No spaces allowed
final noSpaceFormatter = NoSpaceInputFormatter();

// Alphabetic characters only
final alphabeticFormatter = alphabeticInputFormatter;

// Combine multiple formatters
inputFormatters: [
  FilteringTextInputFormatter.digitsOnly,
  LengthLimitingTextInputFormatter(10),
]
```

---

## SOLID Principles

This package follows SOLID design principles for maintainability and testability:

- **S (Single Responsibility)**: Each widget handles rendering; styling/validation are injected
- **O (Open/Closed)**: New styles and validators can be added via `Style` objects and callbacks
- **L (Liskov Substitution)**: Deprecated aliases extend the primary widgets
- **I (Interface Segregation)**: Minimal, focused parameters; style models group related properties
- **D (Dependency Injection)**: Style objects, validators, and callbacks passed as constructor params

### Example: Extending with Custom Style

```dart
final customStyle = CommonButtonStyle(
  primaryColor: Colors.purple,
  secondaryColor: Colors.deepPurple,
  textColor: Colors.white,
);

CommonButton(
  text: 'Custom',
  onPressed: () {},
  style: customStyle,
)
```

---

## Migration Guide

### From `CommonImage` to `CommonUniversalImage`

Old (deprecated):
```dart
CommonImage(imageUrl: 'https://...')
```

New:
```dart
CommonUniversalImage(imageUrl: 'https://...')
```

Both work, but `CommonUniversalImage` is preferred.

---

## Common Issues

### Asset "placeholder.webp" not found

**Solution:** The `common_ui` package includes a default placeholder. Ensure:
1. You've run `flutter pub get`
2. The asset is bundled correctly (it's auto-included)

### Undefined color/size references

**Solution:** This package doesn't assume your app's color scheme. Always pass colors explicitly:

```dart
CommonButtonStyle(primaryColor: Colors.blue)
```

---

## Contributing

Contributions are welcome! Please:

1. Follow the existing code style and SOLID principles
2. Add/update documentation comments for new features
3. Test widgets in isolation before submitting
4. Keep the package dependency-light

---

## License

This package is part of the common_ui project.

---

## Support

For issues, questions, or feature requests, please open an issue on the project repository.
