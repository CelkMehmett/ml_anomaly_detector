import 'package:test/test.dart';
import 'package:ml_anomaly_detector/algorithms/lof_detector.dart';
import 'package:ml_anomaly_detector/models/anomaly_result.dart';
import 'package:ml_anomaly_detector/config/anomaly_config.dart';

void main() {
  group('LOFDetector', () {
    test('detects outliers in multivariate data', () {
      final data = [
        [1.0, 1.0],
        [1.1, 1.1],
        [0.9, 0.9],
        [10.0, 10.0], // Anomalous point
      ];

      final config = AnomalyConfig(
        threshold: 1.5,
        minPoints: 2,
        distanceType: 'euclidean',
      );

      final detector = LOFDetector(config: config);
      final results = detector.detect(data);

      expect(results.length, equals(data.length));

      final anomaly = results.firstWhere(
        (r) => r.isAnomaly,
        orElse: () => AnomalyResult(
          value: 0.0,
          score: 0.0,
          isAnomaly: false,
        ),
      );

      expect(anomaly.featureVector, equals([10.0, 10.0]));
      expect(anomaly.isAnomaly, isTrue);
      expect(anomaly.score, greaterThan(config.threshold));
    });

    test('does not mark normal points as anomaly', () {
      final data = [
        [1.0, 1.0],
        [1.1, 1.1],
        [0.9, 0.9],
      ];

      final config = AnomalyConfig(
        threshold: 2.0,
        minPoints: 2,
        distanceType: 'euclidean',
      );

      final detector = LOFDetector(config: config);
      final results = detector.detect(data);

      expect(results.any((r) => r.isAnomaly), isFalse);
    });
  });
}
