import 'package:flutter/material.dart';

class AppAboutDialog extends StatelessWidget {
  const AppAboutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'About App',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Version: 1.0.0',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'A modern chat application built with Flutter, featuring real-time local dummy messaging capabilities and a sleek user interface.',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    _buildSection('Key Features', [
                      '• Real-time messaging with instant updates',
                      '• Voice message support(Custom Message)',
                      '• Dynamic chat background themes',
                      '• Dark/Light mode toggle',
                      '• Custom chat bubbles',
                      '• Interactive feature tour with ShowcaseView',
                    ]),
                    _buildSection('Technical Stack', [
                      '• Flutter SDK: ^3.7.2',
                      '• BLoC pattern for state management',
                      '• Clean Architecture principles',
                      '• Responsive UI design',
                      '• Cross-platform support',
                    ]),
                    _buildSection('Key Packages', [
                      '• flutter_bloc: State management',
                      '• get_it: Dependency injection',
                      '• cached_network_image: Image caching',
                      '• intl: Internationalization',
                      '• showcaseview: Interactive feature tour',
                    ]),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        '© 2025 Manas Sogale. All rights reserved.',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(item, style: const TextStyle(fontSize: 13)),
          ),
        ),
      ],
    );
  }
}
