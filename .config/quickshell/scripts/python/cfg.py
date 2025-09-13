from wayfire import WayfireSocket
import sys

sock = WayfireSocket()

opt = sock.wset_info(1)
print(f"{opt}")
