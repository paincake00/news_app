import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/remove_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticlesState> {
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleBloc({
    required GetSavedArticlesUseCase getSavedArticlesUseCase,
    required SaveArticleUseCase saveArticleUseCase,
    required RemoveArticleUseCase removeArticleUseCase,
  })  : _getSavedArticlesUseCase = getSavedArticlesUseCase,
        _saveArticleUseCase = saveArticleUseCase,
        _removeArticleUseCase = removeArticleUseCase,
        super(const LocalArticlesLoading()) {
    on<GetSavedArticlesEvent>(_onGetSavedArticles);

    on<RemoveArticleEvent>(_onRemoveArticle);

    on<SaveArticleEvent>(_onSaveArticle);
  }

  void _onGetSavedArticles(
    GetSavedArticlesEvent event,
    Emitter<LocalArticlesState> emit,
  ) async {
    emit(const LocalArticlesLoading());

    final articles = await _getSavedArticlesUseCase.call();

    emit(
      LocalArticlesDone(articles: articles),
    );
  }

  void _onRemoveArticle(
    RemoveArticleEvent event,
    Emitter<LocalArticlesState> emit,
  ) async {
    if (event.article != null) {
      await _removeArticleUseCase.call(
        params: event.article!,
      );
      // _onGetSavedArticles(emit);
      final articles = await _getSavedArticlesUseCase.call();

      emit(
        LocalArticlesDone(articles: articles),
      );
    }
  }

  void _onSaveArticle(
    SaveArticleEvent event,
    Emitter<LocalArticlesState> emit,
  ) async {
    if (event.article != null) {
      await _saveArticleUseCase.call(
        params: event.article!,
      );
      // _onGetSavedArticles(emit);
      final articles = await _getSavedArticlesUseCase.call();

      emit(
        LocalArticlesDone(articles: articles),
      );
    }
  }
}
