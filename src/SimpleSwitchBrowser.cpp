//
// Created by Adrien BLANCHET on 25/11/2021.
//


#include "BrowserApp.h"
#include "VersionConfig.h"

#include "Logger.h"

#include "switch.h"

#include "iostream"
#include "logger.hpp"
#include <cstdlib>


LoggerInit([]{
  Logger::setUserHeaderStr("[SimpleSwitchBrowser]");
});

int main(int argc_, char** argv_){
  LogInfo << "Software version: " << VersionConfig::getVersionStr() << std::endl;

  brls::Logger::setLogLevel(brls::LogLevel::ERROR);

  BrowserApp app;
  app.initialize();
  app.run();

  nsExit();

  LogInfo << "Exit..." << std::endl;
  return EXIT_SUCCESS;
}