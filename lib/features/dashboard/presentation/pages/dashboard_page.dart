import 'dart:async';
import 'dart:math' as math;

import 'package:bookstore_management_system/core/domain/entities/app_user.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/core/theme/theme_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.onOpenPage});

  final ValueChanged<String> onOpenPage;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Timer _clockTimer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _now = DateTime.now();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final bloc = context.read<ProductBloc>();
      if (bloc.state is! ProductsLoaded) {
        bloc.add(GetAllBooksEvent());
      }
    });
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.select((AuthBloc bloc) => bloc.state);
    final productState = context.select((ProductBloc bloc) => bloc.state);
    final themeMode = context.select((ThemeBloc bloc) => bloc.state.themeMode);

    final currentUser = authState is AuthSuccess ? authState.user : null;
    final products = productState is ProductsLoaded
        ? productState.products
        : <Product>[];
    final summary = _DashboardSummary.fromProducts(products);
    final metrics = _buildMetrics(summary);
    final shortcuts = _buildShortcuts(summary);
    final moduleGroups = _buildModuleGroups();
    final alerts = _buildAlerts(summary);
    final categoryShare = _buildCategoryShare(summary);
    final bestsellerItems = _buildRankingItems(
      products,
      fallbackTitles: const ['额尔古纳河右岸', '她来听我的演唱会', '长安的荔枝', '刀锋', '冬牧场'],
      accent: AppPallete.forest,
    );
    final slowMovingItems = _buildRankingItems(
      products.reversed.toList(),
      fallbackTitles: const ['旧书特价台', '艺术画册区', '旅行散文区', '外文文学角', '文创礼盒'],
      accent: AppPallete.copper,
    );
    final trendPoints = const <double>[9.2, 12.8, 11.6, 15.4, 14.2, 18.5, 16.9];

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
                _HeroPanel(
                  now: _now,
                  currentUser: currentUser,
                  summary: summary,
                  themeMode: themeMode,
                  onCommandPressed: () =>
                      _showPlannedFeature('全局搜索和命令面板会在后续统一接入商品、会员与销售单据检索。'),
                  onToggleTheme: () =>
                      context.read<ThemeBloc>().add(ToggleTheme()),
                  onOpenProduct: () => widget.onOpenPage('product'),
                  onOpenInventory: () => widget.onOpenPage('inventory'),
                  onLogout: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                ),
                const SizedBox(height: 22),
                _DashboardSection(
                  title: '经营摘要',
                  subtitle: '店长开机第一屏需要先看到经营体温，再决定今天优先处理什么。',
                  trailing: const _HintChip(
                    label: '销售与库存闭环接入前，部分指标为界面示意',
                    color: AppPallete.copper,
                  ),
                  child: Wrap(
                    spacing: 14,
                    runSpacing: 14,
                    children: [
                      for (final metric in metrics) _MetricCard(metric: metric),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _DashboardSection(
                  title: '快捷操作',
                  subtitle: '保留老系统一眼可达的业务感，但用更现代的卡片和优先级组织高频动作。',
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          for (final shortcut in shortcuts)
                            _QuickActionTile(shortcut: shortcut),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          for (final group in moduleGroups)
                            _ModuleGroupCard(
                              group: group,
                              onPrimaryAction: () {
                                if (group.primaryPageKey case final key?) {
                                  widget.onOpenPage(key);
                                } else {
                                  _showPlannedFeature(
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
                LayoutBuilder(
                  builder: (context, constraints) {
                    final stacked = constraints.maxWidth < 1120;
                    final riskContent = _DashboardSection(
                      title: '风险与待办',
                      subtitle: '先把影响经营效率和后续闭环的数据缺口收敛起来。',
                      child: Column(
                        children: [
                          for (
                            var index = 0;
                            index < alerts.length;
                            index++
                          ) ...[
                            _AlertTile(alert: alerts[index]),
                            if (index != alerts.length - 1)
                              const SizedBox(height: 12),
                          ],
                        ],
                      ),
                    );
                    final backupContent = _DashboardSection(
                      title: '备份与运营节奏',
                      subtitle: '离线单店软件最怕不是没功能，而是关键时刻没法恢复。',
                      child: _BackupReadinessCard(
                        summary: summary,
                        onBackupPressed: () => _showPlannedFeature(
                          '本地备份向导会在系统管理模块中接入，这里先保留操作入口样式。',
                        ),
                      ),
                    );

                    if (stacked) {
                      return Column(
                        children: [
                          riskContent,
                          const SizedBox(height: 18),
                          backupContent,
                        ],
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
                ),
                const SizedBox(height: 18),
                _DashboardSection(
                  title: '经营洞察',
                  subtitle: '图表保持克制，让你在几秒内看懂趋势、重点书单和品类分布。',
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final compact = constraints.maxWidth < 1240;
                      final firstRow = compact
                          ? Column(
                              children: [
                                _InsightPanel(
                                  title: '近 7 日经营趋势',
                                  subtitle: '主页面示意曲线，后续接入销售日报与日结数据',
                                  child: _TrendChartCard(
                                    points: trendPoints,
                                    footerLabel: '本周零售趋势较上周提升 8.6%',
                                  ),
                                ),
                                const SizedBox(height: 18),
                                _InsightPanel(
                                  title: '分类销售占比',
                                  subtitle: summary.hasCategories
                                      ? '当前按商品主数据分类结构生成'
                                      : '暂无分类主数据，先展示空状态',
                                  child: _CategoryShareCard(
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
                                  child: _InsightPanel(
                                    title: '近 7 日经营趋势',
                                    subtitle: '主页面示意曲线，后续接入销售日报与日结数据',
                                    child: _TrendChartCard(
                                      points: trendPoints,
                                      footerLabel: '本周零售趋势较上周提升 8.6%',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  flex: 5,
                                  child: _InsightPanel(
                                    title: '分类销售占比',
                                    subtitle: summary.hasCategories
                                        ? '当前按商品主数据分类结构生成'
                                        : '暂无分类主数据，先展示空状态',
                                    child: _CategoryShareCard(
                                      segments: categoryShare,
                                    ),
                                  ),
                                ),
                              ],
                            );

                      return Column(
                        children: [
                          firstRow,
                          const SizedBox(height: 18),
                          Wrap(
                            spacing: 18,
                            runSpacing: 18,
                            children: [
                              SizedBox(
                                width: compact
                                    ? constraints.maxWidth
                                    : (constraints.maxWidth - 18) / 2,
                                child: _InsightPanel(
                                  title: '畅销 Top 10',
                                  subtitle: '界面示意，后续接入销售单据后自动替换为真实排名',
                                  child: _RankingList(items: bestsellerItems),
                                ),
                              ),
                              SizedBox(
                                width: compact
                                    ? constraints.maxWidth
                                    : (constraints.maxWidth - 18) / 2,
                                child: _InsightPanel(
                                  title: '滞销 Top 10',
                                  subtitle: '界面示意，后续接入库存流水后展示真实滞销书单',
                                  child: _RankingList(items: slowMovingItems),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_DashboardMetric> _buildMetrics(_DashboardSummary summary) {
    return [
      const _DashboardMetric(
        title: '今日销售额',
        value: '12,860',
        prefix: '¥',
        delta: '+8.4%',
        note: '较昨日',
        tone: _MetricTone.forest,
      ),
      const _DashboardMetric(
        title: '今日销售单数',
        value: '83',
        delta: '+12 单',
        note: '高峰在 14:00 - 17:00',
        tone: _MetricTone.sky,
      ),
      const _DashboardMetric(
        title: '客单价',
        value: '154',
        prefix: '¥',
        delta: '+6.1%',
        note: '会员消费带动提升',
        tone: _MetricTone.copper,
      ),
      const _DashboardMetric(
        title: '会员销售占比',
        value: '38%',
        delta: '+4.8%',
        note: '储值消费活跃',
        tone: _MetricTone.forest,
      ),
      const _DashboardMetric(
        title: '本月累计销售',
        value: '186,420',
        prefix: '¥',
        delta: '目标完成 64%',
        note: '距月目标还差 104,580',
        tone: _MetricTone.ink,
      ),
      _DashboardMetric(
        title: '经营待关注',
        value: '${summary.pendingAttentionCount}',
        suffix: ' 项',
        delta: summary.pendingAttentionCount > 0 ? '优先处理资料与备份' : '当前无明显异常',
        note: '由货架位 / ISBN / 分类缺口推导',
        tone: summary.pendingAttentionCount > 10
            ? _MetricTone.brick
            : _MetricTone.copper,
      ),
    ];
  }

  List<_DashboardShortcut> _buildShortcuts(_DashboardSummary summary) {
    return [
      _DashboardShortcut(
        title: '新建收货单',
        subtitle: '按供应商收货入库，形成库存增长',
        icon: Icons.local_shipping_outlined,
        color: AppPallete.forest,
        onTap: () => _showPlannedFeature('收货单模块还未接入，当前先完成首页与导航体验。'),
      ),
      _DashboardShortcut(
        title: '打开零售收银',
        subtitle: '面向营业员的高频收银入口',
        icon: Icons.point_of_sale_outlined,
        color: AppPallete.copper,
        onTap: () => _showPlannedFeature('零售收银模块会在销售管理迭代中接入。'),
      ),
      _DashboardShortcut(
        title: '会员充值',
        subtitle: '会员储值、赠送与余额流水',
        icon: Icons.account_balance_wallet_outlined,
        color: AppPallete.forestDeep,
        onTap: () => _showPlannedFeature('会员充值模块尚未接入，这里先保留主页面操作位。'),
      ),
      _DashboardShortcut(
        title: '库存查询',
        subtitle: '进入库存模块查看结存与后续流水',
        icon: Icons.inventory_2_outlined,
        color: AppPallete.ink,
        onTap: () => widget.onOpenPage('inventory'),
      ),
      _DashboardShortcut(
        title: '销售退货',
        subtitle: '保留原单追溯与原路退款入口',
        icon: Icons.assignment_return_outlined,
        color: AppPallete.brick,
        onTap: () => _showPlannedFeature('销售退货会在零售与库存闭环完成后接入。'),
      ),
      _DashboardShortcut(
        title: '本地备份',
        subtitle: summary.backupSummaryLabel,
        icon: Icons.backup_outlined,
        color: AppPallete.sky,
        onTap: () => _showPlannedFeature('备份向导尚未开发，这里先完成首页入口和状态样式。'),
      ),
    ];
  }

  List<_ModuleGroup> _buildModuleGroups() {
    return const [
      _ModuleGroup(
        title: '基础数据',
        subtitle: '先把商品、供应商、会员和人员资料打牢，后续所有单据都复用这里的主数据。',
        icon: Icons.menu_book_outlined,
        accent: AppPallete.forest,
        badges: ['P0', '商品已接入'],
        features: ['商品资料', '供应商资料', '会员资料', '人员权限'],
        primaryActionLabel: '进入商品资料',
        primaryActionMessage: '商品资料模块已接入。',
        primaryPageKey: 'product',
      ),
      _ModuleGroup(
        title: '订收管理',
        subtitle: '承接老系统里最关键的收货入库和采购退货逻辑，是库存闭环的起点。',
        icon: Icons.receipt_long_outlined,
        accent: AppPallete.copper,
        badges: ['P0', '待接入'],
        features: ['收货单', '收货退货单', '供应商往来', '采购建议'],
        primaryActionLabel: '规划收货工作台',
        primaryActionMessage: '订收管理模块还在规划中，当前主页先预留业务位置。',
      ),
      _ModuleGroup(
        title: '销售管理',
        subtitle: '把零售收银、销售退货、会员储值和日结节奏放在一个高频操作域里。',
        icon: Icons.storefront_outlined,
        accent: AppPallete.brick,
        badges: ['P0', '高频入口'],
        features: ['零售收银', '销售退货', '会员充值', '日结班结'],
        primaryActionLabel: '查看零售规划',
        primaryActionMessage: '销售管理模块将作为下一阶段主线能力接入。',
      ),
      _ModuleGroup(
        title: '统计分析',
        subtitle: '主页面自身就是经营全景透视的第一层，后续再进入明细报表和综合查询。',
        icon: Icons.query_stats_outlined,
        accent: AppPallete.ink,
        badges: ['P0', '首页承载'],
        features: ['综合查询', '经营全景', '畅销滞销', '库存预警'],
        primaryActionLabel: '进入库存查询',
        primaryActionMessage: '统计分析明细未完成，当前可先查看库存模块入口。',
        primaryPageKey: 'inventory',
      ),
      _ModuleGroup(
        title: '系统管理',
        subtitle: '离线单店软件必须把权限、参数、日志和备份放到足够靠前的位置。',
        icon: Icons.admin_panel_settings_outlined,
        accent: AppPallete.sky,
        badges: ['P0', '离线优先'],
        features: ['权限角色', '参数配置', '本地备份', '操作审计'],
        primaryActionLabel: '查看系统规划',
        primaryActionMessage: '系统管理模块会在业务闭环完成后集中接入。',
      ),
    ];
  }

  List<_DashboardAlert> _buildAlerts(_DashboardSummary summary) {
    return [
      _DashboardAlert(
        title: '待补充货架位',
        detail: '还没有默认货架位的商品会影响找书效率和后续盘点准确性。',
        value: '${summary.missingShelfCount} 本',
        tone: summary.missingShelfCount > 10
            ? _AlertTone.warning
            : _AlertTone.normal,
        icon: Icons.library_books_outlined,
      ),
      _DashboardAlert(
        title: 'ISBN 待完善',
        detail: 'ISBN 缺口会直接影响扫码收货、零售搜索和后续畅销分析。',
        value: '${summary.missingIsbnCount} 本',
        tone: summary.missingIsbnCount > 10
            ? _AlertTone.critical
            : _AlertTone.warning,
        icon: Icons.qr_code_scanner_outlined,
      ),
      _DashboardAlert(
        title: '商品分类待归档',
        detail: '分类结构越完整，经营透视图和推荐补货策略就越有参考价值。',
        value: '${summary.missingCategoryCount} 本',
        tone: summary.missingCategoryCount > 12
            ? _AlertTone.warning
            : _AlertTone.normal,
        icon: Icons.category_outlined,
      ),
      _DashboardAlert(
        title: '最近备份状态',
        detail: '建议至少按日完成一次本地备份，离线系统要把恢复能力当成核心功能。',
        value: summary.backupSummaryLabel,
        tone: _AlertTone.normal,
        icon: Icons.verified_user_outlined,
      ),
    ];
  }

  List<_CategorySegment> _buildCategoryShare(_DashboardSummary summary) {
    const palette = [
      AppPallete.forest,
      AppPallete.copper,
      AppPallete.ink,
      AppPallete.sky,
      AppPallete.brick,
    ];

    if (summary.categoryDistribution.isEmpty) {
      return const [];
    }

    final total = summary.categoryDistribution.values.fold<int>(
      0,
      (sum, value) => sum + value,
    );

    final entries = summary.categoryDistribution.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return List<_CategorySegment>.generate(
      math.min(entries.length, palette.length),
      (index) {
        final entry = entries[index];
        return _CategorySegment(
          label: entry.key,
          value: entry.value,
          fraction: entry.value / total,
          color: palette[index],
        );
      },
    );
  }

  List<_RankingItem> _buildRankingItems(
    List<Product> products, {
    required List<String> fallbackTitles,
    required Color accent,
  }) {
    final titles = products
        .map((product) => product.title.trim())
        .where((title) => title.isNotEmpty)
        .toSet()
        .take(10)
        .toList();
    final values = <int>[98, 91, 84, 76, 69, 63, 58, 53, 47, 39];
    final source = titles.isEmpty ? fallbackTitles : titles;

    return List<_RankingItem>.generate(
      math.min(10, source.length),
      (index) => _RankingItem(
        label: source[index],
        value: values[index],
        accent: accent,
        caption: index < 3 ? '核心陈列位' : '常规书单',
      ),
    );
  }

  void _showPlannedFeature(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({
    required this.now,
    required this.currentUser,
    required this.summary,
    required this.themeMode,
    required this.onCommandPressed,
    required this.onToggleTheme,
    required this.onOpenProduct,
    required this.onOpenInventory,
    required this.onLogout,
  });

  final DateTime now;
  final AppUser? currentUser;
  final _DashboardSummary summary;
  final ThemeMode themeMode;
  final VoidCallback onCommandPressed;
  final VoidCallback onToggleTheme;
  final VoidCallback onOpenProduct;
  final VoidCallback onOpenInventory;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final greeting = switch (now.hour) {
      < 11 => '早上好',
      < 14 => '中午好',
      < 19 => '下午好',
      _ => '晚上好',
    };

    final infoTiles = [
      _HeroInfoTile(
        label: '商品档案',
        value: '${summary.productCount}',
        caption: '已建主数据',
      ),
      _HeroInfoTile(
        label: '分类数量',
        value: '${summary.categoryCount}',
        caption: '用于经营透视',
      ),
      _HeroInfoTile(
        label: '待补 ISBN',
        value: '${summary.missingIsbnCount}',
        caption: '影响扫码效率',
      ),
      _HeroInfoTile(
        label: '待补货架',
        value: '${summary.missingShelfCount}',
        caption: '影响找书与盘点',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppPallete.paperBorder),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFDF9F3), Color(0xFFF1E6D8)],
        ),
        boxShadow: const [
          BoxShadow(
            color: AppPallete.cardShadow,
            blurRadius: 22,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 1080;

          final lead = Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const [
                    _HintChip(label: '单店离线模式', color: AppPallete.forest),
                    _HintChip(label: '主仓营运中', color: AppPallete.copper),
                    _HintChip(label: '首页已切换为店长驾驶舱', color: AppPallete.ink),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  '$greeting，欢迎回到溪川书店主控台',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppPallete.ink,
                    fontWeight: FontWeight.w800,
                    height: 1.16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '今天先看经营体温，再决定去收货、补资料还是盯住库存预警。主页面把老系统的一眼可达保留下来，但换成更适合现代单店书店经营的层级。',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPallete.mutedInk,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 18),
                InkWell(
                  onTap: onCommandPressed,
                  borderRadius: BorderRadius.circular(18),
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.78),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppPallete.paperBorder),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: AppPallete.mutedInk),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '搜索商品、ISBN、会员或输入命令',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppPallete.mutedInk),
                          ),
                        ),
                        const _KeyboardTag(label: 'Ctrl'),
                        const SizedBox(width: 6),
                        const _KeyboardTag(label: 'K'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: onOpenProduct,
                      icon: const Icon(Icons.menu_book_outlined),
                      label: const Text('进入商品资料'),
                    ),
                    OutlinedButton.icon(
                      onPressed: onOpenInventory,
                      icon: const Icon(Icons.inventory_2_outlined),
                      label: const Text('查看库存入口'),
                    ),
                  ],
                ),
              ],
            ),
          );

          final side = SizedBox(
            width: compact ? double.infinity : 360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _OperatorCard(
                  now: now,
                  currentUser: currentUser,
                  themeMode: themeMode,
                  onToggleTheme: onToggleTheme,
                  onLogout: onLogout,
                ),
                const SizedBox(height: 14),
                Wrap(spacing: 12, runSpacing: 12, children: infoTiles),
              ],
            ),
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [lead, const SizedBox(height: 20), side],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [lead, const SizedBox(width: 24), side],
          );
        },
      ),
    );
  }
}

class _OperatorCard extends StatelessWidget {
  const _OperatorCard({
    required this.now,
    required this.currentUser,
    required this.themeMode,
    required this.onToggleTheme,
    required this.onLogout,
  });

  final DateTime now;
  final AppUser? currentUser;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppPallete.paperBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppPallete.forest.withValues(alpha: 0.12),
                child: Text(
                  (currentUser?.username.isNotEmpty == true
                      ? currentUser!.username.substring(0, 1)
                      : '店'),
                  style: const TextStyle(
                    color: AppPallete.forestDeep,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentUser?.username ?? '未登录用户',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppPallete.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatRole(currentUser?.role),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppPallete.mutedInk,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_horiz, color: AppPallete.ink),
                onSelected: (value) {
                  if (value == 'theme') {
                    onToggleTheme();
                  } else if (value == 'logout') {
                    onLogout();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: 'theme',
                    child: Text(
                      themeMode == ThemeMode.dark ? '切换为浅色模式' : '切换为深色模式',
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Text('退出登录'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          _MetaLine(label: '当前时间', value: _formatNow(now)),
          const SizedBox(height: 8),
          const _MetaLine(label: '工作状态', value: '营业中 · 今日建议先查看经营待关注'),
        ],
      ),
    );
  }
}

class _DashboardSection extends StatelessWidget {
  const _DashboardSection({
    required this.title,
    required this.subtitle,
    required this.child,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppPallete.paperElevated.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppPallete.paperBorder),
        boxShadow: const [
          BoxShadow(
            color: AppPallete.cardShadow,
            blurRadius: 18,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppPallete.ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppPallete.mutedInk,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
              if (trailing != null) ...[trailing!],
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.metric});

  final _DashboardMetric metric;

  @override
  Widget build(BuildContext context) {
    final color = switch (metric.tone) {
      _MetricTone.forest => AppPallete.forest,
      _MetricTone.copper => AppPallete.copper,
      _MetricTone.sky => const Color(0xFF47786D),
      _MetricTone.brick => AppPallete.brick,
      _MetricTone.ink => AppPallete.ink,
    };

    return Container(
      width: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metric.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppPallete.mutedInk,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
              children: [
                if (metric.prefix != null)
                  TextSpan(
                    text: metric.prefix,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                TextSpan(text: metric.value),
                if (metric.suffix != null)
                  TextSpan(
                    text: metric.suffix,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              metric.delta,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            metric.note,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppPallete.mutedInk,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatefulWidget {
  const _QuickActionTile({required this.shortcut});

  final _DashboardShortcut shortcut;

  @override
  State<_QuickActionTile> createState() => _QuickActionTileState();
}

class _QuickActionTileState extends State<_QuickActionTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final shortcut = widget.shortcut;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: shortcut.onTap,
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 214,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _hovered ? 0.98 : 0.86),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: shortcut.color.withValues(alpha: _hovered ? 0.32 : 0.16),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: shortcut.color.withValues(alpha: 0.14),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : const [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: shortcut.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(shortcut.icon, color: shortcut.color),
              ),
              const SizedBox(height: 14),
              Text(
                shortcut.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPallete.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                shortcut.subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppPallete.mutedInk,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuleGroupCard extends StatelessWidget {
  const _ModuleGroupCard({required this.group, required this.onPrimaryAction});

  final _ModuleGroup group;
  final VoidCallback onPrimaryAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 266,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: group.accent.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: group.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(group.icon, color: group.accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppPallete.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final badge in group.badges)
                          _HintChip(label: badge, color: group.accent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            group.subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppPallete.mutedInk,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          for (final feature in group.features) ...[
            _FeatureLine(label: feature, color: group.accent),
            if (feature != group.features.last) const SizedBox(height: 8),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onPrimaryAction,
              icon: const Icon(Icons.arrow_forward_outlined),
              label: Text(group.primaryActionLabel),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  const _AlertTile({required this.alert});

  final _DashboardAlert alert;

  @override
  Widget build(BuildContext context) {
    final color = switch (alert.tone) {
      _AlertTone.normal => AppPallete.forest,
      _AlertTone.warning => AppPallete.copper,
      _AlertTone.critical => AppPallete.brick,
    };

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(alert.icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppPallete.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  alert.detail,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppPallete.mutedInk,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            alert.value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _BackupReadinessCard extends StatelessWidget {
  const _BackupReadinessCard({
    required this.summary,
    required this.onBackupPressed,
  });

  final _DashboardSummary summary;
  final VoidCallback onBackupPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.82),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppPallete.paperBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HintChip(label: '离线经营必须优先保证可恢复', color: AppPallete.ink),
              const SizedBox(height: 14),
              Text(
                '最近一次建议备份',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppPallete.mutedInk),
              ),
              const SizedBox(height: 6),
              Text(
                summary.backupSummaryLabel,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppPallete.ink,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                '完成收货单、零售单和会员充值之后，建议在闭店前做一次数据库备份，并把最近 7 天备份保留在本地磁盘与移动介质两处。',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppPallete.mutedInk,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onBackupPressed,
                  icon: const Icon(Icons.backup_outlined),
                  label: const Text('打开备份向导'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppPallete.copperSoft.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: const [
              _MiniStatus(label: '今日建议', value: '闭店前备份'),
              _MiniStatus(label: '库存闭环', value: '待接入'),
              _MiniStatus(label: '零售收银', value: '待接入'),
              _MiniStatus(label: '主数据完整度', value: '持续提升'),
            ],
          ),
        ),
      ],
    );
  }
}

class _InsightPanel extends StatelessWidget {
  const _InsightPanel({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppPallete.paperBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppPallete.ink,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppPallete.mutedInk,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _TrendChartCard extends StatelessWidget {
  const _TrendChartCard({required this.points, required this.footerLabel});

  final List<double> points;
  final String footerLabel;

  @override
  Widget build(BuildContext context) {
    const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: CustomPaint(
            painter: _TrendPainter(
              points: points,
              lineColor: AppPallete.forest,
              fillColor: AppPallete.sky.withValues(alpha: 0.32),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: weekdays
                        .map(
                          (day) => Text(
                            day,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppPallete.mutedInk),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppPallete.forest,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                footerLabel,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppPallete.mutedInk),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoryShareCard extends StatelessWidget {
  const _CategoryShareCard({required this.segments});

  final List<_CategorySegment> segments;

  @override
  Widget build(BuildContext context) {
    if (segments.isEmpty) {
      return Container(
        height: 240,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppPallete.paper.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.pie_chart_outline_rounded,
              size: 42,
              color: AppPallete.mutedInk,
            ),
            const SizedBox(height: 12),
            Text(
              '暂无分类主数据',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppPallete.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '先完善商品分类后，这里会自动展示品类占比。',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppPallete.mutedInk),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        SizedBox(
          width: 180,
          height: 180,
          child: CustomPaint(
            painter: _DonutPainter(segments: segments),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '品类',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppPallete.mutedInk),
                  ),
                  Text(
                    '${segments.length}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppPallete.ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            children: [
              for (final segment in segments) ...[
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: segment.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        segment.label,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppPallete.ink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '${(segment.fraction * 100).round()}%',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: segment.color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _RankingList extends StatelessWidget {
  const _RankingList({required this.items});

  final List<_RankingItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < items.length; index++) ...[
          _RankingRow(rank: index + 1, item: items[index]),
          if (index != items.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _RankingRow extends StatelessWidget {
  const _RankingRow({required this.rank, required this.item});

  final int rank;
  final _RankingItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: item.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$rank',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: item.accent,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppPallete.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.caption,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppPallete.mutedInk),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: item.value / 100,
              minHeight: 10,
              backgroundColor: item.accent.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(item.accent),
            ),
          ),
        ),
      ],
    );
  }
}

class _HintChip extends StatelessWidget {
  const _HintChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _KeyboardTag extends StatelessWidget {
  const _KeyboardTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppPallete.paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppPallete.paperBorder),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppPallete.mutedInk,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _HeroInfoTile extends StatelessWidget {
  const _HeroInfoTile({
    required this.label,
    required this.value,
    required this.caption,
  });

  final String label;
  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppPallete.paperBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppPallete.mutedInk),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppPallete.ink,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            caption,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppPallete.mutedInk),
          ),
        ],
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppPallete.mutedInk),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppPallete.ink,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureLine extends StatelessWidget {
  const _FeatureLine({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppPallete.ink),
          ),
        ),
      ],
    );
  }
}

class _MiniStatus extends StatelessWidget {
  const _MiniStatus({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 148,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppPallete.mutedInk),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppPallete.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  _TrendPainter({
    required this.points,
    required this.lineColor,
    required this.fillColor,
  });

  final List<double> points;
  final Color lineColor;
  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) {
      return;
    }

    final padding = const EdgeInsets.fromLTRB(12, 18, 12, 26);
    final chartRect = Rect.fromLTWH(
      padding.left,
      padding.top,
      size.width - padding.horizontal,
      size.height - padding.vertical,
    );

    final minValue = points.reduce(math.min);
    final maxValue = points.reduce(math.max);
    final range = maxValue - minValue == 0 ? 1 : maxValue - minValue;
    final stepX = chartRect.width / (points.length - 1);

    final linePath = Path();
    final fillPath = Path();

    for (var i = 0; i < points.length; i++) {
      final x = chartRect.left + stepX * i;
      final y =
          chartRect.bottom -
          ((points[i] - minValue) / range) * chartRect.height;
      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, chartRect.bottom);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(chartRect.right, chartRect.bottom);
    fillPath.close();

    final gridPaint = Paint()
      ..color = AppPallete.paperBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var index = 0; index < 4; index++) {
      final y = chartRect.top + chartRect.height * index / 3;
      canvas.drawLine(
        Offset(chartRect.left, y),
        Offset(chartRect.right, y),
        gridPaint,
      );
    }

    final fillPaint = Paint()..color = fillColor;
    final linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3;

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);

    final pointPaint = Paint()..color = lineColor;
    for (var i = 0; i < points.length; i++) {
      final x = chartRect.left + stepX * i;
      final y =
          chartRect.bottom -
          ((points[i] - minValue) / range) * chartRect.height;
      canvas.drawCircle(Offset(x, y), 4, pointPaint);
      canvas.drawCircle(
        Offset(x, y),
        8,
        Paint()..color = lineColor.withValues(alpha: 0.10),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TrendPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.fillColor != fillColor;
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter({required this.segments});

  final List<_CategorySegment> segments;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    const strokeWidth = 18.0;
    var startAngle = -math.pi / 2;

    for (final segment in segments) {
      final sweep = 2 * math.pi * segment.fraction;
      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        rect.deflate(strokeWidth),
        startAngle,
        sweep,
        false,
        paint,
      );
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) {
    return oldDelegate.segments != segments;
  }
}

String _formatRole(String? role) {
  return switch (role) {
    'admin' => '系统管理员',
    'manager' => '店长',
    'cashier' => '营业员 / 收银员',
    'purchaser' => '采购 / 收货员',
    'stock_keeper' => '仓管员',
    _ => '书店运营角色',
  };
}

String _formatNow(DateTime now) {
  const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
  final day = weekdays[now.weekday - 1];
  final hh = now.hour.toString().padLeft(2, '0');
  final mm = now.minute.toString().padLeft(2, '0');
  return '${now.year}年${now.month}月${now.day}日 $day $hh:$mm';
}

class _DashboardSummary {
  const _DashboardSummary({
    required this.productCount,
    required this.categoryCount,
    required this.publisherCount,
    required this.missingIsbnCount,
    required this.missingShelfCount,
    required this.missingCategoryCount,
    required this.categoryDistribution,
    required this.lastBackupAt,
  });

  final int productCount;
  final int categoryCount;
  final int publisherCount;
  final int missingIsbnCount;
  final int missingShelfCount;
  final int missingCategoryCount;
  final Map<String, int> categoryDistribution;
  final DateTime lastBackupAt;

  int get pendingAttentionCount =>
      missingIsbnCount + missingShelfCount + missingCategoryCount;

  bool get hasCategories => categoryDistribution.isNotEmpty;

  String get backupSummaryLabel => _formatNow(lastBackupAt);

  factory _DashboardSummary.fromProducts(List<Product> products) {
    final categoryDistribution = <String, int>{};
    final publishers = <String>{};
    final categories = <String>{};
    var missingIsbnCount = 0;
    var missingShelfCount = 0;
    var missingCategoryCount = 0;

    for (final product in products) {
      final isbn = product.isbn?.trim() ?? '';
      final bookmark = product.bookmark?.trim() ?? '';
      final category = product.category?.trim() ?? '';
      final publisher = product.publisher?.trim() ?? '';

      if (isbn.isEmpty) {
        missingIsbnCount++;
      }
      if (bookmark.isEmpty) {
        missingShelfCount++;
      }
      if (category.isEmpty) {
        missingCategoryCount++;
      } else {
        categories.add(category);
        categoryDistribution.update(
          category,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
      if (publisher.isNotEmpty) {
        publishers.add(publisher);
      }
    }

    return _DashboardSummary(
      productCount: products.length,
      categoryCount: categories.length,
      publisherCount: publishers.length,
      missingIsbnCount: missingIsbnCount,
      missingShelfCount: missingShelfCount,
      missingCategoryCount: missingCategoryCount,
      categoryDistribution: categoryDistribution,
      lastBackupAt: DateTime.now().subtract(
        const Duration(hours: 7, minutes: 40),
      ),
    );
  }
}

class _DashboardMetric {
  const _DashboardMetric({
    required this.title,
    required this.value,
    required this.delta,
    required this.note,
    required this.tone,
    this.prefix,
    this.suffix,
  });

  final String title;
  final String value;
  final String delta;
  final String note;
  final _MetricTone tone;
  final String? prefix;
  final String? suffix;
}

enum _MetricTone { forest, copper, sky, brick, ink }

class _DashboardShortcut {
  const _DashboardShortcut({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
}

class _ModuleGroup {
  const _ModuleGroup({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.badges,
    required this.features,
    required this.primaryActionLabel,
    required this.primaryActionMessage,
    this.primaryPageKey,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final List<String> badges;
  final List<String> features;
  final String primaryActionLabel;
  final String primaryActionMessage;
  final String? primaryPageKey;
}

class _DashboardAlert {
  const _DashboardAlert({
    required this.title,
    required this.detail,
    required this.value,
    required this.tone,
    required this.icon,
  });

  final String title;
  final String detail;
  final String value;
  final _AlertTone tone;
  final IconData icon;
}

enum _AlertTone { normal, warning, critical }

class _CategorySegment {
  const _CategorySegment({
    required this.label,
    required this.value,
    required this.fraction,
    required this.color,
  });

  final String label;
  final int value;
  final double fraction;
  final Color color;
}

class _RankingItem {
  const _RankingItem({
    required this.label,
    required this.value,
    required this.accent,
    required this.caption,
  });

  final String label;
  final int value;
  final Color accent;
  final String caption;
}
