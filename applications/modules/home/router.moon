app_respond_to = require("lapis.application").respond_to

controller = require "applications.modules.home.controller.home_controller"

--- Declares routes for the `home` module.
-- Mounts the `home_controller` controller on the root `/` of the module.
-- @param self Lapis Application Instance, used to declare routes via `@\match`.
-- @see applications.modules.home.controller.home_controller
return (self) -> 
    @\match "/", app_respond_to {
        GET: controller.index
    }