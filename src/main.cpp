//
// Created by Adrien BLANCHET on 25/11/2021.
//

#include <cstdlib>

#include "switch.h"

#include "Logger.h"
#include "VersionConfig.h"

#include "BrowserApp.h"


LoggerInit([]{
  Logger::setUserHeaderStr("[SimpleSwitchBrowser]");
})


int main(int argc_, char** argv_){
  LogInfo << "Software version: " << getVersionStr() << std::endl;

  BrowserApp app;
  app.initialize();
  app.run();

  return EXIT_SUCCESS;
}