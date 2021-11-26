//
// Created by Adrien BLANCHET on 26/11/2021.
//

#ifndef SIMPLESWITCHBROWSER_BROWSERAPP_H
#define SIMPLESWITCHBROWSER_BROWSERAPP_H


class BrowserApp {

public:
  BrowserApp();
  virtual ~BrowserApp();

  void reset();
  void initialize();

  void run();

protected:
  void initializeApplet();
  void initializeBorealis();

private:
  bool _isInitialized_{false};

};


#endif //SIMPLESWITCHBROWSER_BROWSERAPP_H
