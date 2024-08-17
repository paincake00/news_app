abstract class RemoteArticlesEvent {
  const RemoteArticlesEvent();
}

class GetArticles extends RemoteArticlesEvent {
  final String query;

  const GetArticles({required this.query});
}
