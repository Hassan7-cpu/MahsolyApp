import 'package:flutter_gemini/flutter_gemini.dart';

class ChatService {
  final Gemini _gemini = Gemini.instance;

  Future<String> sendMessage(String message) async {
    try {
      final response = await _gemini.prompt(
        parts: [
          Part.text("""
You are an agricultural assistant specialized in:
- plants
- plant diseases
- soil types
- crops and farming
- fruit care, storage, and post-harvest handling

Answer ONLY agriculture-related questions including:
- how to grow plants
- how to treat diseases
- how to store fruits and crops (like apples, tomatoes, etc.)

If the question is NOT related, reply with:
"Sorry, I only answer agriculture-related questions."

Respond in the SAME language as the user.

User question: $message
"""),
        ],
      );

      if (response == null || response.output == null) {
        return "Sorry, I couldn't understand. Please try again.";
      }

      return response.output!;
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}
