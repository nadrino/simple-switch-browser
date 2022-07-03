//
// Created by Adrien BLANCHET on 26/11/2021.
//

#ifndef SIMPLESWITCHBROWSER_BROWSERAPP_H
#define SIMPLESWITCHBROWSER_BROWSERAPP_H

#include "BrowserFrame.h"

class BrowserApp {

public:
  BrowserApp();
  virtual ~BrowserApp();

  void initialize();
  void run();

};


#endif //SIMPLESWITCHBROWSER_BROWSERAPP_H
