import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/data/data.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final Widget? titleWidget;
  final Widget? secondleading;
  final Widget? secondtitleWidget;
  const CustomAppbar({
    super.key,
    this.title = '',
    this.leading,
    this.titleWidget,
    this.secondleading,
    this.secondtitleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 25 / 2.5,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                        title,
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            color: tipo,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : Center(
                      child: titleWidget!,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading ??
                    Transform.translate(
                      offset: const Offset(-14, 0),
                      child: Text('',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w600,
                              fontSize: 40,
                              color: Colors.transparent)),
                    ),
                secondleading ??
                    Transform.translate(
                      offset: const Offset(0, 0),
                      child: null,
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(
        double.maxFinite,
        80,
      );
}
