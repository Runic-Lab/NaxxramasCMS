HomeView = require "applications.modules.home.view.index"

class HomeController extends System.BaseController
    index: (application) =>
        application.locals = {
            title: "Welcome to NaxxramasCMS"
            message: "Hello from the home controller"
            current_time: os.date "%Y-%m-%d %H:%M:%S"
        }

        return @render_view HomeView

controller = HomeController!
return {
    index: (application) ->
        controller\index application
}