#include "qurl.h"
#include <QGuiApplication>
#include <QtQml/QQmlApplicationEngine>

#define PROJECT_NAME "capy"

int main(int argc, char **argv) {
  QGuiApplication app(argc,argv);
  QQmlApplicationEngine engine;
  engine.load(QUrl("qrc:/main.qml"));

  if (engine.rootObjects().isEmpty()) {
      return -1;
  }

  return app.exec();
}
