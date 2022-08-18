import os
import sys

from m import CurseForge, utils

os.chdir(os.path.abspath(os.path.dirname(os.path.dirname(sys.argv[0]))))


def printModsTable():
    CurseForge.printModsTable(CurseForge.resloveMods(utils.readJson(os.path.abspath("modpack/manifest.json"))["files"]))


if __name__ == "__main__":
    printModsTable()
