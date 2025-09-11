app_respond_to = require("lapis.application").respond_to

mediator = System.ModuleMediator\get_instance!

return (self) ->
    @\match "home_index", "/", app_respond_to {
        GET: (app) ->
            mediator\request "home", "index", app
    }