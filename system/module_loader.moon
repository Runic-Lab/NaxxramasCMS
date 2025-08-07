module "System", package.seeall
export ModuleLoader

class ModuleLoader
    @instance = nil

    @get_instance: =>
        if not @@instance
            @@instance = ModuleLoader!
        return @@instance

    load: (application, path) =>
        @load_controllers path
        @load_routers application, path

    load_controllers: (path) =>
        for element in lfs.dir path
            continue if element == "." or element == ".."

            full_path = "#{path}/#{element}"
            attributes = lfs.attributes full_path

            continue unless attributes and attributes.mode == "directory"

            controller_path = "#{full_path}/controller"
            controller_attributes = lfs.attributes controller_path
            
            if controller_attributes and controller_attributes.mode == "directory"
                @load_module_controller controller_path, element

    load_module_controller: (controller_path, module_name) =>
        main_controller_file = "#{module_name}_controller.lua"
        controller_file_path = "#{controller_path}/#{main_controller_file}"
        
        if lfs.attributes controller_file_path
            controller_path_sanitized = controller_file_path\gsub("[/\\]", ".")\gsub("%.lua$", "")
            
            success, controller_module = pcall require, controller_path_sanitized
            
            unless success
                error "Failed to load controller for module #{module_name}: #{controller_module}"

    load_routers: (application, path) =>        
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
                error "Failed to load router for module: #{element}"