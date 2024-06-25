import 'package:animated_search_bar/debouncer.dart';
import 'package:flutter/material.dart';

///*********************************************
/// Created by Lzyct on 22/09/20 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/Lzyct <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class AnimatedSearchBar extends StatefulWidget {
  ///  label - String ,isRequired : No
  ///  onChanged - Function(String)  ,isRequired : No
  ///  labelStyle - TextStyle ,isRequired :  No
  ///  searchDecoration - InputDecoration  ,isRequired : No
  ///  animationDuration in milliseconds -  int ,isRequired : No
  ///  searchStyle - TextStyle ,isRequired :  No
  ///  cursorColor - Color ,isRequired : No
  ///  duration - Duration for debouncer
  ///
  const AnimatedSearchBar({
    Key? key,
    this.label = "",
    this.labelAlignment = Alignment.centerLeft,
    this.labelTextAlign = TextAlign.start,
    this.alignment = TextAlign.start,
    this.onChanged,
    this.labelStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    this.searchDecoration = const InputDecoration(
        labelText: "Search",
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)), gapPadding: 4)),
    this.animationDuration = 350,
    this.searchStyle = const TextStyle(color: Colors.black),
    this.cursorColor,
    this.duration = const Duration(milliseconds: 300),
    this.height = 60,

    /// Value key must set with value close
    this.closeIcon = const Icon(Icons.close, key: ValueKey("close")),

    /// Value key must set with value search
    this.searchIcon = const Icon(Icons.search, key: ValueKey("search")),
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
  final int animationDuration;
  final TextStyle searchStyle;
  final Color? cursorColor;
  final TextAlign alignment;
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
  /// Value notifier to handle change view
  ValueNotifier<bool> _isSearch = ValueNotifier(false);
  final _fnSearch = FocusNode();
  late final _debouncer = Debouncer(duration: widget.duration);
  late TextEditingController _conSearch =
      widget.controller ?? TextEditingController();

  @override
  void initState() {
    super.initState();

    /// initialize isSearch value
    _isSearch.value = _conSearch.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    // Use row as Root view
    return GestureDetector(
      onTap: () {
        if (!_isSearch.value) {
          _isSearch.value = true;
          _fnSearch.requestFocus();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Handle Animated Change view for Title and TextField Search
          Expanded(
            // Use animated Switcher to show animation in transition widget
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: widget.animationDuration),
              transitionBuilder: (Widget child, Animation<double> animation) {
                //animated from right to left
                final inAnimation = Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset(0.0, 0.0),
                ).animate(animation);

                //animated from left to right
                final outAnimation = Tween<Offset>(
                  begin: Offset(-1.0, 0.0),
                  end: Offset(0.0, 0.0),
                ).animate(animation);

                // show different animation base on key
                if (child.key == ValueKey("textF")) {
                  return ClipRect(
                    child: SlideTransition(position: inAnimation, child: child),
                  );
                } else {
                  return ClipRect(
                    child:
                        SlideTransition(position: outAnimation, child: child),
                  );
                }
              },

              /// Use ValueListenableBuilder to handle change view
              child: ValueListenableBuilder(
                valueListenable: _isSearch,
                builder: (_, bool value, __) {
                  return value
                      ?
                      //Container of SearchView
                      SizedBox(
                          key: ValueKey("textF"),
                          height: widget.height,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextFormField(
                              focusNode: _fnSearch,
                              controller: _conSearch,
                              keyboardType: TextInputType.text,
                              textInputAction: widget.textInputAction,
                              textAlign: widget.alignment,
                              style: widget.searchStyle,
                              minLines: 1,
                              maxLines: 1,
                              cursorColor: widget.cursorColor ??
                                  ThemeData().primaryColor,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: widget.searchDecoration,
                              // check if onChanged is not null
                              onChanged: widget.onChanged != null
                                  ? (value) {
                                      // run debouncer to detect user not in typing
                                      _debouncer.run(() {
                                        widget.onChanged?.call(value);
                                      });
                                    }
                                  : null,
                              onFieldSubmitted: widget.onFieldSubmitted,
                            ),
                          ),
                        )
                      :
                      //Container of Label
                      SizedBox(
                          key: ValueKey("align"),
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
          // Handle Animated Change view for Search Icon and Close Icon
          IconButton(
            icon:
                // Use animated Switcher to show animation in transition widget
                AnimatedSwitcher(
              duration: Duration(milliseconds: 350),
              transitionBuilder: (Widget child, Animation<double> animation) {
                //animated from top to bottom
                final inAnimation = Tween<Offset>(
                  begin: Offset(0.0, 1.0),
                  end: Offset(0.0, 0.0),
                ).animate(animation);
                //animated from bottom to top
                final outAnimation = Tween<Offset>(
                  begin: Offset(0.0, -1.0),
                  end: Offset(0.0, 0.0),
                ).animate(animation);

                // show different animation base on key
                if (child.key == ValueKey("close")) {
                  return ClipRect(
                    child: SlideTransition(position: inAnimation, child: child),
                  );
                } else {
                  return ClipRect(
                    child:
                        SlideTransition(position: outAnimation, child: child),
                  );
                }
              },

              /// Use ValueListenableBuilder to handle change view
              child: ValueListenableBuilder(
                valueListenable: _isSearch,
                builder: (_, bool value, __) =>
                    value ? widget.closeIcon : widget.searchIcon,
              ),
            ),
            onPressed: () {
              /// Check if search active and it's not empty
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
