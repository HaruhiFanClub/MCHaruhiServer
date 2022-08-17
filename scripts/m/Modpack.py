import json
import os
import shutil
import threading
from typing import Dict, List, Optional, TypedDict

import requests
import urllib3
from m import utils


class Modpack():

    def __init__(self, path: str, name: str, version: str) -> None:
        self.path = path
        self.name = name
        self.version = version
        self.fullname = f"{name}-{version}"
        self.temp = utils.copySrcToTemp(self.path, self.fullname)
        self.manifest = dict(utils.readJson(os.path.join(self.temp, "manifest.json")))
        self.overrides = utils.getDir(os.path.join(self.temp, "overrides"))

    def _writeManifest(self) -> None:
        utils.writeJson(os.path.join(self.temp, "manifest.json"), self.manifest)

    def _replaceVersion(self) -> None:
        self.manifest["version"] = self.version

    def _resloveMods(self) -> None:
        resloveMods(self.manifest["files"])

    def addResourcepack(self, pack: str):
        return shutil.copy(pack, utils.getDir(os.path.join(self.overrides, "resourcespack")))

    def build(self, outputDir: str) -> str:
        self._replaceVersion()
        self._resloveMods()
        self._writeManifest()
        return utils.zip(self.temp, os.path.join(outputDir, f"{self.fullname}.zip"))


class ModInfo(TypedDict):
    projectID: int
    fileID: int
    required: Optional[bool]
    projectName: Optional[str]
    fileSHA1: Optional[str]
    fileName: Optional[str]
    fileLength: Optional[int]
    fileDate: Optional[str]


def resloveMods(mods: List[ModInfo]):
    p = 5
    count = len(mods)
    for gi, group in enumerate([mods[i:i+p] for i in range(0, len(mods), p)]):
        threads: List[threading.Thread] = []
        for i, mod in enumerate(group):
            t = threading.Thread(target=resloveModInfo, args=(mod,))
            threads.append(t)
            print(f"[{gi*p+i+1}/{count}] Resloving mod {mod['fileID']}")
        for t in threads:
            t.setDaemon(True)
            t.start()
        for t in threads:
            t.join()
        threads = []


urllib3.disable_warnings()
SESSION = requests.session()

API_BASE_URL = "https://api.curseforge.com/v1/mods"

key = os.getenv("CURSEFORGE_CORE_API_KEY")
if key is None:
    raise RuntimeError("No api key provided")
HEADERS = {"Accept": "application/json",    "x-api-key": key}

PROXY = (lambda proxy: {} if (proxy is None) else {"http": proxy, "https": proxy})(os.getenv("REQUESTS_PROXY"))


def resloveModInfo(mod: ModInfo):
    if not "required" in mod.keys():
        mod["required"] = True

    modReq = SESSION.get(f"{API_BASE_URL}/{mod['projectID']}", headers=HEADERS, proxies=PROXY, verify=False)
    modReq.raise_for_status()
    modInfo = json.loads(modReq.text)
    mod["projectName"] = modInfo["data"]["name"]

    fileReq = SESSION.get(f"{API_BASE_URL}/{mod['projectID']}/files/{mod['fileID']}", headers=HEADERS, proxies=PROXY, verify=False)
    fileReq.raise_for_status()
    fileInfo = json.loads(fileReq.text)
    mod["fileSHA1"] = fileInfo["data"]["hashes"][0]["value"]
    mod["fileName"] = fileInfo["data"]["fileName"]
    mod["fileLength"] = fileInfo["data"]["fileLength"]
    mod["fileDate"] = fileInfo["data"]["fileDate"]
    mod["downloadUrl"] = fileInfo["data"]["downloadUrl"]
