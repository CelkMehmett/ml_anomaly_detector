
import 'package:test/test.dart';
import 'package:ml_anomaly_detector/ml_anomaly_detector.dart';

void main() {
  group('ml_anomaly_detector exports', () {
    test('ZScoreDetector runs from main export', () {
      final data = [2.0, 2.1, 1.9, 2.2, 8.0];
      final detector = ZScoreDetector(threshold: 1.5);
      final results = detector.detect(data);

      final anomaly = results.firstWhere(
        (r) => r.isAnomaly,
        orElse: () => AnomalyResult(
          value: 0.0,
          score: 0.0,
          isAnomaly: false,
        ),
      );

      expect(anomaly.isAnomaly, isTrue);
      expect(anomaly.score, greaterThan(1.5));
    });

    test('AnomalyResult toString returns expected string', () {
      final result = AnomalyResult(
        value: 99.0,
        score: 5.5,
        isAnomaly: true,
        index: 10,
        algorithm: 'test_algo',
        confidence: 0.95,
        explanation: 'Test case anomaly',
      );

      expect(result.toString(), contains('value: 99.0'));
      expect(result.toString(), contains('score: 5.5'));
      expect(result.toString(), contains('isAnomaly: true'));
    });
  });
}