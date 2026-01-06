import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_log.dart';
import '../../../core/utils/theme.dart';
import '../../model/pagination_list_model.dart';

ValueNotifier<bool> paginationRefresh = ValueNotifier(true);

class PaginationListView<T> extends StatefulWidget {
  const PaginationListView({
    super.key,
    required this.loadFirstList,
    required this.loadMoreList,
    required this.itemBuilder,
    required this.loadingWidget,
    required this.emptyWidget,
    required this.emptyText,
    this.scrollController,
    this.refreshFunction,
    this.isList = true,
    this.isHorizontal = false,
    this.horizontalHeight = 200,
  });

  /// Returns the first page (page=1) of data.
  final ValueGetter<Future<PaginationListModel>> loadFirstList;

  /// Loads a given page (2,3,...) when needed.
  final Future<PaginationListModel> Function(int page) loadMoreList;

  final Widget Function(BuildContext, T) itemBuilder;
  final Widget loadingWidget;
  final Widget emptyWidget;
  final String emptyText;

  /// If true -> ListView, else GridView
  final bool isList;

  /// Optional external ScrollController (page-level scroll).
  final ScrollController? scrollController;

  /// Horizontal mode (use with care)
  final bool isHorizontal;

  /// Height to constrain when horizontal
  final double horizontalHeight;

  /// Optional callback when refreshing
  final Function? refreshFunction;

  @override
  State<PaginationListView<T>> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T> extends State<PaginationListView<T>> {
  List<T> list = [];
  int totalNumberOfResult = 0;
  int page = 1;

  bool isFirstLoadRunning = true;
  bool isLoadMoreRunning = false;

  static const double _preloadExtent = 200.0;

  bool _hasScrollAppeared = false;

  late final ScrollController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();

    _ownsController = widget.scrollController == null;
    _controller = widget.scrollController ?? ScrollController();

    if (_ownsController) {
      // Internal list/grid scrolling
      _controller.addListener(_loadMoreListener);
    } else {
      // External page-level scrolling
      _controller.addListener(_onExternalScroll);
    }

    _loadFirst();
    paginationRefresh.addListener(onRefresh);
  }

  @override
  void dispose() {
    paginationRefresh.removeListener(onRefresh);

    if (_ownsController) {
      _controller.removeListener(_loadMoreListener);
      _controller.dispose();
    } else {
      _controller.removeListener(_onExternalScroll);
      // do NOT dispose external controller
    }
    super.dispose();
  }

  Future<void> _loadFirst() async {
    try {
      final value = await widget.loadFirstList.call();

      final incoming = (value.listOfObjects ?? []) as List<T>;
      list = incoming;

      // Trust backend total; if missing/0, pagination is effectively off.
      totalNumberOfResult = (value.totalNumberOfResult > 0) ? value.totalNumberOfResult : 0;

      appLog('First load -> items: ${list.length}, total: $totalNumberOfResult');
    } catch (e) {
      appLog('First load error: $e');
    } finally {
      isFirstLoadRunning = false;
      isLoadMoreRunning = false;
      if (mounted) setState(() {});
      _maybeAutoloadToFillOnce();
    }
  }

  Future<void> onRefresh() async {
    list = [];
    page = 1;
    _hasScrollAppeared = false; // reset so first build can auto-fill again if needed
    isFirstLoadRunning = true;
    isLoadMoreRunning = false;
    if (mounted) setState(() {});
    widget.refreshFunction?.call();
    await _loadFirst();
  }

  bool get _canLoadMoreByTotal => (totalNumberOfResult > 0) && (list.length < totalNumberOfResult);

  void _loadMoreListener() {
    if (!_controller.hasClients) return;
    if (isFirstLoadRunning || isLoadMoreRunning || !_canLoadMoreByTotal) return;

    final pos = _controller.position;
    final bool nearEnd = (pos.maxScrollExtent - pos.pixels) <= _preloadExtent;

    if (nearEnd) _internalLoadMore();
  }

  void _onExternalScroll() {
    if (!mounted || isFirstLoadRunning || isLoadMoreRunning || !_canLoadMoreByTotal) return;
    if (!_controller.hasClients) return;

    final pos = _controller.position;
    final bool nearEnd = (pos.maxScrollExtent - pos.pixels) <= _preloadExtent;

    if (nearEnd) _internalLoadMore();
  }

