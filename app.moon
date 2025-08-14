lapis = require "lapis"
lfs = require "lfs"

require "system.module_loader"
require "system.base_controller"
require "system.module_mediator"
require "system.theme_manager"
require "system.view_resolver"
require "system.theme_helper"

module_loader = System.ModuleLoader\get_instance!
theme_manager = System.ThemeManager\get_instance!

class Application extends lapis.Application
    handle_404: => nil
    handle_500: (err, trace) => nil

SetupApplicationInstance = ->
    application = Application!
    application\enable "etlua"

    application.html = require "lapis.html"
    application.layout = require theme_manager\get_layout_path!
    
    module_loader\load application, "applications/modules"
    return application

SetupApplicationInstance!