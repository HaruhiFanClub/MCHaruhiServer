import json
import os
import shutil


def getEnvAsBoolean(name: str) -> bool:
    v = os.getenv(name)
    return (True if (v.lower() == "true") else False) if (v != None) else False


def getVersion() -> str:
    if getEnvAsBoolean("CI"):
        if getEnvAsBoolean("GITHUB_ACTIONS"):
            main = os.getenv("GITHUB_REF_NAME")
            sha = os.getenv("GITHUB_SHA")[0:7]
            build = os.getenv("GITHUB_RUN_NUMBER")
            return f"{main}-rev.{sha}-build.{build}"
        else:
            os.getenv("CI_VERSION")
    else:
        main = os.popen("git symbolic-ref --short HEAD").read().strip()
        sha = os.popen("git rev-parse --verify --short HEAD").read().strip()
        dirty = "" if (os.popen("git status --short").read().strip() == "") else "-dirty"
        return f"{main}-rev.{sha}-build.0{dirty}"


def readJson(jsonfile: str):
    with open(jsonfile, "r", encoding="utf-8") as f:
        j = json.load(f)
    return j


def writeJson(jsonfile: str, jsonData: dict):
    with open(jsonfile, "w", encoding="utf-8") as f:
        json.dump(jsonData, f, ensure_ascii=False, indent=4)


def getDir(path: str):
    if not os.path.exists(path):
        os.makedirs(path)
    return path


def getTempDir():
    return getDir(os.path.abspath("tmp"))


def copySrcToTemp(srcDir: str, tempName: str):
    copy = os.path.join(getTempDir(), tempName)
    if os.path.exists(copy):
        shutil.rmtree(copy)
    shutil.copytree(srcDir, copy)
    return copy


def zip(srcDir: str, zipFile: str):
    os.popen(f"7z a {zipFile} {srcDir}/*").read()
    return zipFile
