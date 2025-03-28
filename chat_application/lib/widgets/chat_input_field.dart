import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  final Function(String text, bool isVoice) onSubmit;

  const ChatInputField({super.key, required this.onSubmit});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.only(left: 8, right: 10, top: 8, bottom: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.mic,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {
              widget.onSubmit("AUDIO MESSAGE", true);
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade800
                        : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextField(
                controller: _textController,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: TextStyle(color: theme.colorScheme.onSurface),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {
              if (_textController.text.trim().isNotEmpty) {
                FocusScope.of(context).unfocus();
                widget.onSubmit(_textController.text, false);
                _textController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
