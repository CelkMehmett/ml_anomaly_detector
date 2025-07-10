import 'dart:math';
import 'package:ml_anomaly_detector/models/anomaly_result.dart';
import 'package:ml_anomaly_detector/core/distance_metrics.dart';
import 'package:ml_anomaly_detector/utils/data_validator.dart';
import 'package:ml_anomaly_detector/config/anomaly_config.dart';

/// Anomaly detection using Local Outlier Factor (LOF) for multivariate data.
class LOFDetector {
  final AnomalyConfig config;

  LOFDetector({required this.config});

  List<AnomalyResult> detect(List<List<double>> data) {
    DataValidator.validateNonEmpty(data);
    DataValidator.validateEqualLengthVectors(data);

    final int k = config.minPoints;
    final distanceType = config.distanceType;

    final List<List<double>> distances = _computeDistances(data, distanceType);
    final List<List<int>> neighbors = _findKNearestNeighbors(distances, k);
    final List<double> lrdValues = _computeLRD(data, distances, neighbors, k);
    final List<AnomalyResult> results = [];

    for (int i = 0; i < data.length; i++) {
      double lofScore = 0.0;
      for (int n in neighbors[i]) {
        lofScore += lrdValues[n] / lrdValues[i];
      }
      lofScore /= k;
      bool isAnomaly = lofScore > config.threshold;

      results.add(AnomalyResult(
        value: 0.0, // Placeholder, because multivariate
        featureVector: data[i],
        index: i,
        score: lofScore,
        isAnomaly: isAnomaly,
        algorithm: 'lof',
        confidence: (lofScore / config.threshold).clamp(0.0, 1.0),
        explanation: isAnomaly
            ? 'LOF score $lofScore exceeds threshold ${config.threshold}.'
            : 'LOF score $lofScore is within acceptable range.',
      ));
    }

    return results;
  }

  List<List<double>> _computeDistances(List<List<double>> data, String metric) {
    int n = data.length;
    List<List<double>> distances = List.generate(n, (_) => List.filled(n, 0.0));

    for (int i = 0; i < n; i++) {
      for (int j = i + 1; j < n; j++) {
        double d;
        switch (metric) {
          case 'manhattan':
            d = DistanceMetrics.manhattan(data[i], data[j]);
            break;
          case 'cosine':
            d = DistanceMetrics.cosineDistance(data[i], data[j]);
            break;
          case 'euclidean':
          default:
            d = DistanceMetrics.euclidean(data[i], data[j]);
        }
        distances[i][j] = d;
        distances[j][i] = d;
      }
    }
    return distances;
  }

  List<List<int>> _findKNearestNeighbors(List<List<double>> distances, int k) {
    return distances.map((row) {
      List<int> indices = List.generate(row.length, (i) => i);
      indices.sort((a, b) => row[a].compareTo(row[b]));
      return indices.sublist(1, k + 1); // exclude self
    }).toList();
  }

  List<double> _computeLRD(List<List<double>> data, List<List<double>> distances, List<List<int>> neighbors, int k) {
    List<double> lrd = List.filled(data.length, 0.0);

    for (int i = 0; i < data.length; i++) {
      double reachDistSum = 0.0;
      for (int n in neighbors[i]) {
        double actualDist = distances[i][n];
        List<double> sortedDists = distances[n]..sort();
        double kDistance = sortedDists[k];
        double reachDist = max(actualDist, kDistance);
        reachDistSum += reachDist;
      }
      lrd[i] = k / reachDistSum;
    }

    return lrd;
  }
}
