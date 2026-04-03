import 'dart:math' as math;

import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/dashboard/presentation/models/dashboard_models.dart';
import 'package:flutter/material.dart';

class DashboardInsightPanel extends StatelessWidget {
  const DashboardInsightPanel({
    super.key,
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

class DashboardTrendChartCard extends StatelessWidget {
  const DashboardTrendChartCard({
    super.key,
    required this.points,
    required this.footerLabel,
  });

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

class DashboardCategoryShareCard extends StatelessWidget {
  const DashboardCategoryShareCard({super.key, required this.segments});

  final List<DashboardCategorySegment> segments;

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

class DashboardRankingList extends StatelessWidget {
  const DashboardRankingList({super.key, required this.items});

  final List<DashboardRankingItem> items;

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
  final DashboardRankingItem item;

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

  final List<DashboardCategorySegment> segments;

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
