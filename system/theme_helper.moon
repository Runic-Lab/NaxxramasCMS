module "System", package.seeall
export ThemeHelper

class ThemeHelper
    @get_view_path: (module_name, view_name) =>
        view_resolver = System.ViewResolver\get_instance!
        return view_resolver\resolve_view(module_name, view_name)
    
    @resolve: (module_name, view_name) =>
        return @@get_view_path(module_name, view_name)