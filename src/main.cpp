//
// Created by Adrien BLANCHET on 25/11/2021.
//

#include <cstdlib>

#include "switch.h"

#include "borealis.hpp"
#include "Logger.h"
#include "VersionConfig.h"

LoggerInit([]{
  Logger::setUserHeaderStr("[SimpleSwitchBrowser]");
})

int main(int argc_, char** argv_){
  LogInfo << "Software version: " << getVersionStr() << std::endl;

  LogThrowIf(R_FAILED(nsInitialize()), "Can't initialize ns services.");

  // Set log level
  brls::Logger::setLogLevel(brls::LogLevel::INFO);

  LogThrowIf(not brls::Application::init(), "Can't initialize borealis.")

  brls::Application::createWindow("SimpleSwitchBrowser");

  // Have the application register an action on every activity that will quit when you press BUTTON_START
  brls::Application::setGlobalQuit(true);

  while( brls::Application::mainLoop() );

  nsExit();
  return EXIT_SUCCESS;
}