import 'package:bookstore_management_system/core/domain/entities/app_user.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/dashboard/presentation/models/dashboard_models.dart';
import 'package:bookstore_management_system/features/dashboard/presentation/widgets/dashboard_insight_widgets.dart';
import 'package:bookstore_management_system/features/dashboard/presentation/widgets/dashboard_widgets.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
    required this.now,
    required this.currentUser,
    required this.themeMode,
    required this.products,
    required this.onCommandPressed,
    required this.onToggleTheme,
    required this.onOpenProduct,
    required this.onOpenInventory,
    required this.onOpenPage,
    required this.onLogout,
    required this.onShowPlannedFeature,
  });

  final DateTime now;
  final AppUser? currentUser;
  final ThemeMode themeMode;
  final List<Product> products;
  final VoidCallback onCommandPressed;
  final VoidCallback onToggleTheme;
  final VoidCallback onOpenProduct;
  final VoidCallback onOpenInventory;
  final ValueChanged<String> onOpenPage;
  final VoidCallback onLogout;
  final ValueChanged<String> onShowPlannedFeature;

  @override
  Widget build(BuildContext context) {
    final summary = DashboardSummary.fromProducts(products);
    final metrics = buildDashboardMetrics(summary);
    final shortcuts = buildDashboardShortcuts(
      summary: summary,
      onOpenInventory: onOpenInventory,
      onShowPlannedFeature: onShowPlannedFeature,
    );
    final moduleGroups = buildDashboardModuleGroups();
    final alerts = buildDashboardAlerts(summary);
    final categoryShare = buildDashboardCategoryShare(summary);
    final bestsellerItems = buildDashboardRankingItems(
      products,
      fallbackTitles: const ['情人', '等待戈多', '百年孤独', '刀锋', '欣泣集'],
      accent: AppPallete.forest,
    );
    final slowMovingItems = buildDashboardRankingItems(
      products.reversed.toList(),
      fallbackTitles: const ['旧书特价台', '艺术画册区', '旅行散文区', '外文文学角', '文创礼盒'],
      accent: AppPallete.copper,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppPallete.paper,
            AppPallete.paperElevated,
            const Color(0xFFF3E9DB),
          ],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1440),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardHeroPanel(
                  now: now,
                  currentUser: currentUser,
                  summary: summary,
                  themeMode: themeMode,
                  onCommandPressed: onCommandPressed,
                  onToggleTheme: onToggleTheme,
                  onOpenProduct: onOpenProduct,
                  onOpenInventory: onOpenInventory,
                  onLogout: onLogout,
                ),
                const SizedBox(height: 22),
                DashboardSection(
                  title: '经营摘要',
                  subtitle: '店长开机第一屏需要先看到经营体温，再决定今天优先处理什么。',
                  trailing: const DashboardHintChip(
                    label: '销售与库存闭环接入前，部分指标为界面示意',
                    color: AppPallete.copper,
                  ),
                  child: Wrap(
                    spacing: 14,
                    runSpacing: 14,
                    children: [
                      for (final metric in metrics)
                        DashboardMetricCard(metric: metric),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                DashboardSection(
                  title: '快捷操作',
                  subtitle: '优先高频动作。',
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          for (final shortcut in shortcuts)
                            DashboardQuickActionTile(shortcut: shortcut),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          for (final group in moduleGroups)
                            DashboardModuleGroupCard(
                              group: group,
                              onPrimaryAction: () {
                                if (group.primaryPageKey case final key?) {
                                  onOpenPage(key);
                                } else {
                                  onShowPlannedFeature(
                                    group.primaryActionMessage,
                                  );
                                }
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _RiskAndBackupLayout(
                  summary: summary,
                  alerts: alerts,
                  onShowPlannedFeature: onShowPlannedFeature,
                ),
                const SizedBox(height: 18),
                _InsightLayout(
                  summary: summary,
                  categoryShare: categoryShare,
                  bestsellerItems: bestsellerItems,
                  slowMovingItems: slowMovingItems,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RiskAndBackupLayout extends StatelessWidget {
  const _RiskAndBackupLayout({
    required this.summary,
    required this.alerts,
    required this.onShowPlannedFeature,
  });

  final DashboardSummary summary;
  final List<DashboardAlert> alerts;
  final ValueChanged<String> onShowPlannedFeature;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 1120;
        final riskContent = DashboardSection(
          title: '风险与待办',
          subtitle: '先把影响经营效率和后续闭环的数据缺口收敛起来。',
          child: Column(
            children: [
              for (var index = 0; index < alerts.length; index++) ...[
                DashboardAlertTile(alert: alerts[index]),
                if (index != alerts.length - 1) const SizedBox(height: 12),
              ],
            ],
          ),
        );
        final backupContent = DashboardSection(
          title: '备份与运营节奏',
          subtitle: '离线单店软件最怕不是没功能，而是关键时刻没法恢复。',
          child: DashboardBackupReadinessCard(
            summary: summary,
            onBackupPressed: () =>
                onShowPlannedFeature('本地备份向导会在系统管理模块中接入，这里先保留操作入口样式。'),
          ),
        );

        if (stacked) {
          return Column(
            children: [riskContent, const SizedBox(height: 18), backupContent],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 7, child: riskContent),
            const SizedBox(width: 18),
            Expanded(flex: 5, child: backupContent),
          ],
        );
      },
    );
  }
}

class _InsightLayout extends StatelessWidget {
  const _InsightLayout({
    required this.summary,
    required this.categoryShare,
    required this.bestsellerItems,
    required this.slowMovingItems,
  });

  final DashboardSummary summary;
  final List<DashboardCategorySegment> categoryShare;
  final List<DashboardRankingItem> bestsellerItems;
  final List<DashboardRankingItem> slowMovingItems;

  @override
  Widget build(BuildContext context) {
    return DashboardSection(
      title: '经营洞察',
      subtitle: '图表保持克制，让你在几秒内看懂趋势、重点书单和品类分布。',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 1240;
          final topRow = compact
              ? Column(
                  children: [
                    DashboardInsightPanel(
                      title: '近 7 日经营趋势',
                      subtitle: '主页面示意曲线，后续接入销售日报与日结数据',
                      child: DashboardTrendChartCard(
                        points: dashboardTrendPoints,
                        footerLabel: '本周零售趋势较上周提升 8.6%',
                      ),
                    ),
                    const SizedBox(height: 18),
                    DashboardInsightPanel(
                      title: '分类销售占比',
                      subtitle: summary.hasCategories
                          ? '当前按商品主数据分类结构生成'
                          : '暂无分类主数据，先展示空状态',
                      child: DashboardCategoryShareCard(
                        segments: categoryShare,
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: DashboardInsightPanel(
                        title: '近 7 日经营趋势',
                        subtitle: '主页面示意曲线，后续接入销售日报与日结数据',
                        child: DashboardTrendChartCard(
                          points: dashboardTrendPoints,
                          footerLabel: '本周零售趋势较上周提升 8.6%',
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      flex: 5,
                      child: DashboardInsightPanel(
                        title: '分类销售占比',
                        subtitle: summary.hasCategories
                            ? '当前按商品主数据分类结构生成'
                            : '暂无分类主数据，先展示空状态',
                        child: DashboardCategoryShareCard(
                          segments: categoryShare,
                        ),
                      ),
                    ),
                  ],
                );

          return Column(
            children: [
              topRow,
              const SizedBox(height: 18),
              Wrap(
                spacing: 18,
                runSpacing: 18,
                children: [
                  SizedBox(
                    width: compact
                        ? constraints.maxWidth
                        : (constraints.maxWidth - 18) / 2,
                    child: DashboardInsightPanel(
                      title: '畅销 Top 10',
                      subtitle: '界面示意，后续接入销售单据后自动替换为真实排名',
                      child: DashboardRankingList(items: bestsellerItems),
                    ),
                  ),
                  SizedBox(
                    width: compact
                        ? constraints.maxWidth
                        : (constraints.maxWidth - 18) / 2,
                    child: DashboardInsightPanel(
                      title: '滞销 Top 10',
                      subtitle: '界面示意，后续接入库存流水后展示真实滞销书单',
                      child: DashboardRankingList(items: slowMovingItems),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
