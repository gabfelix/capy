#pragma once

#include "QtWidgets/qpushbutton.h"
#include "QtWidgets/qwidget.h"
#include <QtWidgets/QPushButton>
#include <cstdio>

class CapyWindow : public QWidget {
  Q_OBJECT
public:
  explicit CapyWindow(QWidget *parent = 0) {
    setFixedSize(800, 600);
    m_button = new QPushButton("Hello world", this);
    m_button->setGeometry(10, 10, 80, 30);

    printf("Executing my window!\n");
  };

private:
  QPushButton *m_button;
};
