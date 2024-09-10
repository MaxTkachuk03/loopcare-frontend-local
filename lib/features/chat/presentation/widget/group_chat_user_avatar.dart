// ignore_for_file: depend_on_referenced_packages
// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_ui/src/util.dart';
import 'package:flutter_chat_ui/src/widgets/state/inherited_chat_theme.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/chat/presentation/widget/hexagon_avatar.dart';

/// Renders user's avatar or initials next to a message.
class GroupChatUserAvatar extends UserAvatar {
  /// Creates user avatar.
  const GroupChatUserAvatar({
    super.key,
    required super.author,
    super.bubbleRtlAlignment,
    super.imageHeaders,
    Function(types.User)? super.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = getUserAvatarNameColor(
      author,
      InheritedChatTheme.of(context).theme.userAvatarNameColors,
    );
    final hasImage = author.imageUrl != null;
    final initials = getUserInitials(author);

    return GestureDetector(
      onTap: () => onAvatarTap?.call(author),
      child: HexagonUserAvatar(
        backgroundColor:
            hasImage ? InheritedChatTheme.of(context).theme.userAvatarImageBackgroundColor : color,
        backgroundImage: hasImage ? NetworkImage(author.imageUrl!, headers: imageHeaders) : null,
        // radius: 16,
        child: !hasImage
            ? CustomText.bitter600(
                initials,
                style: context.textTheme.bodySmall?.copyWith(color: AppColors.white),
              )
            : null,
      ),
    );
  }
}
