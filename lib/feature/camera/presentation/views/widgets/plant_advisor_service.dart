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

Return ONLY valid JSON (no text outside it):

{
  "Symptoms": ["short point"],
  "Causes": ["short point"],
  "Treatment": ["short point"],
  "Prevention": ["short point"],
}

Rules:
- very short and practical
- no explanation
- no extra text
- if empty return []

Plant: $plantName
Disease: $diseaseName
"""),
          ],
        );

        final output = response?.output;

        if (output != null && output.isNotEmpty) {
          // Strip markdown code blocks if present
          String cleanedOutput = output.trim();
          if (cleanedOutput.startsWith('```json')) {
            cleanedOutput = cleanedOutput.substring(7);
          } else if (cleanedOutput.startsWith('```')) {
            cleanedOutput = cleanedOutput.substring(3);
          }
          if (cleanedOutput.endsWith('```')) {
            cleanedOutput = cleanedOutput.substring(
              0,
              cleanedOutput.length - 3,
            );
          }
          return cleanedOutput.trim();
        }
      } catch (e) {
        continue;
      }
    }

    return "{}";
  }
}
