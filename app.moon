---
-- Require LuaRocks / lapis packages
lapis = require "lapis"
lfs = require "lfs"

---
-- Require NaxxramasCMS packages
require "system.module_loader"
require "system.base_controller"

---
-- Singleton
module_loader = System.ModuleLoader\get_instance!

---
-- Application class extending lapis.Application
-- Provides handlers for 404 and 500 errors
class Application extends lapis.Application
    ---
    -- Handler for 404 errors
    -- @return nil
    handle_404: =>
        return nil

  ---
  -- Handler for 500 errors
  -- @param err A description of the error
  -- @param trace The error trace if available
  -- @return nil
    handle_500: (err, trace) =>
        return nil

---
-- Sets up and initializes an application instance
-- @return The configured application instance
SetupApplicationInstance = ->
    application = Application!

    application\enable "etlua"
    application.html = require "lapis.html"

    module_loader\load application, "applications/modules"

    return application

SetupApplicationInstance!