mediator = System.ModuleMediator\get_instance!

class HomeController extends System.BaseController
    @\action "index"

    index: (application) =>
        mediator = @get_mediator!

        news_widget_data = mediator\request "news", "latest", application, 3

        application.locals = {
            title: "Welcome to NaxxramasCMS"
            message: "Hello from the home controller"
            current_time: os.date "%Y-%m-%d %H:%M:%S"
            news_list: news_widget_data
        }

        return @render_view "index"

HomeController!\register_as "home"