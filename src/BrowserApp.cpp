//
// Created by Adrien BLANCHET on 26/11/2021.
//

#include "switch.h"

#include "Logger.h"
#include "borealis.hpp"

#include "BrowserApp.h"

LoggerInit([]{
  Logger::setUserHeaderStr("[BrowserApp]");
})

BrowserApp::BrowserApp() {}
BrowserApp::~BrowserApp() {
  this->reset();
}

void BrowserApp::reset() {
  if( _isInitialized_ ){
    _isInitialized_ = false;
    nsExit();
  }
}
void BrowserApp::initialize() {
  this->initializeApplet();
  this->initializeBorealis();

  _isInitialized_ = true;
}
void BrowserApp::initializeApplet() {
  LogThrowIf(R_FAILED(nsInitialize()), "Can't initialize ns services.");
}
void BrowserApp::initializeBorealis(){
  // Set log level
  brls::Logger::setLogLevel(brls::LogLevel::INFO);
  LogThrowIf(not brls::Application::init(), "Could not initialize borealis.")
}

void BrowserApp::run() {

  brls::Application::createWindow("SimpleSwitchBrowser");

  // Have the application register an action on every activity that will quit when you press BUTTON_START
  brls::Application::setGlobalQuit(true);

  while( brls::Application::mainLoop() );

}




