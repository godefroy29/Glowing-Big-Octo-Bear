# encoding: UTF-8

##
# Auteur Pierre Jacoboni
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

require 'gtk2'

class Builder < Gtk::Builder
  
  def initialize 
    super()
    self.add_from_file(__FILE__.sub(".rb",".glade"))
    
    self['window1'].set_window_position Gtk::Window::POS_CENTER
    self['window1'].signal_connect('destroy') { Gtk.main_quit }
    self['window1'].show_all
    
    # Creation d'une variable d'instance par composant glade
    self.objects.each() { |p|
       instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name])
     }

     self.connect_signals{ |handler| 
        puts handler
        method(handler) 
      }
      window.signal_connect('destroy'){
        Gtk.main_quit
      }
  end

end