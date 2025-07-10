/// Utility class for validating input data used in anomaly detection.
class DataValidator {
  /// Ensures the provided list is not empty.
  static void validateNonEmpty(List data, {String? name}) {
    if (data.isEmpty) {
      throw ArgumentError('${name ?? "Input data"} must not be empty.');
    }
  }

  /// Ensures all vectors in a 2D dataset have the same length.
  ///
  /// Example input:
  /// [
  ///   [1.0, 2.0],
  ///   [2.5, 3.1],
  ///   [4.2, 5.0]
  /// ]
  static void validateEqualLengthVectors(List<List<double>> data) {
    if (data.isEmpty) return;

    final int length = data[0].length;
    for (var vector in data) {
      if (vector.length != length) {
        throw ArgumentError('All vectors must have the same number of elements.');
      }
    }
  }

  /// Optional: Checks if the values are all finite numbers.
  static void validateFiniteValues(List<double> data, {String? name}) {
    for (final value in data) {
      if (value.isNaN || value.isInfinite) {
        throw ArgumentError('${name ?? "Input data"} contains non-finite value.');
      }
    }
  }
}
