/// Represents the result of an anomaly detection operation.
class AnomalyResult {
  /// The original data value that was analyzed.
  final double value;
  
  /// The anomaly score (e.g., Z-score, distance, etc.)
  final double score;
  
  /// Whether this data point is considered an anomaly.
  final bool isAnomaly;
  
  /// The index of this data point in the original dataset.
  final int index;
  
  /// The name of the algorithm used for detection.
  final String algorithm;
  
  /// Confidence level of the anomaly detection (0.0 to 1.0).
  final double confidence;
  
  /// Human-readable explanation of why this is/isn't an anomaly.
  final String explanation;

  /// The feature vector for multivariate data (used by LOF detector).
  final List<double>? featureVector;

  const AnomalyResult({
    required this.value,
    required this.score,
    required this.isAnomaly,
    this.index = -1,
    this.algorithm = 'unknown',
    this.confidence = 0.0,
    this.explanation = '',
    this.featureVector,
  });

  @override
  String toString() {
    return 'AnomalyResult(value: $value, score: $score, isAnomaly: $isAnomaly, '
           'index: $index, algorithm: $algorithm, confidence: $confidence, '
           'explanation: $explanation, featureVector: $featureVector)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AnomalyResult &&
        other.value == value &&
        other.score == score &&
        other.isAnomaly == isAnomaly &&
        other.index == index &&
        other.algorithm == algorithm &&
        other.confidence == confidence &&
        other.explanation == explanation &&
        _listEquals(other.featureVector, featureVector);
  }

  @override
  int get hashCode {
    return value.hashCode ^
        score.hashCode ^
        isAnomaly.hashCode ^
        index.hashCode ^
        algorithm.hashCode ^
        confidence.hashCode ^
        explanation.hashCode ^
        (featureVector?.hashCode ?? 0);
  }

  bool _listEquals(List<double>? a, List<double>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}