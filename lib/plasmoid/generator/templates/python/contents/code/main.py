from PyQt4.QtCore import Qt
from PyKDE4.plasma import Plasma
from PyKDE4 import plasmascript
 
class <%= options[:project_name].capitalize %>(plasmascript.Applet):
    def __init__(self,parent,args=None):
        plasmascript.Applet.__init__(self,parent)
 
    def init(self):
        self.setHasConfigurationInterface(False)
        self.resize(125, 125)
        self.setAspectRatioMode(Plasma.Square)
 
    def paintInterface(self, painter, option, rect):
        painter.save()
        painter.setPen(Qt.white)
        painter.drawText(rect, Qt.AlignVCenter | Qt.AlignHCenter, "Hello Python!")
        painter.restore()
 
def CreateApplet(parent):
	return <%= options[:project_name].capitalize %>(parent)

