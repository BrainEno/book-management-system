import 'package:bookstore_management_system/core/domain/entities/app_user.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/dashboard/presentation/models/dashboard_models.dart';
import 'package:flutter/material.dart';

class DashboardHeroPanel extends StatelessWidget {
  const DashboardHeroPanel({
    super.key,
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
  final DashboardSummary summary;
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
                    DashboardHintChip(
                      label: '单店离线模式',
                      color: AppPallete.forest,
                    ),
                    DashboardHintChip(label: '主仓营运中', color: AppPallete.copper),
                    DashboardHintChip(
                      label: '首页已切换为店长驾驶舱',
                      color: AppPallete.ink,
                    ),
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
                _DashboardOperatorCard(
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

class DashboardSection extends StatelessWidget {
  const DashboardSection({
    super.key,
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

class DashboardHintChip extends StatelessWidget {
  const DashboardHintChip({
    super.key,
    required this.label,
    required this.color,
  });

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

class DashboardMetricCard extends StatelessWidget {
  const DashboardMetricCard({super.key, required this.metric});

  final DashboardMetric metric;

  @override
  Widget build(BuildContext context) {
    final color = switch (metric.tone) {
      DashboardMetricTone.forest => AppPallete.forest,
      DashboardMetricTone.copper => AppPallete.copper,
      DashboardMetricTone.sky => const Color(0xFF47786D),
      DashboardMetricTone.brick => AppPallete.brick,
      DashboardMetricTone.ink => AppPallete.ink,
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

class DashboardQuickActionTile extends StatefulWidget {
  const DashboardQuickActionTile({super.key, required this.shortcut});

  final DashboardShortcut shortcut;

  @override
  State<DashboardQuickActionTile> createState() =>
      _DashboardQuickActionTileState();
}

class _DashboardQuickActionTileState extends State<DashboardQuickActionTile> {
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

class DashboardModuleGroupCard extends StatelessWidget {
  const DashboardModuleGroupCard({
    super.key,
    required this.group,
    required this.onPrimaryAction,
  });

  final DashboardModuleGroup group;
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
                          DashboardHintChip(label: badge, color: group.accent),
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
          for (var index = 0; index < group.features.length; index++) ...[
            _FeatureLine(label: group.features[index], color: group.accent),
            if (index != group.features.length - 1) const SizedBox(height: 8),
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

class DashboardAlertTile extends StatelessWidget {
  const DashboardAlertTile({super.key, required this.alert});

  final DashboardAlert alert;

  @override
  Widget build(BuildContext context) {
    final color = switch (alert.tone) {
      DashboardAlertTone.normal => AppPallete.forest,
      DashboardAlertTone.warning => AppPallete.copper,
      DashboardAlertTone.critical => AppPallete.brick,
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

class DashboardBackupReadinessCard extends StatelessWidget {
  const DashboardBackupReadinessCard({
    super.key,
    required this.summary,
    required this.onBackupPressed,
  });

  final DashboardSummary summary;
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
              const DashboardHintChip(
                label: '离线经营必须优先保证可恢复',
                color: AppPallete.ink,
              ),
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

class _DashboardOperatorCard extends StatelessWidget {
  const _DashboardOperatorCard({
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
                      formatDashboardRole(currentUser?.role),
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
          _MetaLine(label: '当前时间', value: formatDashboardNow(now)),
          const SizedBox(height: 8),
          const _MetaLine(label: '工作状态', value: '营业中 · 今日建议先查看经营待关注'),
        ],
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
