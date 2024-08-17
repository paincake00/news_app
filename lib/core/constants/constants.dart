import 'package:flutter_dotenv/flutter_dotenv.dart';

const String newsAPIBaseURL = 'https://newsapi.org/v2';

const String languageQuery = 'ru';
const String query = 'а';
const String sortByQuery = 'publishedAt';

const String kDefaultImage =
    "https://www.google.com/search?q=default+image&client=firefox-b-d&sxsrf=APq-WBskmtr-ix6NUAqqiHFNpsJX6JSOTg:1650026644151&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjEi_qfjJb3AhXvQd8KHd02BKUQ_AUoAXoECAEQAw#imgrc=A0pMe2lq2NT_jM";

final apiKey = dotenv.env['API_KEY'];
