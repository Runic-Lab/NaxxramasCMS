module "System", package.seeall
export ViewResolver

lfs = require "lfs"

class ViewResolver
    @instance = nil

    @get_instance: =>
        if not @@instance
            @@instance = ViewResolver!
        return @@instance

    new: =>
        require "system.theme_manager"
        @theme_manager = System.ThemeManager\get_instance!
        @modules_path = "applications/modules"
        @themes_path = "applications/themes"

    resolve_view: (module_name, view_name) =>
        current_theme = @theme_manager\get_current_theme!
        
        theme_view_path = "#{@themes_path}/#{current_theme}/modules/#{module_name}/#{view_name}.etlua"
        module_view_path = "#{@modules_path}/#{module_name}/view/#{view_name}.etlua"
        
        if lfs.attributes(theme_view_path)
            return "#{@themes_path}.#{current_theme}.modules.#{module_name}.#{view_name}"
        elseif lfs.attributes(module_view_path)
            return "#{@modules_path}.#{module_name}.view.#{view_name}"
        else
            error "View not found: #{module_name}/#{view_name}"

    view_exists: (module_name, view_name) =>
        current_theme = @theme_manager\get_current_theme!
        
        theme_view_path = "#{@themes_path}/#{current_theme}/modules/#{module_name}/#{view_name}.etlua"
        module_view_path = "#{@modules_path}/#{module_name}/view/#{view_name}.etlua"
        
        return lfs.attributes(theme_view_path) ~= nil or lfs.attributes(module_view_path) ~= nil

    get_view_source: (module_name, view_name) =>
        current_theme = @theme_manager\get_current_theme!
        
        theme_view_path = "#{@themes_path}/#{current_theme}/modules/#{module_name}/#{view_name}.etlua"
        module_view_path = "#{@modules_path}/#{module_name}/view/#{view_name}.etlua"
        
        if lfs.attributes(theme_view_path)
            return "theme"
        elseif lfs.attributes(module_view_path)
            return "module"
        else
            return nil