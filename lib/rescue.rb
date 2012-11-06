ActionDispatch::ExceptionWrapper.rescue_responses.update('CanCan::AccessDenied' => :cancan_access_denied)
ActionDispatch::ExceptionWrapper.rescue_responses.update('ActiveResource::ResourceNotFound' => :system_error)
ActionDispatch::ExceptionWrapper.rescue_responses.update('ActiveResource::TimeoutError' => :system_error)
ActionDispatch::ExceptionWrapper.rescue_responses.update('Timeout::Error' => :system_error)
