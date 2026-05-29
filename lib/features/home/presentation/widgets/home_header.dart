import 'package:flutter/material.dart';
import 'package:project/features/home/presentation/widgets/home_header_background.dart';
import 'package:project/features/home/presentation/widgets/location_selector.dart';
import 'package:project/features/home/presentation/widgets/search_input.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const HomeHeaderBackground(),

          /// Floating Search & Location
          PositionedDirectional(
            start: 16,
            end: 16,
            bottom: 0,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                children: [
                  /// Search Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSearching = !isSearching;
                      });
                    },
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            color: Colors.black.withOpacity(.12),
                          ),
                        ],
                      ),
                      child: Icon(isSearching ? Icons.close : Icons.search),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Animated Area
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),

                      transitionBuilder: (child, animation) {
                        return SizeTransition(
                          axis: Axis.horizontal,
                          axisAlignment: -1,
                          sizeFactor: animation,
                          child: child,
                        );
                      },

                      child: isSearching
                          ? const SearchInput(key: ValueKey('search'))
                          : const LocationSelector(key: ValueKey('location')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
