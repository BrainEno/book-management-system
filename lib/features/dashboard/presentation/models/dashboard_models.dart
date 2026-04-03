import 'dart:math' as math;

import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:flutter/material.dart';

String formatDashboardRole(String? role) {
  return switch (role) {
    'admin' => '系统管理员',
    'manager' => '店长',
    'cashier' => '营业员 / 收银员',
    'purchaser' => '采购 / 收货员',
    'stock_keeper' => '仓管员',
    _ => '书店运营角色',
  };
}

String formatDashboardNow(DateTime now) {
  const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
  final day = weekdays[now.weekday - 1];
  final hh = now.hour.toString().padLeft(2, '0');
  final mm = now.minute.toString().padLeft(2, '0');
  return '${now.year}年${now.month}月${now.day}日 $day $hh:$mm';
}

const List<double> dashboardTrendPoints = <double>[
  9.2,
  12.8,
  11.6,
  15.4,
  14.2,
  18.5,
  16.9,
];

class DashboardSummary {
  const DashboardSummary({
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

  String get backupSummaryLabel => formatDashboardNow(lastBackupAt);

  factory DashboardSummary.fromProducts(List<Product> products) {
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

    return DashboardSummary(
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

class DashboardMetric {
  const DashboardMetric({
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
  final DashboardMetricTone tone;
  final String? prefix;
  final String? suffix;
}

enum DashboardMetricTone { forest, copper, sky, brick, ink }

class DashboardShortcut {
  const DashboardShortcut({
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

class DashboardModuleGroup {
  const DashboardModuleGroup({
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

class DashboardAlert {
  const DashboardAlert({
    required this.title,
    required this.detail,
    required this.value,
    required this.tone,
    required this.icon,
  });

  final String title;
  final String detail;
  final String value;
  final DashboardAlertTone tone;
  final IconData icon;
}

enum DashboardAlertTone { normal, warning, critical }

class DashboardCategorySegment {
  const DashboardCategorySegment({
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

class DashboardRankingItem {
  const DashboardRankingItem({
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

List<DashboardMetric> buildDashboardMetrics(DashboardSummary summary) {
  return [
    const DashboardMetric(
      title: '今日销售额',
      value: '12,860',
      prefix: '¥',
      delta: '+8.4%',
      note: '较昨日',
      tone: DashboardMetricTone.forest,
    ),
    const DashboardMetric(
      title: '今日销售单数',
      value: '83',
      delta: '+12 单',
      note: '高峰在 14:00 - 17:00',
      tone: DashboardMetricTone.sky,
    ),
    const DashboardMetric(
      title: '客单价',
      value: '154',
      prefix: '¥',
      delta: '+6.1%',
      note: '会员消费带动提升',
      tone: DashboardMetricTone.copper,
    ),
    const DashboardMetric(
      title: '会员销售占比',
      value: '38%',
      delta: '+4.8%',
      note: '储值消费活跃',
      tone: DashboardMetricTone.forest,
    ),
    const DashboardMetric(
      title: '本月累计销售',
      value: '186,420',
      prefix: '¥',
      delta: '目标完成 64%',
      note: '距月目标还差 104,580',
      tone: DashboardMetricTone.ink,
    ),
    DashboardMetric(
      title: '经营待关注',
      value: '${summary.pendingAttentionCount}',
      suffix: ' 项',
      delta: summary.pendingAttentionCount > 0 ? '优先处理资料与备份' : '当前无明显异常',
      note: '由货架位 / ISBN / 分类缺口推导',
      tone: summary.pendingAttentionCount > 10
          ? DashboardMetricTone.brick
          : DashboardMetricTone.copper,
    ),
  ];
}

List<DashboardShortcut> buildDashboardShortcuts({
  required DashboardSummary summary,
  required VoidCallback onOpenInventory,
  required ValueChanged<String> onShowPlannedFeature,
}) {
  return [
    DashboardShortcut(
      title: '新建收货单',
      subtitle: '按供应商收货入库，形成库存增长',
      icon: Icons.local_shipping_outlined,
      color: AppPallete.forest,
      onTap: () => onShowPlannedFeature('收货单模块还未接入，当前先完成首页与导航体验。'),
    ),
    DashboardShortcut(
      title: '打开零售收银',
      subtitle: '面向营业员的高频收银入口',
      icon: Icons.point_of_sale_outlined,
      color: AppPallete.copper,
      onTap: () => onShowPlannedFeature('零售收银模块会在销售管理迭代中接入。'),
    ),
    DashboardShortcut(
      title: '会员充值',
      subtitle: '会员储值、赠送与余额流水',
      icon: Icons.account_balance_wallet_outlined,
      color: AppPallete.forestDeep,
      onTap: () => onShowPlannedFeature('会员充值模块尚未接入，这里先保留主页面操作位。'),
    ),
    DashboardShortcut(
      title: '库存查询',
      subtitle: '进入库存模块查看结存与后续流水',
      icon: Icons.inventory_2_outlined,
      color: AppPallete.ink,
      onTap: onOpenInventory,
    ),
    DashboardShortcut(
      title: '销售退货',
      subtitle: '保留原单追溯与原路退款入口',
      icon: Icons.assignment_return_outlined,
      color: AppPallete.brick,
      onTap: () => onShowPlannedFeature('销售退货会在零售与库存闭环完成后接入。'),
    ),
    DashboardShortcut(
      title: '本地备份',
      subtitle: summary.backupSummaryLabel,
      icon: Icons.backup_outlined,
      color: AppPallete.sky,
      onTap: () => onShowPlannedFeature('备份向导尚未开发，这里先完成首页入口和状态样式。'),
    ),
  ];
}

List<DashboardModuleGroup> buildDashboardModuleGroups() {
  return const [
    DashboardModuleGroup(
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
    DashboardModuleGroup(
      title: '订收管理',
      subtitle: '承接老系统里最关键的收货入库和采购退货逻辑，是库存闭环的起点。',
      icon: Icons.receipt_long_outlined,
      accent: AppPallete.copper,
      badges: ['P0', '待接入'],
      features: ['收货单', '收货退货单', '供应商往来', '采购建议'],
      primaryActionLabel: '规划收货工作台',
      primaryActionMessage: '订收管理模块还在规划中，当前主页先预留业务位置。',
    ),
    DashboardModuleGroup(
      title: '销售管理',
      subtitle: '把零售收银、销售退货、会员储值和日结节奏放在一个高频操作域里。',
      icon: Icons.storefront_outlined,
      accent: AppPallete.brick,
      badges: ['P0', '高频入口'],
      features: ['零售收银', '销售退货', '会员充值', '日结班结'],
      primaryActionLabel: '查看零售规划',
      primaryActionMessage: '销售管理模块将作为下一阶段主线能力接入。',
    ),
    DashboardModuleGroup(
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
    DashboardModuleGroup(
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

List<DashboardAlert> buildDashboardAlerts(DashboardSummary summary) {
  return [
    DashboardAlert(
      title: '待补充货架位',
      detail: '还没有默认货架位的商品会影响找书效率和后续盘点准确性。',
      value: '${summary.missingShelfCount} 本',
      tone: summary.missingShelfCount > 10
          ? DashboardAlertTone.warning
          : DashboardAlertTone.normal,
      icon: Icons.library_books_outlined,
    ),
    DashboardAlert(
      title: 'ISBN 待完善',
      detail: 'ISBN 缺口会直接影响扫码收货、零售搜索和后续畅销分析。',
      value: '${summary.missingIsbnCount} 本',
      tone: summary.missingIsbnCount > 10
          ? DashboardAlertTone.critical
          : DashboardAlertTone.warning,
      icon: Icons.qr_code_scanner_outlined,
    ),
    DashboardAlert(
      title: '商品分类待归档',
      detail: '分类结构越完整，经营透视图和推荐补货策略就越有参考价值。',
      value: '${summary.missingCategoryCount} 本',
      tone: summary.missingCategoryCount > 12
          ? DashboardAlertTone.warning
          : DashboardAlertTone.normal,
      icon: Icons.category_outlined,
    ),
    DashboardAlert(
      title: '最近备份状态',
      detail: '建议至少按日完成一次本地备份，离线系统要把恢复能力当成核心功能。',
      value: summary.backupSummaryLabel,
      tone: DashboardAlertTone.normal,
      icon: Icons.verified_user_outlined,
    ),
  ];
}

List<DashboardCategorySegment> buildDashboardCategoryShare(
  DashboardSummary summary,
) {
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

  return List<DashboardCategorySegment>.generate(
    math.min(entries.length, palette.length),
    (index) {
      final entry = entries[index];
      return DashboardCategorySegment(
        label: entry.key,
        value: entry.value,
        fraction: entry.value / total,
        color: palette[index],
      );
    },
  );
}

List<DashboardRankingItem> buildDashboardRankingItems(
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
  const values = <int>[98, 91, 84, 76, 69, 63, 58, 53, 47, 39];
  final source = titles.isEmpty ? fallbackTitles : titles;

  return List<DashboardRankingItem>.generate(
    math.min(10, source.length),
    (index) => DashboardRankingItem(
      label: source[index],
      value: values[index],
      accent: accent,
      caption: index < 3 ? '核心陈列位' : '常规书单',
    ),
  );
}
