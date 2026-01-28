import 'package:flutter/material.dart';

import 'posts_repository.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingDialog(),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      child: Center(
        child: Card(
          child: Container(
            alignment: .center,
            width: 48,
            height: 48,
            margin: const .all(16),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class LoadingFilledButton extends StatelessWidget {
  const LoadingFilledButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final bool isEnabled;

  Color _buildBackgroundColor(BuildContext context) {
    final theme = Theme.of(context);
    if (isLoading) {
      return theme.colorScheme.secondary;
    } else if (isEnabled) {
      return theme.colorScheme.primary;
    } else {
      return theme.colorScheme.onSurface.withValues(alpha: 0.12);
    }
  }

  Color _buildTextColor(BuildContext context) {
    final theme = Theme.of(context);
    if (isLoading) {
      return theme.colorScheme.onSecondary;
    } else if (isEnabled) {
      return theme.colorScheme.onPrimary;
    } else {
      return theme.colorScheme.onSurface.withValues(alpha: 0.38);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(16);
    return RawMaterialButton(
      onPressed: isEnabled ? onPressed : null,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      fillColor: _buildBackgroundColor(context),
      disabledElevation: 0,
      elevation: 0,
      visualDensity: theme.visualDensity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisSize: .min,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: _buildTextColor(context),
              ),
            ),
            if (isLoading) ...[
              const SizedBox(width: 8),
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _buildTextColor(context),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class CrudErrorCard extends StatelessWidget {
  const CrudErrorCard({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: Colors.transparent,
      child: Container(
        color: theme.colorScheme.errorContainer,
        padding: const .all(8),
        alignment: .center,
        child: Column(
          children: [
            Text(
              'Error',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onErrorContainer,
                fontWeight: .bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSuccessSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

void showErrorSnackBar({
  required BuildContext context,
  required String message,
  required Object error,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          '$message. "$error"',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
      ),
    );
}

class PostsListErrorWidget extends StatelessWidget {
  const PostsListErrorWidget({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Card(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}

class PostsListLoadingWidget extends StatelessWidget {
  const PostsListLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class PostsListDataEmptyWidget extends StatelessWidget {
  const PostsListDataEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topCenter,
      child: Card(
        child: Container(
          width: .infinity,
          padding: const .all(16),
          child: const Text('No posts yet. Create one!'),
        ),
      ),
    );
  }
}

class PostListCardWidget extends StatelessWidget {
  const PostListCardWidget({
    super.key,
    required this.post,
    required this.actions,
  });

  final Post post;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(children: actions),
          ],
        ),
      ),
    );
  }
}
