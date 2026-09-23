/*
 *   Copyright (C) 2026 Gabriel Felix
 *
 *    This program is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

#include "qurl.h"
#include <QGuiApplication>
#include <QtQml/QQmlApplicationEngine>

#define PROJECT_NAME "capy"

int main(int argc, char **argv) {
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;
  engine.load(QUrl("qrc:/main.qml"));

  if (engine.rootObjects().isEmpty()) {
    return -1;
  }

  return app.exec();
}
