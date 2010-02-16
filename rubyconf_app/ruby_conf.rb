
class RubyConf
  class << self
    def authenticate(username, password, session)
    #[... connect to backend using API and authenticate... ]
    #if success
      # will be stored these in the session encrypted
    #  session[:someprivatedata] = someprivatedata
    #end
    return true
  end
end

