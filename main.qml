/*
 * Copyright (C) 2026 Gabriel Felix
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.folderlistmodel

Window {
    id: root
    width: 800
    height: 600
    visible: true
    title: "Capy"

    // Always initialize with a valid resolved file URL
    property url currentPath: Qt.resolvedUrl("file:///home")

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        RowLayout {
            Layout.fillWidth: true

            Button {
                text: "Up"
                enabled: folderModel.parentFolder.toString() !== ""
                onClicked: {
                    if (folderModel.parentFolder.toString() !== "") {
                        root.currentPath = folderModel.parentFolder;
                    }
                }
            }

            TextField {
                id: pathField
                Layout.fillWidth: true
                text: root.currentPath.toString().replace("file://", "")

                onAccepted: {
                    let formattedPath = text.trim();
                    if (!formattedPath.startsWith("file://")) {
                        formattedPath = "file://" + formattedPath;
                    }
                    root.currentPath = Qt.resolvedUrl(formattedPath);

                    listView.forceActiveFocus();
                }
            }
        }

        FolderListModel {
            id: folderModel
            folder: root.currentPath
            showDirsFirst: true
            showDotAndDotDot: false
            showHidden: true
            nameFilters: ["*"]
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: folderModel

            // Enable keyboard focus
            focus: true

            // Standard Navigation Keys
            Keys.onReturnPressed: openCurrentItem()
            Keys.onEnterPressed: openCurrentItem()
            Keys.onRightPressed: openCurrentItem()
            Keys.onLeftPressed: goUp()

            // Vim and Backspace Keys
            Keys.onPressed: event => {
                if (event.key === Qt.Key_J) {
                    listView.incrementCurrentIndex();
                    event.accepted = true;
                } else if (event.key === Qt.Key_K) {
                    listView.decrementCurrentIndex();
                    event.accepted = true;
                } else if (event.key === Qt.Key_H || event.key === Qt.Key_Backspace) {
                    goUp();
                    event.accepted = true;
                } else if (event.key === Qt.Key_L) {
                    openCurrentItem();
                    event.accepted = true;
                }
            }

            function openCurrentItem() {
                // Prevent out-of-bounds access if the folder is empty
                if (currentIndex < 0 || currentIndex >= count)
                    return;

                // Read data directly from the model using the current index
                let isDir = folderModel.get(currentIndex, "fileIsDir");
                let url = folderModel.get(currentIndex, "fileUrl");
                let path = folderModel.get(currentIndex, "filePath");

                if (isDir) {
                    let targetUrl = url.toString();
                    if (!targetUrl.endsWith("/")) {
                        targetUrl += "/";
                    }
                    root.currentPath = Qt.resolvedUrl(targetUrl);
                } else {
                    console.log("File selected:", path);
                }
            }

            function goUp() {
                if (folderModel.parentFolder.toString() !== "") {
                    root.currentPath = folderModel.parentFolder;
                }
            }

            delegate: ItemDelegate {
                required property int index
                required property string fileName
                required property url fileUrl
                required property string filePath
                required property bool fileIsDir

                width: ListView.view.width
                text: fileName + (fileIsDir ? "/" : "")

                // Visual feedback for the currently selected item
                highlighted: ListView.isCurrentItem

                onClicked: {
                    // Force focus back to list and update index
                    listView.forceActiveFocus();
                    listView.currentIndex = index;

                    if (fileIsDir) {
                        let targetUrl = fileUrl.toString();
                        if (!targetUrl.endsWith("/")) {
                            targetUrl += "/";
                        }
                        root.currentPath = Qt.resolvedUrl(targetUrl);
                    } else {
                        console.log("File selected:", filePath);
                    }
                }
            }
        }
    }
}
