import os
import sys
from ast import If
from turtle import down
from typing import List

from genericpath import exists
from m import CurseForge, utils
from m.CurseForge import ModInfo

os.chdir(os.path.abspath(os.path.dirname(os.path.dirname(sys.argv[0]))))


def readManifest():
    defaultFile = os.path.abspath("modpack/manifest.json")
    try:
        fileArg = os.path.abspath(sys.argv[2])
        file = fileArg if (os.path.exists(fileArg) and os.path.isfile(fileArg)) else defaultFile
    except:
        file = defaultFile
    return utils.readJson(file)


def printModsTable():
    CurseForge.printModsTable(CurseForge.resloveMods(readManifest()["files"]))


def downloadMods():
    destDir = utils.getDir(os.path.join(utils.getTempDir(), "mods"))
    mods: List[ModInfo] = readManifest()["files"]

    # def sha1()

    count = len(mods)
    for i, mod in enumerate(mods):
        _p = f"[{i}/{count}]"

        if not ("fileName" in mod.keys() and "fileSHA1" in mod.keys() and "downloadUrl" in mod.keys()):
            mod = CurseForge.resloveModInfo(mod, _p)

        fileName = mod["fileName"]
        sha1 = mod["fileSHA1"]

        file = os.path.join(destDir, fileName)

        if os.path.exists(file):
            if utils.sha1(file) == sha1:
                print(f"{_p} File '{fileName}' already exists")
                continue
            else:
                print(f"{_p} File '{fileName}' checksum did not match, downloading")

        _c = 0
        while True:
            r = CurseForge.SESSION.get(mod["downloadUrl"], proxies=CurseForge.PROXY, verify=False)
            r.raise_for_status()
            with open(file, "wb") as f:
                f.write(r.content)
            if utils.sha1(file) == sha1:
                print(f"{_p} File '{fileName}' download complete")
                break
            else:
                print(f"{_p} File '{fileName}' checksum did not match, downloading")
                _c += 1
            if _c > 3:
                print(f"{_p} File '{fileName}' download failed")
                break


if __name__ == "__main__":
    match sys.argv[1]:
        case "printModsTable":
            printModsTable()
        case "downloadMods":
            downloadMods()
