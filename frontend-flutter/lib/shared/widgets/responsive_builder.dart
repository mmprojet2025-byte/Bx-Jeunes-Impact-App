import 'package:flutter/widgets.dart';

import '../../core/constants/breakpoints.dart';

/// Responsive size classes supported by the app.
enum ResponsiveDeviceType { phone, tablet }

/// Layout information derived from the current constraints.
class ResponsiveLayoutInfo {
  const ResponsiveLayoutInfo({
    required this.constraints,
    required this.deviceType,
  });

  final BoxConstraints constraints;
  final ResponsiveDeviceType deviceType;

  double get width => constraints.maxWidth;
  bool get isPhone => deviceType == ResponsiveDeviceType.phone;
  bool get isTablet => deviceType == ResponsiveDeviceType.tablet;

  /// Lists may switch from one vertical column to a two-column grid on tablet.
  int get listColumnCount => isTablet ? 2 : 1;
}

typedef ResponsiveWidgetBuilder = Widget Function(
  BuildContext context,
  ResponsiveLayoutInfo layout,
);

/// Wraps [LayoutBuilder] and exposes the app's phone/tablet breakpoints.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  final ResponsiveWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final deviceType = width >= Breakpoints.tablet
            ? ResponsiveDeviceType.tablet
            : ResponsiveDeviceType.phone;

        return builder(
          context,
          ResponsiveLayoutInfo(
            constraints: constraints,
            deviceType: deviceType,
          ),
        );
      },
    );
  }
}

/// Convenience widget for choosing between phone and tablet layouts.
class PhoneTabletLayout extends StatelessWidget {
  const PhoneTabletLayout({
    super.key,
    required this.phone,
    required this.tablet,
  });

  final WidgetBuilder phone;
  final WidgetBuilder tablet;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, layout) => layout.isTablet
          ? tablet(context)
          : phone(context),
    );
  }
}

/// A sliver list on phone and a two-column sliver grid on tablet.
class ResponsiveSliverListGrid extends StatelessWidget {
  const ResponsiveSliverListGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.phoneSpacing = 12,
    this.tabletSpacing = 16,
    this.tabletChildAspectRatio = 1.35,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double phoneSpacing;
  final double tabletSpacing;
  final double tabletChildAspectRatio;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, layout) {
        if (layout.isTablet) {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: layout.listColumnCount,
              mainAxisSpacing: tabletSpacing,
              crossAxisSpacing: tabletSpacing,
              childAspectRatio: tabletChildAspectRatio,
            ),
            delegate: SliverChildBuilderDelegate(
              itemBuilder,
              childCount: itemCount,
            ),
          );
        }

        return SliverList.separated(
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          separatorBuilder: (_, __) => SizedBox(height: phoneSpacing),
        );
      },
    );
  }
}

/// Master/detail layout for tablet, with a stacked detail layout on phone.
class ResponsiveMasterDetail extends StatelessWidget {
  const ResponsiveMasterDetail({
    super.key,
    required this.master,
    required this.detail,
    this.masterFlex = 4,
    this.detailFlex = 6,
    this.spacing = 16,
  });

  final Widget master;
  final Widget detail;
  final int masterFlex;
  final int detailFlex;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, layout) {
        if (layout.isTablet) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: masterFlex, child: master),
              SizedBox(width: spacing),
              Expanded(flex: detailFlex, child: detail),
            ],
          );
        }

        return detail;
      },
    );
  }
}
