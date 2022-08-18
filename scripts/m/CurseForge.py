import json
import os
import threading
from typing import List, Optional, TypedDict

import requests
import urllib3
from m import utils
from prettytable import PrettyTable
from requests.adapters import HTTPAdapter


def msg(text: str, _print: bool = True) -> str | None:
    m = f"[CurseForge] {text}"
    if _print:
        print(m)
    else:
        return m


urllib3.disable_warnings()
SESSION = requests.session()
SESSION.mount('https://', HTTPAdapter(max_retries=3))

API_BASE_URL = "https://api.curseforge.com/v1/mods"

key = os.getenv("CURSEFORGE_CORE_API_KEY")
if key is None:
    raise RuntimeError(msg("No api key provided", False))
HEADERS = {"Accept": "application/json", "x-api-key": key}

PROXY = (lambda proxy: {} if (proxy is None) else {"http": proxy, "https": proxy})(os.getenv("REQUESTS_PROXY"))


def fetchApi(path: str):
    r = SESSION.get(f"{API_BASE_URL}/{path}", headers=HEADERS, proxies=PROXY, verify=False, timeout=20)
    r.raise_for_status()
    return json.loads(r.text)


class ModInfo(TypedDict):
    projectID: int
    fileID: int
    required: Optional[bool]
    projectSlug: Optional[str]
    projectName: Optional[str]
    fileSHA1: Optional[str]
    fileName: Optional[str]
    fileLength: Optional[int]
    fileDate: Optional[str]


def resloveMods(mods: List[ModInfo]) -> List[ModInfo]:
    p = 5
    count = len(mods)
    for gi, group in enumerate([mods[i:i+p] for i in range(0, len(mods), p)]):
        threads: List[threading.Thread] = []
        for i, mod in enumerate(group):
            t = threading.Thread(target=resloveModInfo, args=(mod, f"[{gi*p+i+1}/{count}] "))
            threads.append(t)
        for t in threads:
            t.setDaemon(True)
            t.start()
        for t in threads:
            t.join()
        threads = []
    return mods


def resloveModInfo(mod: ModInfo, index: str = "") -> ModInfo:
    msg(f"{index}Resloving mod {mod['projectID']}")

    if not "required" in mod.keys():
        mod["required"] = True

    modInfo = fetchApi(f"{mod['projectID']}")
    mod["projectName"] = modInfo["data"]["name"]
    mod["projectSlug"] = modInfo["data"]["slug"]

    fileInfo = fetchApi(f"{mod['projectID']}/files/{mod['fileID']}")
    mod["fileSHA1"] = fileInfo["data"]["hashes"][0]["value"]
    mod["fileName"] = fileInfo["data"]["fileName"]
    mod["fileLength"] = fileInfo["data"]["fileLength"]
    mod["fileDate"] = fileInfo["data"]["fileDate"]
    mod["downloadUrl"] = fileInfo["data"]["downloadUrl"]

    msg(f"{index}Mod {mod['projectID']} resloved")
    return mod


def printModsTable(mods: List[ModInfo], output: str = None):
    tb = PrettyTable(["Index", "Required", "Project ID", "Project Slug", "Project Name", "File ID", "File Name", "File Size", "File Date", "SHA1"])
    tb.title = "Mod List"
    for index, item in enumerate(mods):
        tb.add_row([
            index,
            utils.getOrElse(item, "required", True),
            item["projectID"],
            utils.getOrElse(item, "projectSlug"),
            utils.getOrElse(item, "projectName"),
            item["fileID"],
            utils.getOrElse(item, "fileName"),
            utils.formatSize(item["fileLength"]) if ("fileLength" in item.keys()) else "-",
            utils.getOrElse(item, "fileDate"),
            utils.getOrElse(item, "fileSHA1"),
        ])

    if output is None:
        print(tb)
    else:
        with open(output, "w", encoding="utf-8") as f:
            f.write(tb.get_string())
            msg(f"Saved mod list table to '{output}'")
