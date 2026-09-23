#include "capy.hpp"
#include "QtWidgets/qapplication.h"
#include <stdio.h>

#define PROJECT_NAME "capy"

int main(int argc, char **argv) {
  if (argc != 1) {
    printf("%s takes no arguments.\n", argv[0]);
    return 1;
  }
  QApplication a(argc, argv);
  CapyWindow w;

  w.show();
  return a.exec();
}
