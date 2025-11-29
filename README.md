# DOCUMENT_SCANNER_APP

*Scan, Extract, Export - Your Pocket Document Assistant*

![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-000000?style=for-the-badge)

**Built with the tools and technologies:**

![Google ML Kit](https://img.shields.io/badge/Google_ML_Kit-4285F4?style=flat-square&logo=google&logoColor=white)
![PDF](https://img.shields.io/badge/PDF-EC1C24?style=flat-square&logo=adobeacrobatreader&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-02569B?style=flat-square&logo=flutter&logoColor=white)
![Google Fonts](https://img.shields.io/badge/Google_Fonts-4285F4?style=flat-square&logo=google&logoColor=white)

---

## Table of Contents

- [Overview](#overview)
- [Why Document Scanner App?](#why-document-scanner-app)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

**Document Scanner App** is a modern, powerful Flutter application that transforms your mobile device into a professional document scanner. Capture documents using your camera or gallery, extract text instantly with OCR technology, and export results as PDF files - all with a premium, intuitive interface.

### Key Features

- 📸 **Smart Scanning**: Capture documents using camera or pick from gallery
- 🔍 **OCR Technology**: Extract text from images using Google ML Kit
- 📄 **PDF Export**: Convert extracted text into professional PDF documents
- 🎨 **Modern UI**: Beautiful interface with Deep Indigo & Teal color palette
- 🌓 **Dark Mode**: Full support for light and dark themes
- ⚡ **Smooth Animations**: Engaging transitions powered by Flutter Animate
- 📋 **Clipboard Support**: Quick copy-to-clipboard functionality
- 🔒 **Privacy First**: All processing happens on-device

---

## Why Document Scanner App?

In today's digital world, quickly digitizing physical documents is essential. This app provides:

- **Speed**: Instant text extraction without manual typing
- **Accuracy**: Powered by Google's ML Kit for reliable OCR
- **Convenience**: All-in-one solution for scanning, extracting, and exporting
- **Privacy**: No cloud processing - your documents stay on your device
- **Professional Output**: Clean, formatted PDF exports ready to share

---

## Architecture

The app follows a clean architecture pattern with clear separation of concerns:

```
lib/
├── main.dart                 # App entry point
├── providers/                # State management
│   ├── theme_provider.dart
│   ├── image_provider.dart
│   ├── ocr_provider.dart
│   └── pdf_provider.dart
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── settings_screen.dart
│   ├── image_picker_screen.dart
│   ├── text_recognition_screen.dart
│   └── pdf_export_screen.dart
├── utils/                    # Utilities
│   ├── pdf_utils.dart
│   └── file_utils.dart
└── services/                 # Business logic
    └── permissions.dart
```

### Tech Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: Provider
- **OCR Engine**: Google ML Kit
- **PDF Generation**: pdf package
- **Image Handling**: image_picker
- **Animations**: flutter_animate
- **Typography**: google_fonts
- **Storage**: shared_preferences

---

## Getting Started

### Prerequisites

Before you begin, ensure you have:

- Flutter SDK (version 3.0.0 or higher)
- Dart SDK (version 2.17.0 or higher)
- Android Studio / VS Code with Flutter extensions
- A physical device or emulator for testing

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/OsmanMj/document_scanner_pdf_exporter.git
   cd document_scanner_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

4. **Build for production**

   ```bash
   # Android
   flutter build apk --release
   
   # iOS
   flutter build ios --release
   ```

---

## Usage

### Scanning a Document

1. Launch the app and tap **"Upload Image"** or **"Scan Image"**
2. Choose to capture with camera or select from gallery
3. The app automatically processes the image

### Extracting Text

1. After selecting an image, navigate to the text recognition screen
2. View the extracted text instantly
3. Toggle image visibility with the **Show/Hide Image** button
4. Copy text to clipboard with one tap

### Exporting to PDF

1. From the text recognition screen, tap **"Export as PDF"**
2. Review the extracted text
3. Tap **"Save as PDF"** to export
4. Choose your save location

### Customizing Theme

1. Navigate to **Settings** from the home screen
2. Toggle between Light and Dark modes
3. Theme preference is saved automatically

---

## Project Structure

### Key Components

#### Providers
- **ThemeProvider**: Manages app theme (light/dark mode)
- **ImageProviderClass**: Handles image selection and storage
- **OcrProvider**: Manages text recognition operations
- **PdfProvider**: Handles PDF generation and export

#### Screens
- **SplashScreen**: Animated app launch screen
- **HomeScreen**: Dashboard with action cards
- **SettingsScreen**: Theme customization
- **ImagePickerScreen**: Image capture/selection
- **TextRecognitionScreen**: OCR results display
- **PdfExportScreen**: PDF preview and export

#### Utils
- **PdfUtils**: PDF document generation logic
- **FileUtils**: File system operations

---

## Screenshots

| Home Screen | Dark Mode | Text Recognition | PDF Export |
|:---:|:---:|:---:|:---:|
| ![Home Screen](assets/screenshots/home.jpg) | ![Dark Mode](assets/screenshots/dark.jpg) | ![Text Recognition](assets/screenshots/ocr.jpg) | ![PDF Export](assets/screenshots/pdf.jpg) |

---

## Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/AmazingFeature`)
3. **Commit your changes** (`git commit -m 'Add some AmazingFeature'`)
4. **Push to the branch** (`git push origin feature/AmazingFeature`)
5. **Open a Pull Request**

### Guidelines

- Follow Flutter best practices
- Maintain code formatting with `flutter format`
- Add tests for new features
- Update documentation as needed

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Made with ❤️ using Flutter**
