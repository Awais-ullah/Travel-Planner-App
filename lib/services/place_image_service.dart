import 'dart:convert';
import 'package:http/http.dart' as http;

/// Fetches a real photo for a place from Wikipedia's public REST API
/// (no API key required — it's a keyless public endpoint, not a custom
/// backend). Falls back gracefully to null on any failure so callers
/// can show a placeholder instead of crashing.
class PlaceImageService {
  PlaceImageService._();

  static final Map<String, String?> _cache = {};

  /// Returns a direct image URL for [placeName], or null if none found
  /// (unknown place, offline, or the API had no image for that title).
  static Future<String?> fetchImageUrl(String placeName) async {
    if (_cache.containsKey(placeName)) return _cache[placeName];

    try {
      final title = Uri.encodeComponent(placeName.trim());
      final uri = Uri.parse('https://en.wikipedia.org/api/rest_v1/page/summary/$title');

      final response = await http.get(uri).timeout(const Duration(seconds: 6));

      if (response.statusCode != 200) {
        _cache[placeName] = null;
        return null;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final original = data['originalimage'] as Map<String, dynamic>?;
      final thumbnail = data['thumbnail'] as Map<String, dynamic>?;

      final url = (original?['source'] as String?) ?? (thumbnail?['source'] as String?);

      _cache[placeName] = url;
      return url;
    } catch (_) {
      _cache[placeName] = null;
      return null;
    }
  }
}