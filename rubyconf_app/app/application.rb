require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    @tabs = [{ :label => "Schedule", :action => '/app', :icon => "/public/icons/signs.png"},
             { :label => "People", :action => '/app/Person', :icon => "/public/icons/signs.png", :reload => true  },
             { :label => "Map", :action => '/app', :icon => "/public/icons/signs.png" },
             { :label => "About", :action => '/app/about', :icon => "/public/icons/signs.png" }] #FIXME
    # Important to call super _after_ you define @tabs!
    super
  end
  
end
