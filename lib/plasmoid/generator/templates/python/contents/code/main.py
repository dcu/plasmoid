# -*- coding: utf-8 -*-
from PyQt4.QtCore import *
from PyQt4.QtGui import *
from PyKDE4.plasma import Plasma
from PyKDE4 import plasmascript
from PyKDE4.kdecore import *
from PyKDE4.kdeui import *

class <%= options[:project_name].capitalize %>(plasmascript.Applet):
	def __init__(self,parent,args=None):
		plasmascript.Applet.__init__(self,parent)

	def init(self):
		self.setHasConfigurationInterface(False)
		self.resize(375, 525)
		self.setAspectRatioMode(Plasma.IgnoreAspectRatio)

		self.layout = QGraphicsLinearLayout(Qt.Horizontal, self.applet)
		self.webView = Plasma.WebView(self.applet)
		self.webView.setUrl(KUrl("http://www.kde.org"))

		self.layout.addItem(self.webView)
		self.setLayout(self.layout)

def CreateApplet(parent):
	return <%= options[:project_name].capitalize %>(parent)