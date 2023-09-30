import 'package:animated_search_bar/debouncer.dart';
import 'package:flutter/material.dart';

/// A customizable animated search bar widget for Flutter applications.
class AnimatedSearchBar extends StatefulWidget {
  /// Creates an `AnimatedSearchBar` widget.
  ///
  /// [label] is the text to display when the search bar is not active.
  /// [labelAlignment] specifies the alignment of the label text.
  /// [labelTextAlign] specifies the text alignment of the label.
  /// [onChanged] is a callback function that is called,
  ///    when the text in the search bar changes.
  /// [labelStyle] is the style for the label text.
  /// [searchDecoration] is the decoration for the search input field.
  /// [animationDuration] is the duration for the animation,
  ///   when switching between label and search input.
  /// [searchStyle] is the style for the search input text.
  /// [cursorColor] is the color of the cursor in the search input field.
  /// [duration] is the debounce duration for input changes.
  /// [height] is the height of the search bar.
  /// [closeIcon] is the icon to display when the search bar is active.
  /// [searchIcon] is the icon to display when the search bar is not active.
  /// [controller] is a TextEditingController to control the text input.
  /// [onFieldSubmitted] is a callback function that is called
  ///  when the user submits the search field.
  /// [textInputAction] is the action to take when the user presses
  ///   the keyboard's done button.

  const AnimatedSearchBar({
    Key? key,
    this.label = '',
    this.labelAlignment = Alignment.centerLeft,
    this.labelTextAlign = TextAlign.start,
    this.onChanged,
    this.labelStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    this.searchDecoration = const InputDecoration(
      labelText: 'Search',
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    this.animationDuration = const Duration(milliseconds: 350),
    this.searchStyle = const TextStyle(color: Colors.black),
    this.cursorColor,
    this.duration = const Duration(milliseconds: 300),
    this.height = 60,
    this.closeIcon = const Icon(Icons.close, key: ValueKey('close')),
    this.searchIcon = const Icon(Icons.search, key: ValueKey('search')),
    this.controller,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.search,
  }) : super(key: key);

  final String label;
  final Alignment labelAlignment;
  final TextAlign labelTextAlign;
  final Function(String)? onChanged;
  final TextStyle labelStyle;
  final InputDecoration searchDecoration;
  final Duration animationDuration;
  final TextStyle searchStyle;
  final Color? cursorColor;
  final Duration duration;
  final double height;
  final Widget closeIcon;
  final Widget searchIcon;
  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  final TextInputAction textInputAction;

  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  final ValueNotifier<bool> _isSearch = ValueNotifier(false);
  final _fnSearch = FocusNode();
  final _debouncer = Debouncer();

  late TextEditingController _conSearch;

  @override
  void initState() {
    super.initState();
    _conSearch = widget.controller ?? TextEditingController();
    _isSearch.value = _conSearch.text.isNotEmpty;
    _debouncer.delay = widget.duration;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isSearch.value) {
          _isSearch.value = true;
          _fnSearch.requestFocus();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: widget.animationDuration,
              transitionBuilder: (Widget child, Animation<double> animation) {
                final inAnimation = Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation);
                final outAnimation = Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation);

                return ClipRect(
                  child: SlideTransition(
                    position: child.key == const ValueKey('textF')
                        ? inAnimation
                        : outAnimation,
                    child: child,
                  ),
                );
              },
              child: ValueListenableBuilder(
                valueListenable: _isSearch,
                builder: (_, bool value, __) {
                  return value
                      ? SizedBox(
                          key: const ValueKey('textF'),
                          height: widget.height,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextFormField(
                              focusNode: _fnSearch,
                              controller: _conSearch,
                              keyboardType: TextInputType.text,
                              textInputAction: widget.textInputAction,
                              textAlign: widget.labelTextAlign,
                              style: widget.searchStyle,
                              minLines: 1,
                              cursorColor: widget.cursorColor ??
                                  ThemeData().primaryColor,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: widget.searchDecoration,
                              onChanged: (value) {
                                _debouncer.run(() {
                                  widget.onChanged!(value);
                                });
                              },
                              onFieldSubmitted: widget.onFieldSubmitted,
                            ),
                          ),
                        )
                      : SizedBox(
                          key: const ValueKey('align'),
                          height: 60,
                          child: Align(
                            alignment: widget.labelAlignment,
                            child: Text(
                              widget.label,
                              style: widget.labelStyle,
                              textAlign: widget.labelTextAlign,
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final inAnimation = Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation);
                final outAnimation = Tween<Offset>(
                  begin: const Offset(0.0, -1.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation);

                return ClipRect(
                  child: SlideTransition(
                    position: child.key == const ValueKey('close')
                        ? inAnimation
                        : outAnimation,
                    child: child,
                  ),
                );
              },
              child: ValueListenableBuilder(
                valueListenable: _isSearch,
                builder: (_, bool value, __) {
                  return value ? widget.closeIcon : widget.searchIcon;
                },
              ),
            ),
            onPressed: () {
              if (_isSearch.value && _conSearch.text.isNotEmpty) {
                _conSearch.clear();
                widget.onChanged!(_conSearch.text);
              } else {
                _isSearch.value = !_isSearch.value;
                if (!_isSearch.value) widget.onChanged!(_conSearch.text);
                if (_isSearch.value) _fnSearch.requestFocus();
              }
            },
          ),
        ],
      ),
    );
  }
}
