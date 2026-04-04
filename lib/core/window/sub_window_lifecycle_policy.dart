enum SubWindowTerminationMethod { close, destroy }

bool shouldDockSubWindowOnMaximize({
  required bool maximizeDockArmed,
  required bool handlingWindowTransition,
}) {
  return maximizeDockArmed && !handlingWindowTransition;
}

bool shouldRegisterSharedSubWindowEventHandler({
  required bool isSubWindow,
}) {
  return !isSubWindow;
}

SubWindowTerminationMethod resolveSubWindowTerminationMethod({
  required bool fromNativeCloseRequest,
}) {
  // On Windows, `window_manager.destroy()` posts a process-level quit message,
  // so sub-windows must always terminate through the normal close path.
  return SubWindowTerminationMethod.close;
}
