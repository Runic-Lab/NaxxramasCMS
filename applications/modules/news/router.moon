app_respond_to = require("lapis.application").respond_to
mediator = System.ModuleMediator\get_instance!

return (self) ->

    @\match "news_index", "/news", app_respond_to
        GET: (app) ->
            mediator\request "news", "index", app

    @\match "news_detail", "/news/:slug", app_respond_to
        GET: (app) ->
            mediator\request "news", "detail", app
