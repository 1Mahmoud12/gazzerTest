part of '../ordersIssueScreens/incorrect_items_screen.dart';

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
        border: Border.all(color: isSelected ? Co.purple : Colors.grey.shade300, width: isSelected ? 2 : 1),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: isSelected,
                  visualDensity: VisualDensity.compact,
                  activeColor: Co.purple,
                  onChanged: (_) => onTap(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(item.name, style: TStyle.robotBlackRegular14())),
            ],
          ),
          // Show photo and note fields only if selected
          if (isSelected) ...[
            const VerticalSpacing(12),
            // Photo section
            Text(L10n.tr().takePhotoOfItem, style: TStyle.robotBlackThin()),
            const VerticalSpacing(8),
            if (itemData?.photo != null)
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(itemData!.photo!, height: 160, width: double.infinity, fit: BoxFit.fill),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: onRemovePhoto,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                        child: const Icon(Icons.close, color: Colors.white, size: 16),
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
                      Icon(Icons.camera_alt, color: Colors.grey.shade400, size: 32),
                      const SizedBox(height: 8),
                      Text(L10n.tr().tapToTakePhoto, style: TStyle.robotBlackThin().copyWith(color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              ),
            const VerticalSpacing(12),
            // Note section
            Text(L10n.tr().addYourNotes, style: TStyle.robotBlackThin()),
            const VerticalSpacing(8),
            MainTextField(controller: itemData?.noteController ?? TextEditingController(), hintText: L10n.tr().typeYourMessage, maxLines: 3),
          ],
        ],
      ),
    );
  }
}
