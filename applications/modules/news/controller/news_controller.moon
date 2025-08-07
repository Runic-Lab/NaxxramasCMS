NewsListIndex = require "applications.modules.news.view.index"

news_list = {
    {
        id: 1
        title: "Nouvelle mise à jour de NaxxramasCMS"
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        author: "Admin"
        published_date: "2025-08-01"
    }
    {
        id: 2
        title: "Guide d'utilisation des modules"
        content: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        author: "Developer"
        published_date: "2025-07-28"
    }
    {
        id: 3
        title: "Optimisations de sécurité"
        content: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo."
        author: "Security Team"
        published_date: "2025-07-25"
    }
    {
        id: 4
        title: "Communauté et support"
        content: "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt."
        author: "Community Manager"
        published_date: "2025-07-20"
    }
    {
        id: 5
        title: "Roadmap 2025"
        content: "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem."
        author: "Product Manager"
        published_date: "2025-07-15"
    }
}

class NewsController extends System.BaseController
    @\action "latest"
    @\action "index"

    latest: (application, options = {}) =>
        limit = options.limit or 1
        
        filtered_news = {}
        count = 0

        for news in *news_list
            continue if count >= limit
            if options.excerpt
                news.content = string.sub news.content, 1, 50
            table.insert filtered_news, news
            count += 1

        return filtered_news

    index: (application) =>
        application.locals = {
            title: "All news"
            news_list: news_list
            current_time: os.date "%Y-%m-%d %H:%M:%S"
        }

        return @render_view NewsListIndex

NewsController!\register_as "news"