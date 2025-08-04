module "System", package.seeall
export ModuleLoader

ModuleLoader = {}

--- Dynamically loads all modules (features) of the application.
-- Searches each subfolder in `path` for a `router.lua` file.
-- If found, the module is loaded and its router is executed with the current application instance.
-- @param applications Lapis Application Instance, passed so that each module can attach its routes to it.
-- @param path string Path to the folder containing the modules to be loaded.
-- @raise string If a module does not contain a router or fails to load.
ModuleLoader.load = (application, path) ->
    for element in lfs.dir path
        if element != "." and element != ".."
            full_path = "#{path}/#{element}"
            attributes = lfs.attributes full_path
            if attributes.mode == "directory"
                router_path = "#{full_path}/router.lua"
                if lfs.attributes router_path
                    success, router = pcall require, "applications.modules.#{element}.router"
                    if success and router
                        router application
                    else
                        error "Failed to load module: #{element}"
                else
                    error "Router not found for module: #{element}"