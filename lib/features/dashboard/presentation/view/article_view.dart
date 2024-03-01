import 'package:crimson_cycle/features/dashboard/presentation/viewmodel/article_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticleView extends ConsumerStatefulWidget {
  const ArticleView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticleViewState();
}

class _ArticleViewState extends ConsumerState<ArticleView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(articleViewModelProvider);
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0) {
            ref.read(articleViewModelProvider.notifier).getArticles();
          }
        }
        return true;
      },
      child: RefreshIndicator(
        color: Colors.red,
        onRefresh: () async {
          ref.read(articleViewModelProvider.notifier).resetState();
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                controller: _scrollController,
                itemCount: state.articles.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final article = state.articles[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: Container(
                        width: 50, // Set the desired width
                        height: 50, // Set the desired height
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(article.articleImageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(article.articleName),
                      subtitle: Text(article.articleDescription),
                    ),
                  );
                },
              ),
            ),
            if (state.isLoading)
              const CircularProgressIndicator(color: Colors.red),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
