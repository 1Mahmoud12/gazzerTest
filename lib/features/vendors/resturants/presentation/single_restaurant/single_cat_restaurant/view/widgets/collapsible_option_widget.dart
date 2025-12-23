part of '../single_cat_restaurant_details.dart';

class _CollapsibleOptionWidget extends StatefulWidget {
  const _CollapsibleOptionWidget({
    required this.optionId,
    required this.optionName,
    required this.values,
    required this.type,
    required this.isRequired,
    required this.selectedId,
    required this.getSelectedOptions,
    required this.onValueSelected,
  });

  final String optionId;
  final String optionName;
  final List<SubAddonEntity> values;
  final OptionType type;
  final bool isRequired;
  final Set<String> selectedId;
  final Function(String path) getSelectedOptions;
  final Function({required String fullPath, required String id}) onValueSelected;

  @override
  State<_CollapsibleOptionWidget> createState() => _CollapsibleOptionWidgetState();
}

class _CollapsibleOptionWidgetState extends State<_CollapsibleOptionWidget> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Co.bg, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Co.secondary.withOpacityNew(0.1), borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.fastfood, color: Co.secondary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.optionName, style: TStyle.blackBold(14)),
                          Text(widget.type == OptionType.radio ? L10n.tr().select_1 : L10n.tr().multi_select, style: TStyle.greyRegular(12)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.isRequired ? Co.purple100 : Co.grey.withOpacityNew(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.isRequired ? L10n.tr().required : L10n.tr().optional,
                        style: TStyle.robotBlackThin().copyWith(fontWeight: FontWeight.w500, color: widget.isRequired ? Co.black : Co.grey),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ),
          if (_isExpanded)
            PlateOptionsWidget(
              optionId: widget.optionId,
              optionName: widget.optionName,
              values: widget.values,
              type: widget.type,
              selectedId: widget.selectedId,
              getSelectedOptions: widget.getSelectedOptions,
              onValueSelected: widget.onValueSelected,
            ),
        ],
      ),
    );
  }
}
