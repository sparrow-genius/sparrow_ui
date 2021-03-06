import 'package:sparrow_ui/sparrow_ui.dart';
import 'button_style.dart';
export 'button_style.dart';

class SPButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String content;
  final SPButtonStyle style;
  SPButton({
    Key? key,
    required this.onPressed,
    required this.content,
    this.style = const SPButtonStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = SPTheme.of(context);
    final colorSense = style.colorSense;
    final buttonType = style.buttonType;
    final buttonRadius = style.buttonRadius;
    final buttonSize = style.buttonSize;
    final buttonStatus = style.buttonStatus;

    // 注意此处，map取值的类型检查

    // 弃用旧的MaterialButton，改用新的ButtonStyleButton

    // 颜色组合：文字颜色、边框颜色、背景色

    return TextButton(
      onPressed: onPressed,
      child: Text(
        content,
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: _renderFontSize(),
          fontWeight: FontWeight.w500,
          height: SuiFonts.lineHeightContent,
        ),
      ),
      style: _renderStyle(theme),
    );
  }

  /// 按钮样式
  ButtonStyle _renderStyle(SPThemeData theme) {
    final MaterialColor colorSwatch = theme.cSPColorSense[style.colorSense]!;

    return ButtonStyle(
      // 填充色、背景色
      backgroundColor: _renderBackgroundColor(colorSwatch),
      // 文字颜色、前景色
      foregroundColor: _renderTextColor(colorSwatch),
      elevation: MaterialStateProperty.all<double>(0),
      fixedSize: MaterialStateProperty.all<Size>(
          Size.fromHeight(_renderButtonHeight())),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          // 圆角大小
          borderRadius: _renderRadius(),
          // 边框
          side: _renderBorder(colorSwatch),
        ),
      ),
      alignment: Alignment.center,
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  /// 圆角
  BorderRadiusGeometry _renderRadius() {
    // 小圆角、大圆角
    if (style.buttonRadius == SPRadius.small) {
      return BorderRadius.circular(SPSize.radiusSmall);
    } else if (style.buttonRadius == SPRadius.big) {
      return BorderRadius.circular(SPSize.radiusBig);
    }

    // 全圆角：需要根据按钮大小显示
    return BorderRadius.circular(_renderButtonHeight() / 2);
  }

  /// 边框
  BorderSide _renderBorder(MaterialColor colorSwatch) {
    // 主按钮没有边框
    if (style.buttonType == SPButtonType.primary) {
      return BorderSide.none;
    }

    // 次按钮
    return BorderSide(
      width: 1.rpx,
      color: _renderBorderColor(colorSwatch),
    );
  }

  /// 填充色
  MaterialStateProperty<Color> _renderBackgroundColor(
      MaterialColor colorSwatch) {
    // 主按钮的填充颜色是色卡6
    if (style.buttonType == SPButtonType.primary) {
      return MaterialStateProperty.all<Color>(colorSwatch[6]!);
    }

    // 次按钮的文字颜色是色卡1
    return MaterialStateProperty.all<Color>(colorSwatch[1]!);
  }

  /// 文字颜色
  MaterialStateProperty<Color> _renderTextColor(MaterialColor colorSwatch) {
    // 主按钮的文字颜色是白色
    if (style.buttonType == SPButtonType.primary) {
      return MaterialStateProperty.all<Color>(SPColors.white);
    }

    // 次按钮的文字颜色是色卡6
    return MaterialStateProperty.all<Color>(colorSwatch[6]!);
  }

  /// 边框色
  Color _renderBorderColor(MaterialColor colorSwatch) {
    // 主按钮没有边框颜色

    // 次按钮的边框颜色是色卡3
    return colorSwatch[3]!;
  }

  double _renderFontSize() {
    return style.buttonSize == SPButtonSize.big ? 34.rpx : 28.rpx;
  }

  double _renderButtonHeight() {
    return style.buttonSize == SPButtonSize.big ? 96.rpx : 64.rpx;
  }
}
