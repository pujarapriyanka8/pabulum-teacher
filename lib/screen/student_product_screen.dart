
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/student_product/student_product_bloc.dart';
import 'package:pabulum_teacher/model/student_product_model.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class StudentProductsScreen extends StatelessWidget {
  const StudentProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (_) => StudentProductsBloc()
          ..add(
            const StudentProductsEvent.onLoadStudentProducts(),
          ),
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
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    AppImages.icBackgroundAll,
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: CustomAppBar(
                              title: 'Product Requests',
                              subtitle:
                              'Manage student orders for books,\nuniforms and other essentials.',
                              image: AppImages.icStudentProductHeader,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16,
                              0,
                              16,
                              14,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (state.currentPage > 0) ...[
                                  _buildSummary(
                                    total: requests.length,
                                    requested: requestedCount,
                                    delivered: deliveredCount,
                                  ),
                                  const SizedBox(height: 18),
                                ],
                                Row(
                                  children: [
                                    const Text(
                                      '🧑‍🎓',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Student requests',
                                        style: TextStyle(
                                          color: AppColors.ink,
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
                                    notification is ScrollEndNotification &&
                                    notification.metrics.extentAfter < 250) {
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
                                      bottom: 12,
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
            background: Utils.getCardBackgroundColor(0),
            foreground: Utils.getCardBorderColor(0),
          ),
          _buildSummaryTile(
            emoji: '📥',
            label: 'Requested',
            value: requested,
            background: Utils.getCardBackgroundColor(4),
            foreground: Utils.getCardBorderColor(4),
          ),
          _buildSummaryTile(
            emoji: '✅',
            label: 'Delivered',
            value: delivered,
            background: Utils.getCardBackgroundColor(1),
            foreground: Utils.getCardBorderColor(1),
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
                  style: TextStyle(
                    color: AppColors.muted,
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
        ? Utils.getCardBorderColor(1)
        : status == 'requested'
        ? Utils.getCardBorderColor(4)
        : Utils.getCardBorderColor(2);

    return Container(
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(19),
      ),
      padding: const EdgeInsets.fromLTRB(
        1.2,
        3.5,
        1.2,
        1.2,
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStudentHeader(
              context,
              request,
              accent,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                12,
                12,
                13,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildProductImage(
                        request.product?.image,
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: Text(
                          _displayText(request.product?.name),
                          softWrap: true,
                          style: TextStyle(
                            color: AppColors.ink,
                            fontSize: 14,
                            height: 1.4,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Flexible(
                        child: Text(
                          _priceText(request.product?.price),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColors.ink,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(
                    height: 1,
                    color: AppColors.colorGrey1,
                  ),
                  const SizedBox(height: 12),
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
                        VerticalDivider(
                          width: 21,
                          thickness: 1,
                          color: AppColors.colorGrey1,
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
      ),
    );
  }

  Widget _buildStudentHeader(
      BuildContext context,
      StudentProductData request,
      Color accent,
      ) {
    return Container(
      padding: const EdgeInsets.all(11),
      color: accent.withValues(alpha: 0.06),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final student = Row(
            children: [
              _buildStudentAvatar(
                request.student?.profileImage,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _displayText(request.student?.name),
                      softWrap: true,
                      style: TextStyle(
                        color: AppColors.ink,
                        fontSize: 14,
                        height: 1.3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.purple.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        'Roll No. ${_displayText(request.student?.rollNumber)}',
                        style: TextStyle(
                          color: AppColors.purple,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                student,
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 136,
                    child: _buildStatusDropdown(context, request),
                  ),
                ),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: student),
              const SizedBox(width: 8),
              SizedBox(
                width: 133,
                child: _buildStatusDropdown(context, request),
              ),
            ],
          );
        },
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
        ? AppColors.muted
        : delivered
        ? Utils.getCardBorderColor(1)
        : Utils.getCardBorderColor(4);

    final background = selectedStatus == null
        ? AppColors.surface
        : delivered
        ? Utils.getCardBackgroundColor(1)
        : Utils.getCardBackgroundColor(4);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: foreground.withValues(alpha: 0.25),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedStatus,
          isExpanded: true,
          itemHeight: 48,
          dropdownColor: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: foreground,
            size: 20,
          ),
          hint: Text(
            _displayText(request.status),
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 11,
            ),
          ),
          items: [
            DropdownMenuItem<String>(
              value: 'Requested',
              child: _buildStatusOption(
                label: 'Requested',
                color: Utils.getCardBorderColor(4),
              ),
            ),
            DropdownMenuItem<String>(
              value: 'Delivered',
              child: _buildStatusOption(
                label: 'Delivered',
                color: Utils.getCardBorderColor(1),
              ),
            ),
          ],
          onChanged: (value) {
            if (value == null || value == selectedStatus) {
              return;
            }

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

  Widget _buildStudentAvatar(String? imageUrl) {
    final url = imageUrl?.trim() ?? '';

    final fallback = ColoredBox(
      color: AppColors.purple.withValues(alpha: 0.10),
      child: Center(
        child: Icon(
          Icons.person_outline_rounded,
          color: AppColors.purple,
          size: 25,
        ),
      ),
    );

    return Container(
      width: 52,
      height: 52,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.30),
        ),
      ),
      child: url.isEmpty
          ? fallback
          : Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
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
      width: 62,
      height: 62,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: AppColors.colorGrey1,
        ),
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
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _displayText(value),
                softWrap: true,
                style: TextStyle(
                  color: AppColors.ink,
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
      return Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: AppColors.purple,
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }

    if (!state.hasMore) {
      return const SizedBox.shrink();
    }

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
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            if (!hasLoaded) ...[
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () {
                  context.read<StudentProductsBloc>().add(
                    const StudentProductsEvent
                        .onLoadStudentProducts(),
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
