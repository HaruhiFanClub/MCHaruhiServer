import os
import sys

from m import utils
from m.Modpack import Modpack
from m.Pack import Pack

os.chdir(os.path.abspath(os.path.dirname(os.path.dirname(sys.argv[0]))))

ID = "haruhiserver"
NAME = "HaruhiServer"
VERSION = utils.getVersion()
with open(os.path.join(utils.getTempDir(), "version.txt"), "w", encoding="utf-8") as f:
    f.write(VERSION)

ROOT_DIR = os.path.abspath("./")
TEMP_DIR = utils.getTempDir()

BUILD_DIR = utils.getDir(os.path.abspath("build"))


def buildPack(name: str, temp: bool = False):
    print(f"[Pack] Building pack: {name}")
    zipFile = Pack(os.path.abspath(f"packs/{name}"), f"{ID}-{name}pack", VERSION).build(TEMP_DIR if temp else BUILD_DIR)
    print(f"[Pack] Build complete: '{zipFile}'")
    return zipFile


if __name__ == "__main__":
    buildPack("data")
    modpack = Modpack(os.path.abspath("modpack"), "HaruhiServerModpack", VERSION)
    modpack.addResourcepack(buildPack("resource", True))
    modpack.build(BUILD_DIR)
