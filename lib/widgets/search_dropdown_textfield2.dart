import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Helper/size.dart';
import 'package:flutter/material.dart';

class SearchDropdownTextField2<T> extends StatefulWidget {
  final initialValue;
  final String? labelText;
  final String? hintText;
  final TextStyle? labelTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final bool enabled;
  final List<T>? items;
  final T? selectedItem;
  final bool isValidator;
  final validator;
  final bool? filled;
  final BorderSide? inputBorder;
  final String? errorMessage;
  final Function(T value) onChanged;
  final Function? onAddPressed;
  final Color? color;
  final Color? filledColor;
  final InputBorder? border;
  final Widget? suffixIcon;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextEditingController? textEditingController;

  const SearchDropdownTextField2({
    Key? key,
    this.labelText,
    this.enabled = true,
    this.items,
    required this.selectedItem,
    required this.isValidator,
    this.errorMessage,
    this.color,
    required this.onChanged,
    this.onAddPressed,
    this.border,
    this.filled = false,
    this.filledColor,
    this.inputBorder,
    this.labelTextStyle,
    this.suffixIcon,
    this.textStyle,
    this.initialValue,
    this.hintText,
    this.hintTextStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.validator,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<SearchDropdownTextField2<T>> createState() =>
      _SearchDropdownTextField2State<T>();
}

class _SearchDropdownTextField2State<T>
    extends State<SearchDropdownTextField2<T>> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController(
        text: (widget.selectedItem?.toString() != null)
            ? widget.selectedItem?.toString()
            : "");
    return TextFormField(
      controller: textEditingController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: widget.initialValue,
      style: widget.textStyle ??
          TextStyle(
              decoration: TextDecoration.none,
              fontFamily: MyFont.myFont2,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: MyColors.black),
      enabled: widget.enabled,
      showCursor: false,
      readOnly: true,
      decoration: InputDecoration(
        hintStyle: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: MyFont.myFont2,
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: MyColors.greyText),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: MyColors.greyText,
          fontSize: 13,
          fontFamily: MyFont.myFont2,
          fontWeight: FontWeight.w900,
        ),
      ),
      onTap: () {
        _showMaterialDialog(context, textEditingController);
      },
      validator: widget.validator ??
          (value) {
            if (widget.isValidator && (value == null || value.isEmpty)) {
              return widget.errorMessage ?? '';
            }
            return null;
          },
    );
  }

  void _showMaterialDialog(
      BuildContext context, TextEditingController textEditingController) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: MyColors.containerEBEBEB.withOpacity(0.9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: SizedBox(
              width: double.maxFinite,
              height: height(context) / 1.9,
              child: SearchDialog<T>(
                  items: widget.items,
                  onAddPressed: (widget.onAddPressed != null
                      ? () {
                          if (widget.onAddPressed != null) {
                            widget.onAddPressed!();
                          }
                        }
                      : null),
                  onChanged: (value) {
                    textEditingController.text = value.toString();
                    widget.onChanged(value);
                  }),
            ),
          );
        });
  }
}

class SearchDialog<T> extends StatefulWidget {
  final List<T>? items;
  final Function(T value) onChanged;
  final Function? onAddPressed;

  const SearchDialog(
      {Key? key,
      required this.items,
      required this.onChanged,
      this.onAddPressed})
      : super(key: key);

  @override
  createState() => _SearchDialogState<T>();
}

class _SearchDialogState<T> extends State<SearchDialog<T>> {
  final TextEditingController _filter = TextEditingController();
  List<T>? _filterTaskList;
  String _searchText = "";

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _filterTaskList = widget.items;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addFilterListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _filter,
                cursorColor: MyColors.black,
                style: TextStyle(
                    fontFamily: MyFont.myFont, color: MyColors.mainTheme),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyColors.containerEBEBEB,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontFamily: MyFont.myFont, color: MyColors.mainTheme),
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
            //if (widget.onAddPressed != null)
            // IconButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //     widget.onAddPressed!();
            //   },
            //   icon: const Icon(Icons.add_circle),
            //   iconSize: 30,
            // )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.separated(
            itemCount: _filterTaskList?.length ?? 0,
            itemBuilder: (context, index) {
// ReasonListModel reasonListModel =
// _rejectReasonList![index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onChanged(_filterTaskList![index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    _filterTaskList![index].toString(),
                    style: TextStyle(
                        fontFamily: MyFont.myFont2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: MyColors.black),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
          ),
        )
      ],
    );
  }

  _addFilterListener() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _filterTaskList = widget.items;
        });
      } else {
        setState(() {
          PreferenceHelper.print(_filter.text);
          _searchText = _filter.text;
          _filterTaskList = widget.items
              ?.where((element) => (element
                  .toString()
                  .toLowerCase()
                  .contains(_searchText.toLowerCase())))
              .toList();
        });
      }
    });
  }
}
