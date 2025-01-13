class CapturingData {
  final bool isCapturing;

  CapturingData(this.isCapturing);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CapturingData && other.isCapturing == isCapturing;
  }

  @override
  int get hashCode => isCapturing.hashCode;
}