  Future<void> _internalLoadMore() async {
    if (isFirstLoadRunning || isLoadMoreRunning || !_canLoadMoreByTotal) return;

    isLoadMoreRunning = true;
    page++;
    if (mounted) setState(() {});

    try {
      final value = await widget.loadMoreList(page);
      final loadedList = (value.listOfObjects ?? []) as List<T>;

      if (value.totalNumberOfResult > 0) {
        totalNumberOfResult = value.totalNumberOfResult;
      }

      if (loadedList.isNotEmpty) {
        list.addAll(loadedList);
      }

      appLog(
        'Load more -> page: $page, added: ${loadedList.length}, '
        'total: $totalNumberOfResult, len: ${list.length}',
      );
    } catch (e) {
      appLog('Load more error: $e');
    } finally {
      isLoadMoreRunning = false;
      if (mounted) setState(() {});
      _maybeAutoloadToFillOnce(); // will run only if no scroll has appeared yet
    }
  }

  void _maybeAutoloadToFillOnce() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_controller.hasClients) return;

      final pos = _controller.position;

      if (_hasScrollAppeared || pos.maxScrollExtent > 0) {
        _hasScrollAppeared = true;
        return;
      }

      if (_canLoadMoreByTotal && !isFirstLoadRunning && !isLoadMoreRunning) {
        appLog('Auto-fill (no scroll yet): max=${pos.maxScrollExtent}');
        _internalLoadMore(); // chain again until scroll appears or no more data
      }
    });
  }

  Widget _buildEmpty() {
    return SizedBox(
      height: Get.height,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            widget.emptyWidget,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.emptyText.tr,
                    style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    final axis = widget.isHorizontal ? Axis.horizontal : Axis.vertical;

    if (isFirstLoadRunning && page == 1) {
      return ListView.builder(
        scrollDirection: axis,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => widget.loadingWidget,
      );
    }

    return ListView.builder(
      scrollDirection: axis,
      addRepaintBoundaries: false,
      padding: EdgeInsets.zero,
      physics: _ownsController ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
      controller: _ownsController ? _controller : null,
      shrinkWrap: true,
      itemCount: list.length + (isLoadMoreRunning ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= list.length) return widget.loadingWidget;
        return widget.itemBuilder(context, list[index]);
      },
    );
  }

  Widget _buildGrid() {
    final axis = widget.isHorizontal ? Axis.horizontal : Axis.vertical;

    if (isFirstLoadRunning && page == 1) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        scrollDirection: axis,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (context, index) => widget.loadingWidget,
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: list.length == 1 ? 1 : 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: list.length == 1 ? 1.5 : 0.5,
      ),
      scrollDirection: axis,
      padding: EdgeInsets.zero,
      physics: _ownsController ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
      controller: _ownsController ? _controller : null,
      shrinkWrap: true,
      itemCount: list.length + (isLoadMoreRunning ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= list.length) return widget.loadingWidget;
        return widget.itemBuilder(context, list[index]);
      },
    );
  }

  Widget _wrapWithExternalScrollListener(Widget child) => child;

  Widget _buildContent() {
    if (!isFirstLoadRunning && list.isEmpty) {
      return _buildEmpty();
    }
    final core = widget.isList ? _buildList() : _buildGrid();
    return _wrapWithExternalScrollListener(core);
  }

  @override
  Widget build(BuildContext context) {
    Widget body = _buildContent();

    if (widget.isHorizontal) {
      body = SizedBox(height: widget.horizontalHeight, child: body);
    }
    final withRefresh = widget.isHorizontal ? body : RefreshIndicator(color: AppTheme.primaryColor, onRefresh: onRefresh, child: body);

    return ValueListenableBuilder(
      valueListenable: paginationRefresh,
      builder: (context, value, _) {
        appLog(
          'Build: axis=${widget.isHorizontal ? "H" : "V"} '
          'first=$isFirstLoadRunning total=$totalNumberOfResult '
          'len=${list.length} canLoadMore=${_canLoadMoreByTotal} '
          'owns=${_ownsController}',
        );
        return withRefresh;
      },
    );
  }
}
