HomeView = require "applications.modules.home.view.index"
NewsController = require "applications.modules.news.controller.news_controller"

class HomeController extends System.BaseController
    index: (application) =>
        news_widget_data = NewsController.latest application, {
            limit: 3
            title: "Dernières actualités"
            show_date: true
            show_author: true
            excerpt: true
        }

        application.locals = {
            title: "Welcome to NaxxramasCMS"
            message: "Hello from the home controller"
            current_time: os.date "%Y-%m-%d %H:%M:%S"
            news_list: news_widget_data
        }

        return @render_view HomeView

controller = HomeController!

return {
    index: (application) ->
        controller\index application
}