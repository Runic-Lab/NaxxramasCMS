NewsModel = require "applications.modules.news.model.news_model"

class NewsController extends System.BaseController
    @\action "latest"
    @\action "index"
    @\action "detail"

    latest: (application, limit) =>
        limit or= 1
        filtered_news = {}
        count = 0

        news_list = NewsModel\get_latest(limit)

        for news in *news_list
            continue if count >= limit
            table.insert filtered_news, news
            count += 1

        return filtered_news

    index: (application) =>
        application.locals = {
            title: "All news"
            news_list: NewsModel\get_all!
            current_time: os.date "%Y-%m-%d %H:%M:%S"
        }

        return @render_view "index"

    detail: (application) =>
        slug = application.params.slug
        is valid, result = @validate_slug

        unless is_valid
            application.locals = {
                error: result
                status: 400
            }
            return @render_view "error"

        clean_slug = result

        news_item = NewsModel\get_by_slug slug
        application.locals = {
            news: news_item[1]
        }

        return @render_view "detail"

NewsController!\register_as "news"