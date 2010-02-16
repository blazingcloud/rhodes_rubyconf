require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'

class SettingsController < Rho::RhoController
  
  def index
    @msg = @params['msg']
    render
  end

  def login
    @msg = @params['msg']
    render :action => :login
  end
  
  def start
      @logged_in = SyncEngine::logged_in
      if @logged_in == 0
        @logged_in = SyncEngine.login("anonymous", "password", (url_for :action => :login_callback) )
      end
      WebView.navigate ( '/app' )
  end

  def login_callback
    errCode = @params['error_code'].to_i
    if errCode == 0
      # run sync if we were successful
      SyncEngine::dosync 
    end  
  end

  def do_login
    if @params['login'] and @params['password']
      begin
        SyncEngine.login(@params['login'], @params['password'], (url_for :action => :login_callback) )
        render :action => :wait
      rescue Rho::RhoError => e
        @msg = e.message
        render :action => :login
      end
    else
      @msg = Rho::RhoError.err_message(Rho::RhoError::ERR_UNATHORIZED) unless @msg && @msg.length > 0
      render :action => :login
    end
  end
  
  def logout
    SyncEngine.logout
    @msg = "You have been logged out."
    render :action => :login
  end
  
  def reset
    render :action => :reset
  end
  
  def do_reset
    Rhom::Rhom.database_full_reset
    SyncEngine.dosync
    @msg = "Database has been reset."
    redirect :action => :index, :query => {:msg => @msg}
  end
  
  def do_sync
    SyncEngine.dosync
    @msg =  "Sync has been triggered."
    redirect :action => :index, :query => {:msg => @msg}
  end
end
