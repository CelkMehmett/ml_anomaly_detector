import 'package:ml_anomaly_detector/models/anomaly_result.dart';
import 'package:ml_anomaly_detector/core/statistics.dart';

class ZScoreDetector {
  final double threshold;
  final String algorithmName;

  const ZScoreDetector({
    this.threshold = 3.0,
    this.algorithmName = 'z_score',
  });

  List<AnomalyResult> detect(List<double> data) {
    if (data.isEmpty) {
      throw ArgumentError('Input data list cannot be empty.');
    }

    final mean = Statistics.mean(data);
    final stdDev = Statistics.standardDeviation(data);

    if (stdDev == 0) {
      throw StateError('Standart sapma sıfır: Z-score hesaplanamaz. Veri setindeki tüm değerler aynı olabilir.');
    }

    return List<AnomalyResult>.generate(data.length, (index) {
      final value = data[index];
      final zScore = (value - mean) / stdDev;
      final isAnomaly = zScore.abs() > threshold;
      final confidence = _calculateConfidence(zScore.abs());

      return AnomalyResult(
        value: value,
        score: zScore,
        isAnomaly: isAnomaly,
        index: index,
        algorithm: algorithmName,
        confidence: confidence,
        explanation: isAnomaly
            ? 'Z-score of $zScore exceeds threshold of $threshold.'
            : 'Z-score of $zScore is within acceptable range.',
      );
    });
  }

  double _calculateConfidence(double absZ) {
    final normalized = absZ / threshold;
    return normalized.clamp(0.0, 1.0);
  }
}
