import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class PlantAdvisorService {
  final String _apiKey = dotenv.env['PLAT_DISEASE_API_KEY']!;

  final List<String> _models = [
    "gemini-3.1-flash-lite",
    "gemini-2.5-flash",
    "gemini-2.0-flash",
    "gemini-1.5-flash",
  ];

  PlantAdvisorService() {
    Gemini.init(apiKey: _apiKey);
  }

  Gemini get _gemini => Gemini.instance;

  Future<String> analyzeDisease(String plantName, String diseaseName) async {
    for (int i = 0; i < _models.length; i++) {
      try {
        final response = await _gemini.prompt(
          model: _models[i],
          parts: [
            Part.text("""
You are an expert agricultural plant doctor.

Return ONLY valid JSON:

{
  "Symptoms": ["short point"],
  "Causes": ["short point"],
  "Treatment": ["short point"],
  "Prevention": ["short point"]
}

Plant: $plantName
Disease: $diseaseName
"""),
          ],
        );

        final output = response?.output;

        if (output != null && output.trim().isNotEmpty) {
          return _cleanJson(output);
        }
      } catch (e) {
        final errorMsg = e.toString().toLowerCase();

        if (errorMsg.contains("quota") ||
            errorMsg.contains("api key") ||
            errorMsg.contains("permission")) {
          return "ERROR: API limit reached or invalid key";
        }

        continue;
      }
    }

    return "ERROR: All models failed";
  }

  String _cleanJson(String output) {
    String cleaned = output.trim();

    if (cleaned.startsWith('```json')) {
      cleaned = cleaned.substring(7);
    } else if (cleaned.startsWith('```')) {
      cleaned = cleaned.substring(3);
    }

    if (cleaned.endsWith('```')) {
      cleaned = cleaned.substring(0, cleaned.length - 3);
    }

    return cleaned.trim();
  }
}
