import os
import shutil

from m import utils


class Pack():
    def __init__(self, path: str, name: str, version: str) -> None:
        self.path = path
        self.name = name
        self.version = version
        self.fullname = f"{name}-{version}"

    def build(self, outputDir: str) -> str:
        tmp = utils.copySrcToTemp(self.path, self.fullname)

        metaFile = os.path.join(tmp, "pack.mcmeta")
        meta = dict(utils.readJson(metaFile))
        meta["pack"]["description"] = str(meta["pack"]["description"]).replace("${version}", self.version)
        utils.writeJson(metaFile, meta)

        return utils.zip(tmp, os.path.join(outputDir, f"{self.fullname}.zip"))
