module "System", package.seeall
export BaseController

class BaseController
    @action_registry = {}
    
    new: =>
        @_mediator = nil
    
    get_mediator: =>
        unless @_mediator
            @_mediator = System.ModuleMediator\get_instance!
        return @_mediator
    
    @action: (method_name) =>
        class_name = @.__name
        @@action_registry[class_name] or= {}
        
        for existing_action in *@@action_registry[class_name]
            return if existing_action == method_name
        
        table.insert @@action_registry[class_name], method_name
        return @
    
    register_as: (module_name, actions = nil) =>
        mediator = @get_mediator!
        class_name = @@.__name
        
        registered_actions = @@action_registry[class_name] or {}
        actions_to_register = actions or registered_actions
        
        return @ unless #actions_to_register > 0
        
        handlers = {}
        for action in *actions_to_register
            if @[action] and type(@[action]) == "function"
                method = @[action]
                handlers[action] = (application, params) ->
                    method @, application, params
        
        mediator\register_module module_name, handlers if next(handlers)
        return @
    
    validate_params: (params, rules) =>
        errors = {}
        params or= {}
        
        for param_name, rule_config in pairs rules
            value = params[param_name]
            
            if rule_config.required and (not value or value == "")
                errors[param_name] = rule_config.required_message or "#{param_name} is required"
                continue
            
            continue unless value and value != ""
            
            str_value = tostring(value)
            
            if rule_config.type
                actual_type = type(value)
                if actual_type != rule_config.type
                    errors[param_name] = rule_config.type_message or "#{param_name} must be of type #{rule_config.type}"
                    continue
            
            str_len = #str_value
            
            if rule_config.min_length and str_len < rule_config.min_length
                errors[param_name] = rule_config.min_length_message or 
                    "#{param_name} must be at least #{rule_config.min_length} characters"

            if rule_config.max_length and str_len > rule_config.max_length
                errors[param_name] = rule_config.max_length_message or 
                    "#{param_name} must be no more than #{rule_config.max_length} characters"

            if rule_config.pattern and not string.match(str_value, rule_config.pattern)
                errors[param_name] = rule_config.pattern_message or 
                    "#{param_name} has invalid format"
            
            if rule_config.min_value or rule_config.max_value
                num_value = tonumber(value)
                if num_value
                    if rule_config.min_value and num_value < rule_config.min_value
                        errors[param_name] = rule_config.min_value_message or 
                            "#{param_name} must be at least #{rule_config.min_value}"

                    if rule_config.max_value and num_value > rule_config.max_value
                        errors[param_name] = rule_config.max_value_message or 
                            "#{param_name} must be no more than #{rule_config.max_value}"
                else
                    errors[param_name] = "#{param_name} must be a valid number"
            
            if rule_config.validator and type(rule_config.validator) == "function"
                is_valid, custom_message = rule_config.validator(value)
                unless is_valid
                    errors[param_name] = custom_message or "#{param_name} is invalid"

            clean_url = (url) ->
                return "" unless url and type(url) = "string"
                url = url\gsub(" ", "-")
                cleaned = url\gsub("[^%w%-%.%/_]", "")

            if rule.config.url and type(rule_config.url) == "function"
                raw_url = tostring(value)
                clean_url_value = clean_url(raw_url)

                if clean_url_value == ""
                    errors[param_name] = "url invalide"
                else

                    is_valid, custom_message = rule_config.url(clean_url_value)
                    unless is_valid
                        errors[param_name] = custom_message or "#{param_name} is invalid"

        success = next(errors) == nil
        return success, errors

    get_module_name: =>
        class_name = @@.__name
        unless class_name
            error "Could not determine module name"
        return class_name\gsub("Controller", "")\lower!
    
    render_view: (view_name) =>
        unless view_name and type(view_name) == "string"
            error "view_name (string) is required"
        
        module_name = @get_module_name!
        view_resolver = System.ViewResolver\get_instance!
        resolved_view = view_resolver\resolve_view module_name, view_name
        view_module = require resolved_view
        return { render: view_module }
    
    redirect: (url, status = 302) =>
        return { redirect: url, status: status }