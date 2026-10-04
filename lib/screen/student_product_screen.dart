import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/student_product/student_product_bloc.dart';
import 'package:pabulum_teacher/model/student_product_model.dart';

import 'package:pabulum_teacher/utils/utils.dart';

class StudentProductsScreen extends StatelessWidget {
  const StudentProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: Utils.customAppBar(
        'Product Requests',
        context,
        isBack: true,
        onBackPress: () => Navigator.of(context).pop(),
      ),
      body: BlocProvider(
        create: (_) => StudentProductsBloc()
          ..add(const StudentProductsEvent.onLoadStudentProducts()),
        child: BlocBuilder<StudentProductsBloc, StudentProductsState>(
          builder: (context, state) {
            final requests = state.arrStudentProducts;

            final requestedCount = requests.where((item) {
              return item.status?.trim().toLowerCase() == 'requested';
            }).length;

            final deliveredCount = requests.where((item) {
              return item.status?.trim().toLowerCase() == 'delivered';
            }).length;

            return Stack(
              children: [
                SafeArea(
                  top: false,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16,
                              12,
                              16,
                              14,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Manage student orders',
                                  style: TextStyle(
                                    color: Color(0xFF7C879B),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                if (state.currentPage > 0) ...[
                                  _buildSummary(
                                    total: requests.length,
                                    requested: requestedCount,
                                    delivered: deliveredCount,
                                  ),

                                  const SizedBox(height: 18),
                                ],

                                const Row(
                                  children: [
                                    Text(
                                      '🧑‍🎓',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Student requests',
                                        style: TextStyle(
                                          color: Color(0xFF182641),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: requests.isEmpty
                                ? state.isLoading
                                ? const SizedBox.shrink()
                                : _buildEmptyState(context, state)
                                : NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification.depth == 0 &&
                                    notification
                                    is ScrollEndNotification &&
                                    notification.metrics.extentAfter <
                                        250) {
                                  _loadNextPage(context);
                                }

                                return false;
                              },
                              child: ListView.builder(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  20,
                                ),
                                itemCount: requests.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == requests.length) {
                                    return _buildPaginationFooter(
                                      context,
                                      state,
                                    );
                                  }

                                  final request = requests[index];

                                  return Padding(
                                    key: ValueKey(
                                      request.id ?? 'request-$index',
                                    ),
                                    padding: const EdgeInsets.only(
                                      bottom: 14,
                                    ),
                                    child: _buildRequestCard(
                                      context,
                                      request,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.isLoading) Utils.loaderBrier(),
                if (state.isLoading) Utils.loaderWid(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _loadNextPage(BuildContext context) {
    final bloc = context.read<StudentProductsBloc>();
    final state = bloc.state;

    if (state.isLoading ||
        state.isLoadingMore ||
        !state.hasMore ||
        state.currentPage == 0) {
      return;
    }

    bloc.add(
      StudentProductsEvent.onLoadStudentProducts(
        page: state.currentPage + 1,
      ),
    );
  }

  Widget _buildSummary({
    required int total,
    required int requested,
    required int delivered,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tiles = [
          _buildSummaryTile(
            emoji: '📦',
            label: 'Total',
            value: total,
            background: const Color(0xFFEEE9FF),
            foreground: const Color(0xFF6542B9),
          ),
          _buildSummaryTile(
            emoji: '📥',
            label: 'Requested',
            value: requested,
            background: const Color(0xFFFFF0E5),
            foreground: const Color(0xFFB86525),
          ),
          _buildSummaryTile(
            emoji: '✅',
            label: 'Delivered',
            value: delivered,
            background: const Color(0xFFE4F5EE),
            foreground: const Color(0xFF168263),
          ),
        ];

        final stackTiles = constraints.maxWidth < 320 ||
            MediaQuery.textScalerOf(context).scale(11) > 15;

        if (stackTiles) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              tiles[0],
              const SizedBox(height: 8),
              tiles[1],
              const SizedBox(height: 8),
              tiles[2],
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: tiles[0]),
            const SizedBox(width: 8),
            Expanded(child: tiles[1]),
            const SizedBox(width: 8),
            Expanded(child: tiles[2]),
          ],
        );
      },
    );
  }

  Widget _buildSummaryTile({
    required String emoji,
    required String label,
    required int value,
    required Color background,
    required Color foreground,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF68778E),
                    fontSize: 10,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$value',
                  style: TextStyle(
                    color: foreground,
                    fontSize: 19,
                    height: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildRequestCard(
      BuildContext context,
      StudentProductData request,
      ) {
    final status = request.status?.trim().toLowerCase() ?? '';

    final accent = status == 'delivered'
        ? const Color(0xFF80CFB1)
        : status == 'requested'
        ? const Color(0xFFFFB47D)
        : const Color(0xFFBBC3D2);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border(
          top: BorderSide(color: accent, width: 3),
          left: BorderSide(color: accent, width: 1),
          right: BorderSide(color: accent, width: 1),
          bottom: BorderSide(color: accent, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // No outer padding or gap around the header.
          _buildStudentHeader(context, request),

          // Padding applies only to the content below the header.
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 16, 10, 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildProductImage(request.product?.image),
                    const SizedBox(width: 11),
                    Expanded(
                      flex: 3,
                      child: Text(
                        _displayText(request.product?.name),
                        softWrap: true,
                        style: const TextStyle(
                          color: Color(0xFF182641),
                          fontSize: 14,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 2,
                      child: Text(
                        _priceText(request.product?.price),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Color(0xFF182641),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Divider(
                    height: 1,
                    color: Color(0xFFEDF0F5),
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _buildDate(
                          label: 'Requested on',
                          value: request.requestedAt,
                        ),
                      ),
                      const VerticalDivider(
                        width: 21,
                        thickness: 1,
                        color: Color(0xFFE2E7F0),
                      ),
                      Expanded(
                        child: _buildDate(
                          label: 'Delivered on',
                          value: request.deliveredAt,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentHeader(
      BuildContext context,
      StudentProductData request,
      ) {
    return Material(
      color: const Color(0xFFF4F2FC),
      elevation: 2,
      borderRadius: BorderRadius.only(topLeft:Radius.circular(16),topRight: Radius.circular(16)),
      shadowColor: const Color(0x307965A8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final student = Row(
              children: [
                _buildStudentAvatar(request.student?.profileImage),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayText(request.student?.name),
                        softWrap: true,
                        style: const TextStyle(
                          color: Color(0xFF182641),
                          fontSize: 14,
                          height: 1.3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Roll No. '
                            '${_displayText(request.student?.rollNumber)}',
                        style: const TextStyle(
                          color: Color(0xFF7A87A0),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );

            final largeText =
                MediaQuery.textScalerOf(context).scale(12) > 16;

            if (constraints.maxWidth < 290 || largeText) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  student,
                  const SizedBox(height: 10),
                  _buildStatusDropdown(context, request),
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: student),
                const SizedBox(width: 8),
                SizedBox(
                  width: 126,
                  child: _buildStatusDropdown(context, request),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
  Widget _buildStatusDropdown(
      BuildContext context,
      StudentProductData request,
      ) {
    final normalized = request.status?.trim().toLowerCase();

    final String? selectedStatus = normalized == 'delivered'
        ? 'Delivered'
        : normalized == 'requested'
        ? 'Requested'
        : null;

    final delivered = selectedStatus == 'Delivered';

    final foreground = selectedStatus == null
        ? const Color(0xFF65728A)
        : delivered
        ? const Color(0xFF138460)
        : const Color(0xFFBF6325);

    final background = selectedStatus == null
        ? const Color(0xFFEEF1F6)
        : delivered
        ? const Color(0xFFE0F3EB)
        : const Color(0xFFFFEBDF);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: foreground.withAlpha(35),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedStatus,
          isExpanded: true,
          itemHeight: 48,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: foreground,
            size: 20,
          ),
          hint: Text(
            _displayText(request.status),
            style: const TextStyle(
              color: Color(0xFF65728A),
              fontSize: 11,
            ),
          ),
          items: [
            DropdownMenuItem<String>(
              value: 'Requested',
              child: _buildStatusOption(
                label: 'Requested',
                color: const Color(0xFFBF6325),
              ),
            ),
            DropdownMenuItem<String>(
              value: 'Delivered',
              child: _buildStatusOption(
                label: 'Delivered',
                color: const Color(0xFF138460),
              ),
            ),
          ],
          onChanged: (value) {
            if (value == null || value == selectedStatus) return;

            context.read<StudentProductsBloc>().add(
              StudentProductsEvent.onUpdateProductStatus(
                requestId: request.id!,
                status: value,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusOption({
    required String label,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _changeStatus(
      BuildContext context, {
        required StudentProductData request,
        required String status,
      }) {
    // Connect the BLoC status-update event here after the update API
    // endpoint, HTTP method and request body are supplied.
    //
    // Keep displaying the server's status until the update succeeds.
    Utils.showToast(
      'Status update API is not connected yet.',
      false,
    );
  }

  Widget _buildStudentAvatar(String? imageUrl) {
    final url = imageUrl?.trim() ?? '';

    const fallback = ColoredBox(
      color: Color(0xFFE5DDF8),
      child: Center(
        child: Icon(
          Icons.person_outline_rounded,
          color: Color(0xFF7961B3),
          size: 25,
        ),
      ),
    );

    return ClipOval(
      child: SizedBox(
        width: 40,
        height: 40,
        child: url.isEmpty
            ? fallback
            : Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => fallback,
        ),
      ),
    );
  }

  Widget _buildProductImage(String? imageUrl) {
    final url = imageUrl?.trim() ?? '';

    const fallback = Center(
      child: Text(
        '📦',
        style: TextStyle(fontSize: 27),
      ),
    );

    return Container(
      width: 54,
      height: 58,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F6),
        borderRadius: BorderRadius.circular(11),
      ),
      child: url.isEmpty
          ? fallback
          : Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => fallback,
      ),
    );
  }

  Widget _buildDate({
    required String label,
    required String? value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🗓️',
          style: TextStyle(fontSize: 19),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF7A87A0),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _displayText(value),
                softWrap: true,
                style: const TextStyle(
                  color: Color(0xFF26364F),
                  fontSize: 12,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaginationFooter(
      BuildContext context,
      StudentProductsState state,
      ) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (!state.hasMore) return const SizedBox.shrink();

    return Center(
      child: TextButton(
        onPressed: () => _loadNextPage(context),
        child: const Text('Load more requests'),
      ),
    );
  }

  Widget _buildEmptyState(
      BuildContext context,
      StudentProductsState state,
      ) {
    final hasLoaded = state.currentPage > 0;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '📦',
              style: TextStyle(fontSize: 42),
            ),
            const SizedBox(height: 14),
            Text(
              hasLoaded
                  ? 'No product requests yet.'
                  : 'Product requests could not be loaded.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF7A87A0),
                fontSize: 14,
                height: 1.4,
              ),
            ),
            if (!hasLoaded) ...[
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () {
                  context.read<StudentProductsBloc>().add(
                    const StudentProductsEvent.onLoadStudentProducts(),
                  );
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _displayText(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? '—' : text;
  }

  String _priceText(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return '—';

    return text.startsWith('₹') ? text : '₹$text';
  }
}