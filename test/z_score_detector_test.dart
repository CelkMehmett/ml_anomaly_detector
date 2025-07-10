import 'package:test/test.dart';
import 'package:ml_anomaly_detector/algorithms/z_score_detector.dart';
import 'package:ml_anomaly_detector/models/anomaly_result.dart';

void main() {
  group('ZScoreDetector', () {
    test('detects anomalies in a simple dataset', () {
      final data = [10.0, 10.1, 9.9, 10.2, 50.0]; // 50.0 is an anomaly
      final detector = ZScoreDetector(threshold: 1.5);
      final results = detector.detect(data);

      expect(results.length, equals(data.length));

      final anomaly = results.firstWhere(
        (r) => r.isAnomaly,
        orElse: () => AnomalyResult(
          value: 0,
          score: 0,
          isAnomaly: false,
          index: -1,
          algorithm: 'z_score',
          confidence: 0.0,
          explanation: '',
        ),
      );

      expect(anomaly.value, equals(50.0));
      expect(anomaly.isAnomaly, isTrue);
    });

    test('returns no anomalies when data is within range', () {
      final data = [1.0, 1.1, 0.9, 1.05, 0.95];
      final detector = ZScoreDetector(threshold: 3.0);
      final results = detector.detect(data);

      final hasAnomalies = results.any((r) => r.isAnomaly);
      expect(hasAnomalies, isFalse);
    });
  });
}
