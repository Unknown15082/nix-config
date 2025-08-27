pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    function format(fmt: string): string {
        return Qt.formatDateTime(clock.date, fmt);
    }
}
