import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_application/widgets/about_dialog_widget.dart';
import 'package:showcaseview/showcaseview.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onThemeToggle;
  final VoidCallback onBackgroundChange;
  final bool isDarkMode;
  final GlobalKey? themeShowcaseKey;
  final GlobalKey? backgroundShowcaseKey;

  const ChatAppBar({
    super.key,
    required this.onBackPressed,
    required this.onThemeToggle,
    required this.onBackgroundChange,
    required this.isDarkMode,
    this.themeShowcaseKey,
    this.backgroundShowcaseKey,
  });

  void _showAboutDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder:
          (context, animation, secondaryAnimation) => const AppAboutDialog(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(curvedAnimation),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(
                  "https://www.profilebakery.com/wp-content/uploads/2024/05/Profile-picture-created-with-ai.jpeg",
                ),
              ),

              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Manas🚀",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "online",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 2,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      shadowColor: Theme.of(context).colorScheme.shadow,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: onBackPressed,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.info,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => _showAboutDialog(context),
        ),
        Showcase(
          key: backgroundShowcaseKey ?? GlobalKey(),
          description: 'Change chat background',
          child: IconButton(
            icon: Icon(
              Icons.wallpaper,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: onBackgroundChange,
          ),
        ),
        Showcase(
          key: themeShowcaseKey ?? GlobalKey(),
          description: 'Toggle between light and dark mode',
          child: IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: onThemeToggle,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
