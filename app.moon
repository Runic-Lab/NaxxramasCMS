lapis = require "lapis"
lfs = require "lfs"

require "system.module_loader"

class Application extends lapis.Application
  new: =>
    @\enable "etlua"
    @.html = require "lapis.html"
    System.ModuleLoader.load @, "applications/modules"
    super!