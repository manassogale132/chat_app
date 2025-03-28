import 'package:chat_application/widgets/chat_bubble.dart';
import 'package:chat_application/widgets/chat_input_field.dart';
import 'package:chat_application/widgets/chat_app_bar.dart';
import 'package:chat_application/bloc/chat_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

class ChatScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  const ChatScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder:
          (context) => BlocProvider(
            create: (context) => ChatScreenBloc()..add(FetchMessagesEvent()),
            child: ChatScreenView(toggleTheme: toggleTheme),
          ),
    );
  }
}

class ChatScreenView extends StatefulWidget {
  final VoidCallback toggleTheme;

  const ChatScreenView({super.key, required this.toggleTheme});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final List<String> _backgroundImages = [
    'https://plus.unsplash.com/premium_photo-1672201106204-58e9af7a2888?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Z3JhZGllbnQlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1557683311-eac922347aa1?q=80&w=2029&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=2070&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1557682224-5b8590cd9ec5?q=80&w=2029&auto=format&fit=crop',
    'plain_black',
  ];

  // Add showcase keys
  final GlobalKey _themeShowcaseKey = GlobalKey();
  final GlobalKey _backgroundShowcaseKey = GlobalKey();
  final GlobalKey _messageInputShowcaseKey = GlobalKey();
  final GlobalKey _voiceMessageShowcaseKey = GlobalKey();

  int _currentBackgroundIndex = 0;
  int _nextBackgroundIndex = 1;
  double _currentOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    // Start showcase after a short delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([
        _themeShowcaseKey,
        _backgroundShowcaseKey,
        _messageInputShowcaseKey,
        _voiceMessageShowcaseKey,
      ]);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildBackground(String imageUrl, bool isDarkMode) {
    if (imageUrl == 'plain_black') {
      return Container(color: Colors.black);
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter:
              isDarkMode
                  ? ColorFilter.mode(
                    Colors.black.withAlpha((0.4 * 255).round()),
                    BlendMode.darken,
                  )
                  : ColorFilter.mode(
                    Colors.black.withAlpha((0.2 * 255).round()),
                    BlendMode.darken,
                  ),
        ),
      ),
    );
  }

  void _changeBackground() {
    setState(() {
      _currentOpacity = 0.0;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _currentBackgroundIndex = _nextBackgroundIndex;
        _nextBackgroundIndex =
            (_nextBackgroundIndex + 1) % _backgroundImages.length;
        _currentOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final ScrollController scrollController = ScrollController();

    void scrollToBottom() {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }

    return Scaffold(
      appBar: ChatAppBar(
        onBackPressed: () {},
        onThemeToggle: widget.toggleTheme,
        onBackgroundChange: _changeBackground,
        isDarkMode: isDarkMode,
        themeShowcaseKey: _themeShowcaseKey,
        backgroundShowcaseKey: _backgroundShowcaseKey,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // Background layers
            Positioned.fill(
              child: _buildBackground(
                _backgroundImages[_nextBackgroundIndex],
                isDarkMode,
              ),
            ),
            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _currentOpacity,
                child: _buildBackground(
                  _backgroundImages[_currentBackgroundIndex],
                  isDarkMode,
                ),
              ),
            ),
            // Chat content
            BlocConsumer<ChatScreenBloc, ChatScreenState>(
              listener: (context, state) {
                if (state is ChatScreenError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
                if (state is ChatScreenLoaded) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => scrollToBottom(),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                      child: switch (state) {
                        ChatScreenLoading() => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        ChatScreenLoaded(:final messages) => Scrollbar(
                          controller: scrollController,
                          thickness: 4,
                          radius: const Radius.circular(20),
                          child: ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.all(10),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return ChatBubble(message: messages[index]);
                            },
                          ),
                        ),
                        ChatScreenError() => const Center(
                          child: Text(
                            'Something went wrong',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        _ => const SizedBox(),
                      },
                    ),
                    Showcase(
                      key: _messageInputShowcaseKey,
                      description:
                          'Tap on mic or Type your message here and press send',
                      child: ChatInputField(
                        onSubmit: (String text, bool isVoice) {
                          scrollToBottom();
                          if (text.trim().isNotEmpty || isVoice) {
                            context.read<ChatScreenBloc>().add(
                              SendMessageEvent(
                                text: text.trim(),
                                isVoiceMessage: isVoice,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
