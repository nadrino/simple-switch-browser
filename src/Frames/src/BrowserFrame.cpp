//
// Created by Adrien BLANCHET on 03/07/2022.
//

#include "BrowserFrame.h"
#include "VersionConfig.h"

#include "Logger.h"
#include "GenericToolbox.h"

LoggerInit([]{
  Logger::setUserHeaderStr("[BrowserFrame]");
});

BrowserFrame::BrowserFrame(bool padLeft, bool padRight) : brls::AppletFrame(padLeft, padRight) {
  LogInfo << __METHOD_NAME__ << std::endl;

  this->setTitle("SimpleSwitchBrowser");
  this->setFooterText(VersionConfig::getVersionStr());
  this->setIcon("romfs:/images/icon.jpg"); // present in "resources" folder

  LogInfo << __METHOD_NAME__ << std::endl;
}

bool BrowserFrame::onCancel() {
  bool onCancel = AppletFrame::onCancel();

  auto* lastFocus = brls::Application::getCurrentFocus();
  if(lastFocus == brls::Application::getCurrentFocus()){
    brls::Application::quit();
  }

  return onCancel;
}

