import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentStep = 0;
  bool _isShowcaseActive = false;

  // Global keys for the hint system
  final GlobalKey _stepperKey = GlobalKey();
  final GlobalKey _continueButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Start the showcase after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isShowcaseActive) {
        ShowCaseWidget.of(
          context,
        ).startShowCase([_stepperKey, _continueButtonKey]);
        setState(() {
          _isShowcaseActive = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ShowCaseWidget(
      builder:
          (context) => Scaffold(
            body: Showcase(
              key: _stepperKey,
              description: '欢迎体验引导流程！',
              child: Stepper(
                steps: [
                  Step(
                    title: Text('欢迎使用', style: theme.textTheme.titleMedium),
                    content: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '欢迎使用本图书管理系统，接下来我为您演示一些常见功能',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    isActive: _currentStep == 0,
                    state:
                        _currentStep > 0
                            ? StepState.complete
                            : StepState.indexed,
                  ),
                  Step(
                    title: Text('新建商品资料', style: theme.textTheme.titleMedium),
                    content: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '点击左侧的基础数据，然后点击子菜单’新建资料‘进入',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    isActive: _currentStep == 1,
                    state:
                        _currentStep > 1
                            ? StepState.complete
                            : StepState.indexed,
                  ),
                  Step(
                    title: Text('商品入库', style: theme.textTheme.titleMedium),
                    content: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '点击左侧的订收管理，然后点击子菜单’入库单‘进入',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    isActive: _currentStep == 2,
                    state:
                        _currentStep == 2
                            ? StepState.indexed
                            : StepState.complete,
                  ),
                ],
                onStepTapped: (int newIndex) {
                  setState(() {
                    _currentStep = newIndex;
                  });
                },
                onStepContinue: () {
                  if (_currentStep < 2) {
                    setState(() => _currentStep++);
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep--);
                  }
                },
                currentStep: _currentStep,
                controlsBuilder: (
                  BuildContext context,
                  ControlsDetails details,
                ) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(children: [const SizedBox(width: 12)]),
                  );
                },
              ),
            ),
          ),
    );
  }
}
