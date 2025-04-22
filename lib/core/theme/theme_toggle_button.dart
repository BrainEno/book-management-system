import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_bloc.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDarkMode = state.themeMode == ThemeMode.dark;
        return GestureDetector(
          onTap: () {
            // Dispatch the ToggleTheme event to switch themes
            context.read<ThemeBloc>().add(ToggleTheme());
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:
                  isDarkMode
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Sun and Moon Icons
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: isDarkMode ? 2 : 32,
                  child: Icon(
                    isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                    color:
                        isDarkMode
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSecondary,
                    size: 20,
                  ),
                ),
                // Sliding Circle
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment:
                      isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
