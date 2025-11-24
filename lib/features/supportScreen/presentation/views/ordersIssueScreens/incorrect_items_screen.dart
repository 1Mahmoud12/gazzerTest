import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_item_entity.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_detail_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_detail_state.dart';
import 'package:gazzer/features/supportScreen/data/requests/complaint_request.dart';
import 'package:gazzer/features/supportScreen/domain/entities/enums_support.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/complaint_cubit.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/complaint_states.dart';
import 'package:image_picker/image_picker.dart';

import '../order_issue_response_screen.dart';

part '../component/incorrect_item_card.dart';

class ItemComplaintData {
  final int itemId;
  File? photo;
  final TextEditingController noteController;

  ItemComplaintData({
    required this.itemId,
    this.photo,
  }) : noteController = TextEditingController();

  String? get note {
    final text = noteController.text.trim();
    return text.isEmpty ? null : text;
  }

  void dispose() {
    noteController.dispose();
  }
}

class IncorrectItemsScreen extends StatefulWidget {
  const IncorrectItemsScreen({
    super.key,
    required this.orderId,
    this.faqCategoryId,
  });

  final int orderId;
  final int? faqCategoryId;

  static const route = '/incorrect-items';

  @override
  State<IncorrectItemsScreen> createState() => _IncorrectItemsScreenState();
}

class _IncorrectItemsScreenState extends State<IncorrectItemsScreen> {
  final Set<int> _selectedItemIds = {};
  final Map<int, ItemComplaintData> _itemComplaintData = {};
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    // Dispose all note controllers
    for (final itemData in _itemComplaintData.values) {
      itemData.dispose();
    }
    _itemComplaintData.clear();
    super.dispose();
  }

  void _toggleItemSelection(int itemId) {
    setState(() {
      if (_selectedItemIds.contains(itemId)) {
        _selectedItemIds.remove(itemId);
        _itemComplaintData[itemId]?.dispose();
        _itemComplaintData.remove(itemId);
      } else {
        _selectedItemIds.add(itemId);
        _itemComplaintData[itemId] = ItemComplaintData(itemId: itemId);
      }
    });
  }

  Future<void> _pickImageForItem(int itemId) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _itemComplaintData[itemId]?.photo = File(image.path);
        });
      }
    } catch (e) {
      Alerts.showToast(L10n.tr().errorTakingPhoto);
    }
  }

  void _removePhotoForItem(int itemId) {
    setState(() {
      _itemComplaintData[itemId]?.photo = null;
    });
  }

  void _onCheckPressed(
    BuildContext context,
    List<OrderDetailItemEntity> allItems,
  ) {
    if (_selectedItemIds.isEmpty) {
      Alerts.showToast(L10n.tr().youMustCheckOneAtLeast);
      return;
    }

    // Submit complaint with all selected items
    final selectedItemIds = _selectedItemIds.toList();

    // Get all photos from selected items
    final attachments = selectedItemIds.map((id) => _itemComplaintData[id]?.photo).whereType<File>().toList();

    // Combine notes from all selected items
    final notesList = selectedItemIds.map((id) => _itemComplaintData[id]?.note).whereType<String>().where((note) => note.isNotEmpty).toList();
    final combinedNote = notesList.isNotEmpty ? notesList.join('\n\n') : null;

    final request = ComplaintRequest(
      orderId: widget.orderId,
      orderItemIds: selectedItemIds,
      note: combinedNote,
      type: ComplaintType.damagedItems,
      attachments: attachments.isNotEmpty ? attachments : null,
    );

    context.read<ComplaintCubit>().submitComplaint(request);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderDetailCubit(di.get(), widget.orderId)..loadOrderDetail(),
        ),
        BlocProvider(
          create: (context) => ComplaintCubit(di.get()),
        ),
      ],
      child: BlocConsumer<ComplaintCubit, ComplaintStates>(
        listener: (context, complaintState) {
          if (complaintState is ComplaintSuccessState) {
            // Navigate to response screen after successful submission
            context.navigateToPage(
              OrderIssueResponseScreen(
                orderId: widget.orderId,
                faqCategoryId: widget.faqCategoryId,
              ),
            );
          }
        },
        builder: (context, complaintState) {
          return BlocBuilder<OrderDetailCubit, OrderDetailState>(
            builder: (context, state) {
              if (state is OrderDetailLoading && state.orderDetail == null) {
                return Scaffold(
                  appBar: MainAppBar(
                    title: l10n.missingOrIncorrectItems,
                  ),
                  body: const Center(
                    child: LoadingWidget(),
                  ),
                );
              }

              if (state is OrderDetailError) {
                return Scaffold(
                  appBar: MainAppBar(
                    title: l10n.missingOrIncorrectItems,
                  ),
                  body: FailureComponent(
                    message: state.message,
                    onRetry: () {
                      context.read<OrderDetailCubit>().loadOrderDetail();
                    },
                  ),
                );
              }

              final orderDetail = state is OrderDetailLoaded
                  ? state.orderDetail
                  : state is OrderDetailLoading
                  ? state.orderDetail
                  : null;

              if (orderDetail == null) {
                return Scaffold(
                  appBar: MainAppBar(
                    title: l10n.missingOrIncorrectItems,
                  ),
                  body: const Center(
                    child: LoadingWidget(),
                  ),
                );
              }

              // Collect all items from all vendors
              final allItems = orderDetail.vendors.expand((vendor) => vendor.items).toList();

              return Scaffold(
                appBar: MainAppBar(
                  title: l10n.missingOrIncorrectItems,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              l10n.selectMissingIncorrectItems,
                              style: TStyle.robotBlackMedium(),
                            ),
                            const VerticalSpacing(16),
                            ...allItems.map((item) {
                              final isSelected = _selectedItemIds.contains(
                                item.id,
                              );
                              final itemData = _itemComplaintData[item.id];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _IncorrectItemCard(
                                  item: item,
                                  isSelected: isSelected,
                                  itemData: itemData,
                                  onTap: () => _toggleItemSelection(item.id),
                                  onPickPhoto: () => _pickImageForItem(item.id),
                                  onRemovePhoto: () => _removePhotoForItem(item.id),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: MainBtn(
                          onPressed: () => _onCheckPressed(context, allItems),
                          text: l10n.check,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
