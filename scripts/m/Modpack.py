import os
import shutil

from m import CurseForge, utils


def msg(text: str, _print: bool = True) -> str | None:
    m = f"[Modpack] {text}"
    if _print:
        print(m)
    else:
        return m


class Modpack():

    def __init__(self, path: str, name: str, version: str) -> None:
        self.path = path
        self.name = name
        self.version = version
        self.fullname = f"{name}-{version}"
        self.temp = utils.copySrcToTemp(self.path, self.fullname)
        self.manifest = dict(utils.readJson(os.path.join(self.temp, "manifest.json")))
        self.overrides = utils.getDir(os.path.join(self.temp, "overrides"))
        msg(f"Modpack '{self.name}' initialized")
        msg(f"Modpack version: {self.version}")

    def _writeManifest(self) -> None:
        utils.writeJson(os.path.join(self.temp, "manifest.json"), self.manifest)

    def _replaceVersion(self) -> None:
        self.manifest["version"] = self.version

    def _resloveMods(self) -> None:
        mods = self.manifest["files"]
        CurseForge.resloveMods(mods)
        CurseForge.printModsTable(mods, os.path.join(self.temp, "modlist.txt"))

    def addResourcepack(self, pack: str):
        msg(f"Adding resourcepack '{self.version}' to modpack")
        return shutil.copy(pack, utils.getDir(os.path.join(self.overrides, "resourcepacks")))

    def build(self, outputDir: str) -> str:
        msg("Building modpack")

        self._replaceVersion()
        self._resloveMods()
        self._writeManifest()

        zipFile = os.path.join(outputDir, f"{self.fullname}.zip")
        utils.zip(self.temp, zipFile)
        msg(f"Build complete: '{zipFile}'")
        return zipFile
