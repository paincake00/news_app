import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticlesBloc({
    required GetArticleUseCase getArticleUseCase,
  })  : _getArticleUseCase = getArticleUseCase,
        super(const RemoteArticlesLoading()) {
    on<GetArticles>(_onGetArticles);
  }

  void _onGetArticles(
      GetArticles event, Emitter<RemoteArticlesState> emit) async {
    emit(const RemoteArticlesLoading());

    final dataState = await _getArticleUseCase.call(
        params: event.query); // No need to upload the repository

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
        RemoteArticlesDone(articles: dataState.data!),
      );
    }

    if (dataState is DataFailed) {
      emit(
        RemoteArticlesError(error: dataState.error!),
      );
    }
  }
}
