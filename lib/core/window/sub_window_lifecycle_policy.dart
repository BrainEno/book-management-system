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
  return fromNativeCloseRequest
      ? SubWindowTerminationMethod.destroy
      : SubWindowTerminationMethod.close;
}
