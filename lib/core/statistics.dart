import 'dart:math' as math;

/// Utility class for statistical calculations.
class Statistics {
  /// Calculates the mean (average) of a list of numbers.
  static double mean(List<double> data) {
    if (data.isEmpty) {
      throw ArgumentError('Data list cannot be empty');
    }
    return data.reduce((a, b) => a + b) / data.length;
  }

  /// Calculates the standard deviation of a list of numbers.
  static double standardDeviation(List<double> data) {
    if (data.isEmpty) {
      throw ArgumentError('Data list cannot be empty');
    }
    if (data.length == 1) {
      return 0.0;
    }
    final meanValue = mean(data);
    final variance = data
        .map((value) => math.pow(value - meanValue, 2).toDouble())
        .reduce((a, b) => a + b) / (data.length - 1);
    return math.sqrt(variance);
  }
}