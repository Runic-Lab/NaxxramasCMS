LoginModel = require "applications.modules.login.model.login_model"
import CaptchaService from require "applications.services.captcha"

class LoginController extends System.BaseController
    @\action "index"
    @\action "authenticate"

    index: (application) =>
        mediator = @get_mediator!

        captcha_service = CaptchaService!
        captcha_data = captcha_service\generate!

        application.hide_navigation = true
        application.captcha_id = captcha_data.id
        application.captcha_question = captcha_data.question

        return @render_view "index"

    authenticate: (application) =>
        mediator = @get_mediator!

        captcha_service = CaptchaService!

        unless captcha_service\verify(application.params.captcha_id, application.params.captcha_answer)
            captcha_data = captcha_service\generate!

            application.hide_navigation = true
            application.captcha_id = captcha_data.id
            application.captcha_question = captcha_data.question
            application.errors = {"Incorrect captcha"}

            return @render_view "index"

        application.success = "Captcha validated"
        application.hide_navigation = true
        return @render_view "index"

LoginController!\register_as "login"