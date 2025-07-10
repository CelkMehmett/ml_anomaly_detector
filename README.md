# 📊 ml_anomaly_detector

A simple and extensible Dart package for anomaly detection using classical algorithms like **Z-Score**, with support for pluggable strategies and detailed result reporting.

[![Pub Version](https://img.shields.io/pub/v/ml_anomaly_detector.svg)](https://pub.dev/packages/ml_anomaly_detector)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## 🚀 Features

- ✅ Z-Score based anomaly detection
- 📦 Designed for extensibility (LOF, IQR, DBSCAN coming soon)
- 🔍 Returns detailed results: value, score, confidence, explanation
- 📊 Compatible with time-series or single-point anomaly detection
- 💡 Easy to use, production-ready

---

## 🧠 Example

```dart
import 'package:ml_anomaly_detector/ml_anomaly_detector.dart';

void main() {
  final data = [1.0, 1.1, 0.9, 1.2, 10.0];
  final detector = ZScoreDetector(threshold: 2.0);
  final results = detector.detect(data);

  for (var result in results) {
    print(
        'Value: \${result.value}, Score: \${result.score.toStringAsFixed(2)}, '
        'Anomaly: \${result.isAnomaly}');
  }
}
```

---

## 📦 Installation

Add the following line to your `pubspec.yaml`:

```yaml
dependencies:
  ml_anomaly_detector: ^1.0.0
```

Then run:

```bash
dart pub get
```

---

## 📁 API Overview

### `ZScoreDetector`

```dart
ZScoreDetector({
  double threshold = 3.0,
  String algorithmName = 'z_score',
});
```

### `AnomalyResult`

| Field         | Type      | Description                          |
|---------------|-----------|--------------------------------------|
| `value`       | `double`  | Original input value                 |
| `score`       | `double`  | Anomaly score (Z-score, etc.)       |
| `isAnomaly`   | `bool`    | Whether it's an anomaly              |
| `index`       | `int?`    | Optional index in dataset            |
| `confidence`  | `double?` | Confidence level (0.0 to 1.0)        |
| `algorithm`   | `String?` | Name of algorithm used               |
| `explanation` | `String?` | Human-readable decision explanation  |

---

## 🧪 Tests

Run unit tests using:

```bash
dart test
```

---

## 📌 Roadmap

- [x] Z-Score detector
- [ ] IQR-based anomaly detection
- [ ] Local Outlier Factor (LOF)
- [ ] DBSCAN
- [ ] Visual anomaly plotting (with Flutter)

---

## 📃 License

MIT © 2025 [Mehmet Çelik](https://github.com/CelkMehmett)

> Contributions are welcome! PRs & feedback appreciated.

---