import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/selection_tile_item.dart';

class SelectSearchMenu<T> extends StatefulWidget {
  const SelectSearchMenu({
    super.key,
    required this.hintText,
    this.displaySearch = true,
    this.isLoading = false,
    this.buttonTxt,
    this.initValue,
    this.items,
    this.onSubmit,
    this.fillColor,
    this.searchInputBGColor,
    this.textStyle,
    this.validator,
    this.widget,
    required this.mapper,
    this.secondaryColor,
    this.primaryColor,
    this.isSingle = true,
    this.label,
    this.borderRadius = 20,
    this.showBorder = true,
  });
  final String? hintText;
  final String? label;
  final TextStyle? textStyle;
  final String? buttonTxt;
  final List<T>? items;
  final Set<T> Function()? initValue;
  final Widget? widget;
  final Function(Set<OptionItem>)? onSubmit;
  final String? Function(String?)? validator;
  final bool displaySearch;
  final Color? searchInputBGColor;
  final bool isLoading;
  final OptionItem? Function(T item) mapper;
  final Color? fillColor;
  final Color? secondaryColor;
  final Color? primaryColor;
  final bool isSingle;
  final double borderRadius;
  final bool showBorder;
  @override
  State<SelectSearchMenu<T>> createState() => _SelectSearchMenuState<T>();
}

class _SelectSearchMenuState<T> extends State<SelectSearchMenu<T>> {
  final controller = TextEditingController();

  @override
  void initState() {
    if (widget.initValue != null) {
      controller.text = widget.initValue!().map((e) => widget.mapper(e)?.title ?? '').join(', ');
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SelectSearchMenu<T> oldWidget) {
    if (widget.initValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.text = widget.initValue == null ? '' : widget.initValue!().map((e) => widget.mapper(e)?.title ?? '').join(', ');
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      onTap: widget.items?.isNotEmpty != true || widget.isLoading
          ? null
          : () {
              showDialog(
                context: context,
                builder: (context) => _SelectMenu(
                  initialSelectedValues: widget.initValue == null ? null : widget.initValue!().map((e) => widget.mapper(e)!).toSet(),
                  items: widget.items?.map((e) => widget.mapper(e)!).toList(),
                  buttonTxt: widget.buttonTxt,
                  widget: widget.widget,
                  hintText: widget.hintText,
                  isSingle: widget.isSingle,
                  primaryColor: widget.primaryColor,
                  secondaryColor: widget.secondaryColor,
                  displaySearch: widget.displaySearch,
                  onSubmit: (v) {
                    if (widget.isSingle) {
                      controller.text = v.first.title;
                      if (widget.onSubmit != null) widget.onSubmit!(v);
                    } else {
                      controller.text = v.map((e) => e.title).join(', ');
                      if (widget.onSubmit != null) widget.onSubmit!(v);
                    }
                  },
                ),
              );
            },
      child: MainTextField(
        controller: controller,
        hintText: widget.hintText,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: widget.items?.isNotEmpty == true ? Colors.black : Colors.grey,
        ),
        bgColor: Colors.white,
        showBorder: widget.showBorder,
        enabled: false,
        label: widget.label,
        borderRadius: widget.borderRadius,
        isLoading: widget.isLoading,
        validator: widget.validator,
        suffix: LayoutBuilder(
          builder: (context, constrains) {
            return SizedBox(
              height: constrains.minHeight,
              width: constrains.minHeight,
              child: widget.isLoading
                  ? AdaptiveProgressIndicator(size: 12, color: widget.primaryColor)
                  : Icon(
                      Icons.arrow_drop_down_outlined,
                      color: widget.items?.isNotEmpty == true ? Colors.black : Colors.grey,
                    ),
            );
          },
        ),
      ),
    );
  }
}

class OptionItem {
  final int id;
  final String title;
  const OptionItem({required this.id, required this.title});
}

