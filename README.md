# TrueScore - Unleashing Hidden Talent

A comprehensive Flutter application for AI-assisted performance tracking with disability-aware design, built for athletes, para-athletes, and sports officials.

## 🚀 Features

### Core Functionality
- **AI-Powered Performance Tracking**: Smart analysis and recommendations
- **Disability-Aware Design**: Inclusive features for para-athletes
- **Role-Based Dashboards**: Separate interfaces for athletes and officials
- **Comprehensive Accessibility**: High contrast, large fonts, text-to-speech
- **Gamification**: Points, badges, achievements, and leaderboards

### User Roles
1. **Athletes**: Performance tracking, portfolio building, progress monitoring
2. **Para-Athletes**: Adaptive tests, disability-specific features, classification support
3. **Officials**: Athlete discovery, evaluation tools, shortlisting capabilities

### Key Screens & Flows

#### 1. App Launch & Authentication
- **Splash Screen**: Animated logo with loading bar
- **Onboarding**: 4-slide carousel with accessibility features
- **Login/Signup**: Email, phone OTP, social logins
- **Role Selection**: Athlete, Para-Athlete, or Official

#### 2. Athlete Dashboard
- **Home Tab**: Motivational quotes, quick actions, progress overview
- **Tests Tab**: AI-guided performance tests with camera integration
- **Portfolio Tab**: Profile management, achievements, media uploads
- **Community Tab**: Social features, challenges, leaderboards
- **Settings Tab**: Accessibility toggles, account management

#### 3. Official Dashboard
- **Home Tab**: Overview stats, AI suggestions, recent activity
- **Search Tab**: Advanced athlete filtering and discovery
- **Events Tab**: Competition management and scheduling
- **Shortlist Tab**: Talent evaluation and management
- **Settings Tab**: Account and preference management

### 🎨 Design System

#### Color Themes
- **Athlete Theme**: Neon gradients, holographic effects
- **Official Theme**: Dark navy (#19183B) with gold accents
- **Accessibility Themes**: High contrast, color-blind friendly

#### Accessibility Features
- **Text-to-Speech**: Voice guidance and feedback
- **Large Fonts**: Scalable text sizing
- **High Contrast**: Enhanced visibility
- **Color Blind Friendly**: Accessible color palettes
- **Voice Navigation**: Audio-based interaction

### 🏗️ Technical Architecture

#### State Management
- **Provider**: Global state management
- **SharedPreferences**: Local data persistence
- **Firebase**: Authentication and cloud storage

#### AI & ML Integration
- **TensorFlow Lite**: On-device AI processing
- **Google ML Kit**: Pose detection and analysis
- **Camera Integration**: Real-time motion tracking

#### Accessibility Framework
- **ScreenUtil**: Responsive design
- **Custom Themes**: Dynamic theme switching
- **Accessibility Widgets**: Reusable accessible components

### 📱 Key Components

#### Models
- **User**: Base user model with role and preferences
- **Athlete**: Performance data, achievements, disability info
- **Official**: Organization, specializations, evaluations
- **Test**: Exercise definitions, AI settings, results
- **Notification**: System and user notifications

#### Services
- **Authentication**: Firebase Auth, Google/Apple Sign-In
- **Storage**: Firestore, Firebase Storage
- **AI Processing**: Pose detection, performance analysis
- **Notifications**: Local and push notifications

#### Widgets
- **Accessibility Toggle**: Comprehensive accessibility controls
- **Onboarding Pages**: Animated carousel slides
- **Dashboard Cards**: Role-specific information displays
- **Progress Indicators**: Animated progress tracking

### 🚀 Getting Started

#### Prerequisites
- Flutter SDK 3.9.2+
- Android Studio / VS Code
- Firebase project setup
- Camera permissions

#### Installation
```bash
# Clone the repository
git clone <repository-url>
cd truescore

# Install dependencies
flutter pub get

# Run the app
flutter run
```

#### Firebase Setup
1. Create a Firebase project
2. Enable Authentication, Firestore, and Storage
3. Add configuration files to `android/app/` and `ios/Runner/`
4. Configure OAuth providers (Google, Apple)

### 🎯 Future Enhancements

#### Phase 2 Features
- **AI-Guided Test Interface**: Real-time pose analysis
- **Portfolio Management**: Media uploads, certificate management
- **Gamification System**: Achievement tracking, leaderboards
- **Community Features**: Social interactions, challenges
- **Advanced Analytics**: Performance insights, recommendations

#### Technical Improvements
- **Offline Support**: Local data synchronization
- **Performance Optimization**: Image compression, caching
- **Security Enhancements**: Data encryption, secure storage
- **Testing**: Unit tests, integration tests, UI tests

### 📊 Project Structure

```
lib/
├── models/           # Data models and entities
├── screens/          # UI screens and pages
├── widgets/          # Reusable UI components
├── services/         # Business logic and API calls
├── providers/        # State management
├── theme/           # Design system and themes
├── utils/           # Helper functions and utilities
└── main.dart        # App entry point
```

### 🔧 Configuration

#### Environment Variables
- Firebase configuration
- API endpoints
- Feature flags
- Accessibility settings

#### Build Variants
- **Debug**: Development with hot reload
- **Release**: Production optimization
- **Profile**: Performance testing

### 📈 Performance Metrics

#### Target Performance
- **App Launch**: < 3 seconds
- **Screen Transitions**: < 300ms
- **AI Processing**: Real-time analysis
- **Accessibility**: Full WCAG 2.1 compliance

### 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Implement changes with tests
4. Submit a pull request
5. Follow accessibility guidelines

### 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

### 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Accessibility community for guidance
- Open source contributors

---

**TrueScore** - Empowering athletes through technology, one performance at a time. 🏆