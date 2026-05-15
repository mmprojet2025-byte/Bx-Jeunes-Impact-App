// ═══════════════════════════════════════════════════════════
//  WIDGETS DISPONIBLES
// ═══════════════════════════════════════════════════════════
//
//  ResponsiveBuilder    → choix entre phone et tablet widget
//  ResponsiveLayout     → layout complet avec padding adaptatif
//  ResponsiveGrid       → GridView 1→2 colonnes
//  MasterDetailLayout  → liste + détail côte à côte sur tablette
//
// ─────────────────────────────────────────────────────────
//  EXEMPLES D'USAGE
// ─────────────────────────────────────────────────────────
//
//  // Choisir un layout
//  ResponsiveBuilder(
//    phone:  (ctx, bp) => const PhoneListView(),
//    tablet: (ctx, bp) => const TabletGridView(),
//  )
//
//  // Grille adaptative (1 col → 2 col)
//  ResponsiveGrid(
//    itemCount: items.length,
//    itemBuilder: (ctx, i) => ItemCard(items[i]),
//  )
//
//  // Master/detail sur tablette
//  MasterDetailLayout(
//    masterBuilder: (ctx, bp) => ActivityList(onTap: (id) => ...),
//    detailBuilder: (ctx, bp, selectedId) =>
//        selectedId != null ? ActivityDetail(id: selectedId) : const _Placeholder(),
//  )
 
import 'package:flutter/material.dart';
import '../../core/constants/breakpoints.dart';
 
// ─────────────────────────────────────────────────────────────
//  1. ResponsiveBuilder — layout switch phone/tablet
// ─────────────────────────────────────────────────────────────
 
/// Choisit entre [phone] et [tablet] selon la largeur de l'écran.
/// Si [tablet] est null, [phone] est utilisé sur tous les formats.
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BreakpointData bp) phone;
  final Widget Function(BuildContext context, BreakpointData bp)? tablet;
 
  const ResponsiveBuilder({
    super.key,
    required this.phone,
    this.tablet,
  });
 
  @override
  Widget build(BuildContext context) {
    final bp = Breakpoints.of(context);
    if (bp.isTablet && tablet != null) {
      return tablet!(context, bp);
    }
    return phone(context, bp);
  }
}
 
// ─────────────────────────────────────────────────────────────
//  2. ResponsiveLayout — wrapper avec padding adaptatif
// ─────────────────────────────────────────────────────────────
 
/// Applique automatiquement le padding horizontal adapté
/// (`phonePadding` ou `tabletPadding`) au [child].
///
/// Usage :
///   ResponsiveLayout(child: MyContent())
class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsets? extraPadding;
 
  const ResponsiveLayout({
    super.key,
    required this.child,
    this.extraPadding,
  });
 
  @override
  Widget build(BuildContext context) {
    final bp = Breakpoints.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: bp.horizontalPadding,
      ).add(extraPadding ?? EdgeInsets.zero),
      child: child,
    );
  }
}
 
// ─────────────────────────────────────────────────────────────
//  3. ResponsiveGrid — liste → grille selon le format
// ─────────────────────────────────────────────────────────────
 
/// Liste verticale sur téléphone, grille 2 colonnes sur tablette.
///
/// Usage :
///   ResponsiveGrid(
///     itemCount: activities.length,
///     itemBuilder: (ctx, i) => ActivityCard(activities[i]),
///     padding: const EdgeInsets.all(16),
///   )
class ResponsiveGrid extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final EdgeInsets padding;
  final Widget? header;      // widget épinglé au-dessus de la liste
  final Widget? emptyState;  // affiché si itemCount == 0
 
  const ResponsiveGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.header,
    this.emptyState,
  });
 
  @override
  Widget build(BuildContext context) {
    final bp = Breakpoints.of(context);
 
    if (itemCount == 0 && emptyState != null) {
      return Column(children: [
        if (header != null) header!,
        Expanded(child: emptyState!),
      ]);
    }
 
    if (bp.isPhone) {
      return CustomScrollView(
        slivers: [
          if (header != null) SliverToBoxAdapter(child: header),
          SliverPadding(
            padding: padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => Padding(
                  padding: EdgeInsets.only(bottom: bp.cardGap),
                  child: itemBuilder(ctx, i),
                ),
                childCount: itemCount,
              ),
            ),
          ),
        ],
      );
    }
 
    // Tablette → 2 colonnes
    return CustomScrollView(
      slivers: [
        if (header != null) SliverToBoxAdapter(child: header),
        SliverPadding(
          padding: padding,
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:   bp.columns,
              crossAxisSpacing: bp.cardGap,
              mainAxisSpacing:  bp.cardGap,
              childAspectRatio: bp.cardAspectRatio,
            ),
            delegate: SliverChildBuilderDelegate(
              itemBuilder,
              childCount: itemCount,
            ),
          ),
        ),
      ],
    );
  }
}
 
