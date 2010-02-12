require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    @tabs = [{ :label => "Schedule", :action => '/app', :icon => "/public/icons/calendar.png"},
             { :label => "People", :action => '/app/Person', :icon => "/public/icons/walk.png", :reload => true  },
             { :label => "Map", :action => '/app/Person/map', :icon => "/public/icons/signs.png", :reload => true },
             { :label => "About", :action => '/app/Person/about', :icon => "/public/icons/weather.png" }] #FIXME
    # Important to call super _after_ you define @tabs!
    super
    
    @default_menu = { "Schedule" => "/app", 
                          "People" => "/app/Person", 
                          "Map" => "/app/Person/map", 
                          "About" => "/app/about",
                          "Close" => :close }
  end
  
end
