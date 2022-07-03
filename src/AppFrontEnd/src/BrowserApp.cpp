//
// Created by Adrien BLANCHET on 26/11/2021.
//

#include "switch.h"

#include "iostream"

#include "Logger.h"
#include "borealis.hpp"

#include "BrowserApp.h"

LoggerInit([]{
  Logger::setUserHeaderStr("[BrowserApp]");
});

BrowserApp::BrowserApp() = default;
BrowserApp::~BrowserApp() = default;

void BrowserApp::initialize() {

}

void BrowserApp::run() {
  LogInfo << "Running BrowserApp..." << std::endl;
  brls::Application::init("SimpleSwitchBrowser");


  auto* browserFrame = new BrowserFrame{false, false};
  brls::Application::pushView(browserFrame);
  browserFrame->registerAction("", brls::Key::PLUS, []{return true;}, true);
  browserFrame->updateActionHint(brls::Key::PLUS, ""); // make the change visible

  while( brls::Application::mainLoop() );
}




