LoginModel = require "applications.modules.login.model.login_model"

class LoginController extends System.BaseController
    @\action "index"

    index: (application) =>
        mediator = @get_mediator!

        return @render_view "index"

LoginController!\register_as "login"