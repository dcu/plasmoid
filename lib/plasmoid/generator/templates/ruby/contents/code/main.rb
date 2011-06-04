require 'plasma_applet'

Qt::WebSettings::globalSettings.setAttribute(Qt::WebSettings::PluginsEnabled, true)
Qt::WebSettings::globalSettings.setAttribute(Qt::WebSettings::JavascriptEnabled, true)

module <%= options[:project_name].capitalize %>
  class Main < PlasmaScripting::Applet
    def initialize(parent)
      super parent
    end

    private
    
    def init
      self.has_configuration_interface = false
      self.aspect_ratio_mode = Plasma::IgnoreAspectRatio

      resize 380, 500
      
      @layout = Qt::GraphicsLinearLayout.new Qt::Vertical, self
      self.layout = @layout

      @web_page = Plasma::WebView.new(self)

      #set white BG to ignore system palette
      @web_page.page.setPalette Qt::Palette.new(Qt::Color.new 255,255,255)	
      @layout.add_item @web_page

      @web_page.url = KDE::Url.new("http://www.kde.org")
    end

    public
  end
end
