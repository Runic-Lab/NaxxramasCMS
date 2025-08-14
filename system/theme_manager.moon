module "System", package.seeall
export ThemeManager

lfs = require "lfs"

class ThemeManager
    @instance = nil

    @get_instance: =>
        if not @@instance
            @@instance = ThemeManager!
        return @@instance

    new: =>
        config = require "lapis.config"
        @current_theme = config.get!.theme or "default"
        @themes_path = "applications/themes"

    set_theme: (theme_name) =>
        theme_path = "#{@themes_path}/#{theme_name}"
        if lfs.attributes(theme_path) and lfs.attributes(theme_path).mode == "directory"
            @current_theme = theme_name
            return true
        return false

    get_current_theme: =>
        return @current_theme

    get_layout_path: =>
        return "#{@themes_path}.#{@current_theme}.layout"

    theme_exists: (theme_name) =>
        theme_path = "#{@themes_path}/#{theme_name}"
        attributes = lfs.attributes(theme_path)
        return attributes and attributes.mode == "directory"

    get_available_themes: =>
        themes = {}
        return themes unless lfs.attributes(@themes_path)
        
        for theme_name in lfs.dir(@themes_path)
            continue if theme_name == "." or theme_name == ".."
            theme_path = "#{@themes_path}/#{theme_name}"
            attributes = lfs.attributes(theme_path)
            if attributes and attributes.mode == "directory"
                table.insert(themes, theme_name)
        
        return themes