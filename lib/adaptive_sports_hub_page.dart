import 'package:flutter/material.dart';

class AdaptiveSportsHubPage extends StatefulWidget {
  const AdaptiveSportsHubPage({super.key});

  @override
  State<AdaptiveSportsHubPage> createState() => _AdaptiveSportsHubPageState();
}

class _AdaptiveSportsHubPageState extends State<AdaptiveSportsHubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Dark background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title with icon
              _buildTitle(),
              const SizedBox(height: 24),
              // Welcome text
              _buildWelcomeText(),
              const SizedBox(height: 40),
              // Question
              _buildQuestion(),
              const SizedBox(height: 40),
              // Buttons
              _buildAthleteButton(),
              const SizedBox(height: 16),
              _buildParaAthleteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.person, color: Color(0xFF1A1A1A), size: 20),
        ),
        const SizedBox(width: 12),
        const Text(
          'Adaptive Sports Hub',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return const Text(
      'Welcome to the Hub. Please identify yourself:',
      style: TextStyle(fontSize: 16, color: Colors.white),
    );
  }

  Widget _buildQuestion() {
    return const Text(
      'Are you an athlete or a para-athlete?',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF3B82F6), // Blue color
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildAthleteButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // Handle athlete selection
          _handleAthleteSelection('Athlete');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6), // Blue
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Athlete',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildParaAthleteButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // Handle para-athlete selection
          _handleAthleteSelection('Para-Athlete');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B5CF6), // Purple
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Para-Athlete',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _handleAthleteSelection(String type) {
    // Show a snackbar or navigate to next page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You selected: $type'),
        backgroundColor: type == 'Athlete'
            ? const Color(0xFF3B82F6)
            : const Color(0xFF8B5CF6),
      ),
    );

    // You can add navigation logic here
    // For example, navigate to a registration form or dashboard
  }
}
