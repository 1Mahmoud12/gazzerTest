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
      Alerts.showToast('Error taking photo');
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
      Alerts.showToast('Please select at least one item');
      return;
    }

    // Submit complaint with all selected items
    final selectedItemIds = _selectedItemIds.toList();

    // Get first item's photo (API only accepts one attachment)
    final firstItemData = _itemComplaintData[selectedItemIds.first];

    // Combine notes from all selected items
    final notesList = selectedItemIds.map((id) => _itemComplaintData[id]?.note).whereType<String>().where((note) => note.isNotEmpty).toList();
    final combinedNote = notesList.isNotEmpty ? notesList.join('\n\n') : null;

    final request = ComplaintRequest(
      orderId: widget.orderId,
      orderItemIds: selectedItemIds,
      note: combinedNote,
      type: ComplaintType.damagedItems,
      attachment: firstItemData?.photo,
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
                              final isSelected = _selectedItemIds.contains(item.id);
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

class _IncorrectItemCard extends StatelessWidget {
  const _IncorrectItemCard({
    required this.item,
    required this.isSelected,
    this.itemData,
    required this.onTap,
    required this.onPickPhoto,
    required this.onRemovePhoto,
  });

  final OrderDetailItemEntity item;
  final bool isSelected;
  final ItemComplaintData? itemData;
  final VoidCallback onTap;
  final VoidCallback onPickPhoto;
  final VoidCallback onRemovePhoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Co.purple : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item selection row
          Row(
            children: [
              Transform.scale(
                scale: 1.1,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: isSelected,
                  visualDensity: VisualDensity.compact,
                  activeColor: Co.purple,
                  onChanged: (_) => onTap(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.name,
                  style: TStyle.blackMedium(14),
                ),
              ),
            ],
          ),
          // Show photo and note fields only if selected
          if (isSelected) ...[
            const VerticalSpacing(12),
            // Photo section
            Text(
              'Take photo of item',
              style: TStyle.blackMedium(12),
            ),
            const VerticalSpacing(8),
            if (itemData?.photo != null)
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      itemData!.photo!,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: onRemovePhoto,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              GestureDetector(
                onTap: onPickPhoto,
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.grey.shade400,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to take photo',
                        style: TStyle.blackRegular(12).copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const VerticalSpacing(12),
            // Note section
            Text(
              'Add note for this item',
              style: TStyle.blackMedium(12),
            ),
            const VerticalSpacing(8),
            MainTextField(
              controller: itemData?.noteController ?? TextEditingController(),
              hintText: 'Type your note here...',
              maxLines: 3,
            ),
          ],
        ],
      ),
    );
  }
}
