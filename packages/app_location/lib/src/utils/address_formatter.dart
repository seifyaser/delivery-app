/// Utility for cleaning and formatting address components.
class AddressFormatter {
  const AddressFormatter._();

  /// Removes Google Plus Codes (e.g. "4778+JFC") from strings.
  static String? cleanPlusCode(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final cleaned = value
        .replaceFirst(
          RegExp(
            r'^[A-Z0-9]{4,8}\+[A-Z0-9]{2,7}[،,\s]*',
            caseSensitive: false,
          ),
          '',
        )
        .trim();

    return cleaned.isEmpty ? null : cleaned;
  }

  /// Builds a human-readable delivery-friendly address by combining unique parts.
  static String formatFullAddress(List<String?> parts) {
    final validParts = parts
        .where((part) => part != null && part.trim().isNotEmpty)
        .map((part) => part!.trim())
        .toList();

    final uniqueParts = validParts.toSet().toList();
    
    if (uniqueParts.isEmpty) return 'Unknown Location';
    
    return uniqueParts.join('، ');
  }
}
