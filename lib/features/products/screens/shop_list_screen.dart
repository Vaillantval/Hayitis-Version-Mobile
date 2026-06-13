// lib/features/products/screens/shop_list_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/cache/cache_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/product_card.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/error_state.dart';
import '../../../shared/utils/debouncer.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class ShopListScreen extends ConsumerStatefulWidget {
  final String? initialQuery;
  final String? initialCategory;

  const ShopListScreen({super.key, this.initialQuery, this.initialCategory});

  @override
  ConsumerState<ShopListScreen> createState() => _ShopListScreenState();
}

class _ShopListScreenState extends ConsumerState<ShopListScreen> {
  final _pagingController = PagingController<int, Product>(firstPageKey: 1);
  final _searchCtrl = TextEditingController();
  final _debouncer  = Debouncer();

  String? _query;
  String? _category;
  double? _minPrice;
  double? _maxPrice;
  bool? _inStock;
  String? _ordering;

  @override
  void initState() {
    super.initState();
    _query    = widget.initialQuery;
    _category = widget.initialCategory;
    if (_query != null) _searchCtrl.text = _query!;
    _pagingController.addPageRequestListener(_fetchPage);
  }

  bool get _isDefaultFirstPage =>
      _query == null && _category == null &&
      _minPrice == null && _maxPrice == null &&
      _inStock == null && _ordering == null;

  static const _cacheKey = 'cache_shop_page1';

  Future<void> _fetchPage(int pageKey) async {
    try {
      final repo = ref.read(productRepositoryProvider);
      final result = await repo.getProducts(
        search:   _query,
        category: _category,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        inStock:  _inStock,
        ordering: _ordering,
        page:     pageKey,
      );
      // Save first page (no filters) to cache
      if (pageKey == 1 && _isDefaultFirstPage) {
        await CacheService.save(
          _cacheKey,
          jsonEncode(result.results.map((p) => p.toJson()).toList()),
        );
      }
      if (result.next == null) {
        _pagingController.appendLastPage(result.results);
      } else {
        _pagingController.appendPage(result.results, pageKey + 1);
      }
    } catch (e) {
      // Fallback to cache only for first page with no filters
      if (pageKey == 1 && _isDefaultFirstPage) {
        final cached = await CacheService.load(_cacheKey);
        if (cached != null) {
          final products = (jsonDecode(cached) as List)
              .map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList();
          _pagingController.appendLastPage(products);
          return;
        }
      }
      _pagingController.error = e;
    }
  }

  void _resetAndRefresh() {
    _pagingController.refresh();
  }

  void _onSearchChanged(String value) {
    _debouncer.call(() {
      setState(() => _query = value.isEmpty ? null : value);
      _resetAndRefresh();
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchCtrl.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Boutique'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchCtrl,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: PagedGridView<int, Product>(
              pagingController: _pagingController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              builderDelegate: PagedChildBuilderDelegate<Product>(
                itemBuilder: (_, product, __) => ProductCard(product: product),
                firstPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                newPageProgressIndicatorBuilder: (_) => const Center(
                  child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()),
                ),
                noItemsFoundIndicatorBuilder: (_) => const EmptyState(
                  icon: Icons.search_off,
                  title: 'Aucun produit trouvé',
                  subtitle: 'Essayez de modifier vos filtres ou votre recherche',
                ),
                firstPageErrorIndicatorBuilder: (_) => ErrorState(
                  message: 'Impossible de charger les produits',
                  onRetry: _resetAndRefresh,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _FilterSheet(
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        inStock:  _inStock,
        ordering: _ordering,
        onApply: (min, max, inStock, ordering) {
          setState(() {
            _minPrice = min;
            _maxPrice = max;
            _inStock  = inStock;
            _ordering = ordering;
          });
          _resetAndRefresh();
        },
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  final double? minPrice;
  final double? maxPrice;
  final bool? inStock;
  final String? ordering;
  final void Function(double?, double?, bool?, String?) onApply;

  const _FilterSheet({
    this.minPrice, this.maxPrice, this.inStock, this.ordering,
    required this.onApply,
  });

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late RangeValues _priceRange;
  bool? _inStock;
  String? _ordering;

  @override
  void initState() {
    super.initState();
    _priceRange = RangeValues(widget.minPrice ?? 0, widget.maxPrice ?? 10000);
    _inStock    = widget.inStock;
    _ordering   = widget.ordering;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filtres', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          const Text('Fourchette de prix (G)', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 10000,
            divisions: 100,
            activeColor: AppColors.primary,
            labels: RangeLabels('${_priceRange.start.round()} G', '${_priceRange.end.round()} G'),
            onChanged: (v) => setState(() => _priceRange = v),
          ),
          CheckboxListTile(
            value: _inStock ?? false,
            onChanged: (v) => setState(() => _inStock = v! ? true : null),
            title: const Text('En stock uniquement', style: TextStyle(fontFamily: 'Poppins')),
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
          ),
          const Text('Tri', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          DropdownButton<String?>(
            value: _ordering,
            isExpanded: true,
            hint: const Text('Par défaut'),
            items: const [
              DropdownMenuItem(value: null,            child: Text('Par défaut')),
              DropdownMenuItem(value: 'solde_price',   child: Text('Prix croissant')),
              DropdownMenuItem(value: '-solde_price',  child: Text('Prix décroissant')),
              DropdownMenuItem(value: 'created_at',    child: Text('Plus anciens')),
              DropdownMenuItem(value: '-created_at',   child: Text('Plus récents')),
            ],
            onChanged: (v) => setState(() => _ordering = v),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onApply(
                _priceRange.start > 0 ? _priceRange.start : null,
                _priceRange.end < 10000 ? _priceRange.end : null,
                _inStock,
                _ordering,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Appliquer', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
