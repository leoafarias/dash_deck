import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../../modules/common/helpers/constants.dart';

class ScaledWidget extends StatelessWidget {
  final Widget child;

  const ScaledWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.biggest.width;

        var height = width / kAspectRatio;

        if (height > constraints.biggest.height) {
          height = constraints.biggest.height;
          width = height * kAspectRatio;
        }

        final scaleWidth = width / kResolution.width;
        final scaleHeight = height / kResolution.height;

        return SizedBox(
          width: width,
          height: height,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                const Center(),
                Positioned(
                  top: (kResolution.height - height) / -2,
                  left: (kResolution.width - width) / -2,
                  width: kResolution.width.toDouble(),
                  height: kResolution.height.toDouble(),
                  child: Transform.scale(
                    scaleY: scaleHeight,
                    scaleX: scaleWidth,
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(size: kResolution),
                      child: ScaledWidgetProvider(
                        scale: scaleWidth,
                        child: child,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

//  create inherited widget that can pass teh scale factor to the child widget
class ScaledWidgetProvider extends InheritedWidget {
  const ScaledWidgetProvider({
    required this.scale,
    required super.child,
    super.key,
  });

  final double scale;

  @override
  bool updateShouldNotify(ScaledWidgetProvider oldWidget) {
    return oldWidget.scale != scale;
  }
}
