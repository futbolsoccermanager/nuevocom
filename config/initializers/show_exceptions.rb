# config/initializers/show_exceptions.rb
require 'action_dispatch/middleware/show_exceptions'

module ActionDispatch
  class ShowExceptions
    private
      unless Rails.application.config.consider_all_requests_local
        def render_exception_with_template(env, exception)
            # Add the exception object to the env to be able to be used inside the ErrorsController action.
            # This way, accessing the env through #ErrorsController#action_name#request#env['nostra_added_exception'] or other methods of
            # the request object in the controller action, we can log precise information about the error and
            # display more accurate information about the error to the user in the error's corresponding view.
            env['topgol_added_exception'] = exception
            body = ErrorsController.action(ActionDispatch::ExceptionWrapper.rescue_responses[exception.class.name]).call(env)
            body
        rescue
            render_exception_without_template(env, exception)
        end

        alias_method_chain :render_exception, :template
      end
  end
end