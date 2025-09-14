app_respond_to = require("lapis.application").respond_to
mediator = System.ModuleMediator\get_instance!

return (self) ->

    @\match "login", "/login", app_respond_to
        GET: (app) ->
            mediator\request "login", "index", app

        POST: (app) ->
            mediator\request "login", "authenticate", app