part of 'local_article_bloc.dart';

sealed class LocalArticleEvent extends Equatable {
  final ArticleEntity? article;

  const LocalArticleEvent({
    this.article,
  });

  @override
  List<Object> get props => [
        article!,
      ];
}

class GetSavedArticlesEvent extends LocalArticleEvent {
  const GetSavedArticlesEvent();
}

class RemoveArticleEvent extends LocalArticleEvent {
  const RemoveArticleEvent({
    required ArticleEntity articleEntity,
  }) : super(article: articleEntity);
}

class SaveArticleEvent extends LocalArticleEvent {
  const SaveArticleEvent({
    required ArticleEntity articleEntity,
  }) : super(article: articleEntity);
}
