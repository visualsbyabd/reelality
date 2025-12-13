String formatNumber(num value) {
  if (value < 1000) {
    return value.toString();
  }

  if (value < 1_000_000) {
    double result = value / 1000;
    return "${result.toStringAsFixed(result % 1 == 0 ? 0 : 1)}K";
  }

  if (value < 1_000_000_000) {
    double result = value / 1_000_000;
    return "${result.toStringAsFixed(result % 1 == 0 ? 0 : 1)}M";
  }

  // value >= 1,000,000,000
  double result = value / 1_000_000_000;
  return "${result.toStringAsFixed(result % 1 == 0 ? 0 : 1)}B";
}
