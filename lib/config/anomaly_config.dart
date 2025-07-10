/// Configuration options for anomaly detection algorithms.
class AnomalyConfig {
  /// Threshold value used for algorithms like Z-Score.
  final double threshold;

  /// Minimum number of neighbors, used in algorithms like LOF.
  final int minPoints;

  /// Type of distance metric to use (e.g., 'euclidean', 'manhattan', 'cosine').
  final String distanceType;

  /// Optional flag to enable debug logging or detailed output.
  final bool verbose;

  /// Optional maximum anomaly count (used in some use-cases).
  final int? maxAnomalies;

  /// Constructor with default values suitable for most algorithms.
  const AnomalyConfig({
    this.threshold = 3.0,
    this.minPoints = 5,
    this.distanceType = 'euclidean',
    this.verbose = false,
    this.maxAnomalies,
  });

  /// Creates a copy with updated values (useful for modifications).
  AnomalyConfig copyWith({
    double? threshold,
    int? minPoints,
    String? distanceType,
    bool? verbose,
    int? maxAnomalies,
  }) {
    return AnomalyConfig(
      threshold: threshold ?? this.threshold,
      minPoints: minPoints ?? this.minPoints,
      distanceType: distanceType ?? this.distanceType,
      verbose: verbose ?? this.verbose,
      maxAnomalies: maxAnomalies ?? this.maxAnomalies,
    );
  }

  @override
  String toString() {
    return 'AnomalyConfig(threshold: $threshold, minPoints: $minPoints, distanceType: $distanceType, verbose: $verbose, maxAnomalies: $maxAnomalies)';
  }
}
