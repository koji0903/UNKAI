require 'capybara-webkit'

browser = Capybara::Webkit::Driver.new('web_capture').browser
#browser.visit 'http://www.pxt.jp/'
browser.visit 'http://today3.aso.ne.jp/ImageViewer?Resolution=640x480&Quality=Clarity&Size=STD&PresetOperation=Move&Data=0&Frame2=PanTilt&Type=&Language=1&RPeriod=0&Sound=Enable'
browser.render('pxt.png', 1024, 650)

