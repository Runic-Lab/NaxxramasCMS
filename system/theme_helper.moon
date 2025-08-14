module "System", package.seeall
export ThemeHelper

class ThemeHelper
    @view_resolver = nil
    
    @init: =>
        require "system.view_resolver"
        @@view_resolver = System.ViewResolver\get_instance!

    @theme_render: (module_name, view_name, locals = {}) =>
        unless @@view_resolver
            @@init!
        
        view_path = @@view_resolver\resolve_view(module_name, view_name)
        return require("lapis.etlua").render_file(view_path, locals)