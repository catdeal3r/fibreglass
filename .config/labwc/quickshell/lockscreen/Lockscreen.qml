import Quickshell
import Quickshell.Io
import Quickshell.Wayland

ShellRoot {

	LockContext {
		id: lockContext

		onUnlocked: {
			// Unlock the screen before exiting, or the compositor will display a
			// fallback lock you can't interact with.
			loader.item.locked = false;
		}
	}
		
	LazyLoader {
		id: loader
			
		WlSessionLock {
			id: lock
			locked: true
			
			onLockedChanged: {
                if (!locked)
                    loader.active = false;
            }
			
			WlSessionLockSurface {
				LockSurface {
					anchors.fill: parent
					context: lockContext
				}
			}
		}
	}
	
	IpcHandler {
        target: "lock"

        function lock(): void {
            loader.activeAsync = true;
        }

        function unlock(): void {
            loader.item.locked = false;
        }

        function isLocked(): bool {
            return loader.active;
        }
    }
}
