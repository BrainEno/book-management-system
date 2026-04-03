class AppRuntime {
  const AppRuntime({
    required this.isSubWindow,
    this.windowId,
    this.hostWindowId,
  });

  final bool isSubWindow;
  final String? windowId;
  final String? hostWindowId;
}
