import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:news_app/features/daily_news/presentation/widgets/my_search_bar.dart';

class DailyNews extends StatefulWidget {
  const DailyNews({super.key});

  @override
  State<DailyNews> createState() => _DailyNewsState();
}

class _DailyNewsState extends State<DailyNews> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.text = '';
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: 50,
            child: Align(
              alignment: Alignment.topCenter,
              child: MySearchBar(
                  searchController: _searchController,
                  onSearch: (query) {
                    BlocProvider.of<RemoteArticlesBloc>(context)
                        .add(GetArticles(query: query));
                    _searchController.clear();
                    Navigator.pop(context);
                  }),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _HomeBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.bookmark),
        onPressed: () => _onShowSavedArticlesViewTapped(context),
      ),
      title: const Text(
        'Daily News',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            _showBottomSheet();
          },
        ),
      ],
    );
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (context, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is RemoteArticlesError) {
          return const Center(
            child: Icon(
              Icons.warning_rounded,
              size: 30,
            ),
          );
        }
        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ArticleWidget(
                article: state.articles![index],
                onArticlePressed: (article) =>
                    _onArticlePressed(context, article),
              );
            },
            itemCount: state.articles!.length,
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}
