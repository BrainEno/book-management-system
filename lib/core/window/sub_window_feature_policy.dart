class SubWindowFeaturePolicy {
  const SubWindowFeaturePolicy._();

  static bool supportsAudioFeedback({
    required bool isSubWindow,
    required bool isWindows,
  }) {
    if (!isSubWindow) {
      return true;
    }

    return !isWindows;
  }
}
