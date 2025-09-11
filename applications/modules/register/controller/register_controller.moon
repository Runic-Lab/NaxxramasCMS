RegisterModel = require "applications.modules.register.model.register_model"

class RegisterController extends System.BaseController
    @\action "index"

    index: (application) =>
        mediator = @get_mediator!

        data = {
            hideNavigation: true
        }

        return @render_view "index"

RegisterController!\register_as "register"