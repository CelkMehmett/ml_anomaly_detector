import 'dart:math';

/// Provides commonly used distance and similarity metrics for anomaly detection.
class DistanceMetrics {
  /// Computes Euclidean distance between two vectors.
  static double euclidean(List<double> a, List<double> b) {
    _validateEqualLength(a, b);
    double sum = 0.0;
    for (int i = 0; i < a.length; i++) {
      sum += pow(a[i] - b[i], 2);
    }
    return sqrt(sum);
  }

  /// Computes Manhattan distance (L1 norm) between two vectors.
  static double manhattan(List<double> a, List<double> b) {
    _validateEqualLength(a, b);
    double sum = 0.0;
    for (int i = 0; i < a.length; i++) {
      sum += (a[i] - b[i]).abs();
    }
    return sum;
  }

  /// Computes Cosine similarity between two vectors.
  /// Returns value in range [-1.0, 1.0], where 1.0 means identical direction.
  static double cosineSimilarity(List<double> a, List<double> b) {
    _validateEqualLength(a, b);
    double dotProduct = 0.0;
    double normA = 0.0;
    double normB = 0.0;

    for (int i = 0; i < a.length; i++) {
      dotProduct += a[i] * b[i];
      normA += pow(a[i], 2);
      normB += pow(b[i], 2);
    }

    double denominator = sqrt(normA) * sqrt(normB);
    if (denominator == 0.0) return 0.0;
    return dotProduct / denominator;
  }

  /// Converts cosine similarity to cosine distance: `1 - similarity`.
  static double cosineDistance(List<double> a, List<double> b) {
    return 1.0 - cosineSimilarity(a, b);
  }

  /// Validates that two vectors have the same length.
  static void _validateEqualLength(List<double> a, List<double> b) {
    if (a.length != b.length) {
      throw ArgumentError('Vectors must have the same length.');
    }
  }
}
