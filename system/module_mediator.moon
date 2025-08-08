module "System", package.seeall
export ModuleMediator

class ModuleMediator
    @instance = nil
    
    new: =>
        @handlers = {}
        @modules = {}
    
    @get_instance: =>
        unless @@instance
            @@instance = ModuleMediator!
        return @@instance
    
    register_module: (module_name, module_handlers) =>
        @modules[module_name] = module_handlers
        
        for action, handler in pairs module_handlers
            key = "#{module_name}.#{action}"
            @handlers[key] = handler
    
    request: (module_name, action, application, params = {}) =>
        key = "#{module_name}.#{action}"
        handler = @handlers[key]
        
        unless handler
            return {
                status: 404
                json: { error: "Handler not found: #{key}" }
            }
        
        success, result = pcall handler, application, params
        
        unless success
            return {
                status: 500
                json: { error: "Handler execution failed: #{result}" }
            }
        
        return result
    
    has_handler: (module_name, action) =>
        key = "#{module_name}.#{action}"
        return @handlers[key] != nil
    
    get_registered_modules: =>
        modules = {}
        for name, _ in pairs @modules
            table.insert modules, name
        return modules
    
    get_module_actions: (module_name) =>
        actions = {}
        module_handlers = @modules[module_name]
        
        if module_handlers
            for action, _ in pairs module_handlers
                table.insert actions, action
        
        return actions