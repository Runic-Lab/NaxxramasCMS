app_respond_to = require("lapis.application").respond_to

controller = require "applications.modules.news.controller.news_controller"

return (self) -> 
    @\match "/news", app_respond_to {
        GET: controller.index
    }