class _SelectMenu extends StatefulWidget {
  const _SelectMenu({
    required this.hintText,
    this.items,
    this.buttonTxt,
    this.initialSelectedValues,
    // this.onChange,
    this.widget,
    this.displaySearch = true,
    this.secondaryColor,
    this.primaryColor,
    this.onSubmit,
    required this.isSingle,
  });

  final String? hintText;

  final String? buttonTxt;
  final List<OptionItem>? items;
  final Set<OptionItem>? initialSelectedValues;
  final Widget? widget;
  final Function(Set<OptionItem>)? onSubmit;
  final bool displaySearch;
  final Color? secondaryColor;
  final Color? primaryColor;
  final bool isSingle;

  @override
  State<StatefulWidget> createState() => __SelectMenuState();
}

class __SelectMenuState extends State<_SelectMenu> {
  final Set<OptionItem> _selectedValues = {};
  final Set<int> _selectedIds = {};
  bool isFoled = true;
  final TextEditingController searchText = TextEditingController();
  late final List<OptionItem> items;

  @override
  void initState() {
    items = List.of(widget.items ?? []);
    if (widget.initialSelectedValues != null) {
      for (var item in widget.initialSelectedValues!) {
        _selectedIds.add(item.id);
        _selectedValues.add(item);
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
    super.initState();
  }

  void _onItemCheckedChange(OptionItem itemValue, bool checked) {
    if (mounted) {
      if (widget.isSingle) {
        _selectedValues.clear();
        _selectedIds.clear();
        _selectedIds.add(itemValue.id);
        _selectedValues.add(itemValue);
      } else {
        if (_selectedIds.add(itemValue.id)) {
          _selectedValues.add(itemValue);
        } else {
          _selectedIds.remove(itemValue.id);
          _selectedValues.removeWhere((e) => e.id == itemValue.id);
        }
      }
      setState(() {});
    }
  }

  void _onSubmitTap() {
    widget.onSubmit!(_selectedValues);
  }

  void _onSearch(String? value) {
    items.clear();
    items.addAll(widget.items ?? []);
    if (value == null || value.isEmpty) return setState(() {});
    setState(() {
      items.retainWhere((e) => e.title.toLowerCase().contains(value.toLowerCase()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.defaultRadius)),
      backgroundColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),

      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 450),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: widget.displaySearch
                    ? TextFormField(
                        autofocus: false,
                        controller: searchText,
                        onChanged: (v) => _onSearch(v),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          isDense: true,
                          hintText: widget.hintText,
                          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          hintStyle: const TextStyle(fontSize: 15, color: Colors.black),
                          // border: OutlineInputBorder(borderRadius: 0),
                          suffixIcon: InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Navigator.pop(context);
                              searchText.value = TextEditingValue.empty;
                            },
                            child: const Icon(Icons.cancel, color: Colors.black54, size: 25),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 25),
                          Text(
                            widget.hintText!,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.cancel, color: widget.primaryColor, size: 25),
                          ),
                        ],
                      ),
              ),
            ),
            if (widget.widget != null) widget.widget!,
            // if (items.isNotEmpty)
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Text(
                        L10n.tr().noData,
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: widget.secondaryColor),
                      ),
                    )
                  : Scrollbar(
                      trackVisibility: true,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        shrinkWrap: true,
                        itemCount: items.length,
                        separatorBuilder: (context, index) => const Divider(
                          height: 13,
                          thickness: 1,
                          endIndent: 25,
                          indent: 25,
                        ),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isChecked = _selectedIds.contains(item.id);
                          return SelectionTileItem(
                            isSelected: isChecked,
                            title: item.title,
                            radioSize: 10,
                            onTap: () => _onItemCheckedChange(item, isChecked),
                            isSingle: widget.isSingle,
                          );
                        },
                        addRepaintBoundaries: false,
                      ),
                    ),
            ),
            if (items.isNotEmpty)
              MainBtn(
                bgColor: widget.primaryColor,
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                text: widget.buttonTxt ?? L10n.tr().submit,
                isEnabled: true,
                onPressed: () {
                  if (_selectedValues.isEmpty) return;
                  _onSubmitTap();
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}
