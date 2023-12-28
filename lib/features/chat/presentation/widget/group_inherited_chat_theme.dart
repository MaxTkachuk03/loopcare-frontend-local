import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

/// Used to make provided [ChatTheme] class available through the whole package.
class GroupInheritedChatTheme extends InheritedWidget {
  /// Creates [InheritedWidget] from a provided [ChatTheme] class.
  const GroupInheritedChatTheme({
    super.key,
    required this.theme,
    required super.child,
  });

  static GroupInheritedChatTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<GroupInheritedChatTheme>()!;

  /// Represents chat theme.
  final ChatTheme theme;

  @override
  bool updateShouldNotify(GroupInheritedChatTheme oldWidget) => theme.hashCode != oldWidget.theme.hashCode;
}
