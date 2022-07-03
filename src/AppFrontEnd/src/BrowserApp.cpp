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
  brls::Application::init("SimpleSwitchBrowser");
  while( brls::Application::mainLoop() );
}




