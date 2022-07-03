//
// Created by Adrien BLANCHET on 03/07/2022.
//

#ifndef SIMPLESWITCHBROWSER_BROWSERFRAME_H
#define SIMPLESWITCHBROWSER_BROWSERFRAME_H

#include "borealis.hpp"

class BrowserFrame : public brls::AppletFrame {

public:
  BrowserFrame(bool padLeft, bool padRight);

  bool onCancel() override;

};


#endif //SIMPLESWITCHBROWSER_BROWSERFRAME_H
