lapis = require "lapis"
lfs = require "lfs"

require "system.module_loader"
require "system.base_controller"
require "system.module_mediator"

module_loader = System.ModuleLoader\get_instance!

class Application extends lapis.Application
    handle_404: => nil
    handle_500: (err, trace) => nil

SetupApplicationInstance = ->
    application = Application!
    application\enable "etlua"

    application.html = require "lapis.html"
    application.layout = require "applications.themes.default.layout"
    
    module_loader\load application, "applications/modules"
    return application

SetupApplicationInstance!