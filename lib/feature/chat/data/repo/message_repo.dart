import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatService {
  final String _apiKey = dotenv.env['CHAT_BOT_API_KEY']!;

  final List<String> _models = [
    "gemini-1.5-flash",
    "gemini-1.5-pro",
    "gemini-1.0-pro",
    "gemini-2.0-flash",
  ];

  int _modelIndex = 0;

  Gemini get _gemini {
    Gemini.init(apiKey: _apiKey);
    return Gemini.instance;
  }

  bool _isGreeting(String text) {
    final t = text.toLowerCase();
    return [
      "hi",
      "hello",
      "hey",
      "good morning",
      "السلام",
    ].any((e) => t.contains(e));
  }

  Future<String> sendMessage(String message) async {
    final text = message.trim();

    // 1) Greetings handling
    if (_isGreeting(text)) {
      return "👋 Hello! Ask me about fruits, vegetables, soil, fertilizers, or plant diseases.";
    }

    // 2) Main AI logic with fallback models
    for (int i = 0; i < _models.length; i++) {
      try {
        final response = await _gemini.prompt(
          model: _models[_modelIndex],
          parts: [
            Part.text("""
You are an AGRICULTURE EXPERT assistant.

You MUST answer anything related to:
- fruits (tomato, apple, mango, etc.)
- vegetables (potato, onion, cucumber, etc.)
- soil types
- fertilizers
- plant diseases
- farming techniques

IMPORTANT RULES:
- Be SHORT and CLEAR
- Do NOT give long paragraphs
- Use this format ONLY:

Problem:
Solution:
Tips:

If user says ANY fruit/vegetable/fertilizer/soil name, ALWAYS answer.

If completely unrelated (like programming, politics), say:
"I only answer agriculture-related questions."

User question: $text
"""),
          ],
        );

        final output = response?.output;

        if (output != null && output.trim().isNotEmpty) {
          return output;
        }
      } catch (e) {
        _modelIndex = (_modelIndex + 1) % _models.length;
      }
    }

    return "⚠️ Service temporarily unavailable. Try again.";
  }
}