// ─────────────────────────────────────────────────────────────
//  4. MasterDetailLayout — liste + détail côte à côte (tablette)
// ─────────────────────────────────────────────────────────────
 
/// Sur téléphone : affiche uniquement [masterBuilder].
///   La navigation vers le détail se fait via GoRouter (push).
///
/// Sur tablette : affiche liste à gauche (40% de largeur) et
///   panneau de détail à droite (60%). La sélection dans la liste
///   met à jour le détail en place sans navigation.
///
/// Usage dans ActivityListScreen :
///
///   MasterDetailLayout<int>(
///     masterBuilder: (ctx, bp, onSelect) => ActivityList(
///       onTap: (activity) => onSelect(activity.id),
///     ),
///     detailBuilder: (ctx, bp, selectedId) => selectedId != null
///         ? ActivityDetailPanel(activityId: selectedId)
///         : const _NoSelectionPlaceholder(),
///     onPhoneTap: (id) => context.goNamed(
///         RouteNames.activityDetail, pathParameters: {'id': '$id'}),
///   )
 
class MasterDetailLayout<T> extends StatefulWidget {
  /// Builder de la liste/master (panneau gauche sur tablette)
  final Widget Function(
      BuildContext context,
      BreakpointData bp,
      void Function(T item) onSelect,
  ) masterBuilder;
 
  /// Builder du panneau détail (panneau droit sur tablette)
  final Widget Function(
      BuildContext context,
      BreakpointData bp,
      T? selectedItem,
  ) detailBuilder;
 
  /// Sur téléphone, au lieu d'afficher le panneau détail,
  /// appelle cette callback pour naviguer via GoRouter.
  final void Function(T item)? onPhoneTap;
 
  /// Largeur relative du panneau liste (0.0 – 1.0).
  /// Défaut : 0.40 (40% liste, 60% détail)
  final double masterFlex;
 
  const MasterDetailLayout({
    super.key,
    required this.masterBuilder,
    required this.detailBuilder,
    this.onPhoneTap,
    this.masterFlex = 0.40,
  });
 
  @override
  State<MasterDetailLayout<T>> createState() =>
      _MasterDetailLayoutState<T>();
}
 
class _MasterDetailLayoutState<T>
    extends State<MasterDetailLayout<T>> {
  T? _selectedItem;
 
  void _onSelect(T item) {
    final bp = Breakpoints.of(context);
    if (bp.isPhone) {
      // Téléphone → navigation GoRouter
      widget.onPhoneTap?.call(item);
    } else {
      // Tablette → mise à jour inline du panneau détail
      setState(() => _selectedItem = item);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    final bp = Breakpoints.of(context);
 
    if (bp.isPhone) {
      return widget.masterBuilder(context, bp, _onSelect);
    }
 
    // Tablette → layout horizontal master + detail
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Panneau gauche : liste ─────────────────────
        SizedBox(
          width: MediaQuery.of(context).size.width * widget.masterFlex,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Color(0xFFE8E8E8), // AppColors.border
                  width: 1,
                ),
              ),
            ),
            child: widget.masterBuilder(context, bp, _onSelect),
          ),
        ),
 
        // ── Panneau droit : détail ─────────────────────
        Expanded(
          child: widget.detailBuilder(context, bp, _selectedItem),
        ),
      ],
    );
  }
}
 
// ─────────────────────────────────────────────────────────────
//  5. NoSelectionPlaceholder — détail vide sur tablette
// ─────────────────────────────────────────────────────────────
 
/// Affiché dans le panneau détail quand aucun élément n'est sélectionné.
class NoSelectionPlaceholder extends StatelessWidget {
  final String message;
  final IconData icon;
 
  const NoSelectionPlaceholder({
    super.key,
    this.message = 'Sélectionnez un élément pour voir le détail',
    this.icon    = Icons.touch_app_outlined,
  });
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: const Color(0xFFBBBBBB)),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }
}
