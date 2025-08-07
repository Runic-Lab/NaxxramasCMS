module "System", package.seeall
export ModuleLoader

class ModuleLoader
    @instance = nil

    @get_instance: =>
        if not @@instance
            @@instance = ModuleLoader!
        return @@instance

    load: (application, path) =>
        for element in lfs.dir path
            continue if element == "." or element == ".."

            full_path = "#{path}/#{element}"
            attributes = lfs.attributes full_path

            continue unless attributes and attributes.mode == "directory"

            router_path = "#{full_path}/router.lua"
            unless lfs.attributes router_path
                error "Router not found for module: #{element}"

            router_path_sanitized = router_path\gsub("[/\\]", ".")\gsub("%.lua$", "")
            success, router = pcall require, router_path_sanitized

            if success and type(router) == "function"
                router application
            else
                error "Failed to load module: #{element}"