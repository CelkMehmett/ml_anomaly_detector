library ml_anomaly_detector;

/// Main export file for the ml_anomaly_detector package.
/// Includes core utilities, anomaly detection algorithms, models, and configuration.

// Models
export 'models/anomaly_result.dart';

// Core Utilities
export 'core/statistics.dart';
export 'core/distance_metrics.dart';

// Algorithms
export 'algorithms/z_score_detector.dart';
export 'algorithms/lof_detector.dart';
export 'algorithms/isolation_forest.dart'; // (To be implemented)

// Configuration & Utilities
export 'config/anomaly_config.dart';
export 'utils/data_validator.dart';
