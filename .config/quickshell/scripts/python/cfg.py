from wayfire import WayfireSocket
import sys

sock = WayfireSocket()

monitor_str = sys.argv[1]
monitor = int(monitor_str)

opt = sock.wset_info(monitor)
print(f"{opt}")
