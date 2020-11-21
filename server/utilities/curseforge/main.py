import hashlib
import json
import logging
import os
import sys

import click
import coloredlogs
import requests
import urllib3
from prettytable import PrettyTable

DEBUG_MODE = False
CONFIG_FILE = ""
CONFIG = {}
MANIFEST = {}


def readjson(config_file):
    try:
        with open(config_file, "r", encoding="utf-8") as j:
            return json.load(j)
    except:
        logging.error("无法读取文件, 文件不存在或有错误")
        exit(1)


class Manifest(object):
    manifest = {}

    def __init__(self, manifest):
        self.manifest = manifest

    def mods(self):
        return self.manifest["files"]

    def info_table(self):
        _data = self.manifest
        info_tb = PrettyTable(["类别", "数据"])
        info_tb.title = "基本信息"
        info_tb.add_row(["名称", _data["name"]])
        info_tb.add_row(["版本", _data["version"]])
        info_tb.add_row(["作者", _data["author"]])
        print(info_tb)
        mc_tb = PrettyTable(["类别", "版本"])
        mc_tb.title = "游戏信息"
        mc_tb.add_row(["本体", _data["minecraft"]["version"]])
        mc_tb.add_row(["模组加载器", "↓"])
        for index, item in enumerate(_data["minecraft"]["modLoaders"]):
            mc_tb.add_row(["→", item["id"]])
        print(mc_tb)
        mods_tb = PrettyTable(["序号", "项目ID", "文件ID", "类型", "文件名", "SHA-1"])
        mods_tb.title = "模组列表"
        for index, item in enumerate(self.mods()):
            mods_tb.add_row([
                index, item["projectID"], item["fileID"],
                (item["type"]) if "type" in item.keys() else "-",
                (item["name"]) if "name" in item.keys() else "-",
                (item["hash"]) if "hash" in item.keys() else "-"
            ])
        print(mods_tb)


@click.group(invoke_without_command=False)
@click.option("--debug", is_flag=True,  default=False, help="启用调试模式")
@click.option("--config", "config_file", default="config.json", help="指定配置文件,默认为config.json")
@click.option("--manifest", "manifest_file", default="manifest.json", help="指定CurseForge配置文件,默认为manifest.json")
# @click.option("--manifest", "manifest_file", default="../../minecraft/manifest.json")
def cli(debug, config_file, manifest_file):
    global DEBUG_MODE
    global CONFIG
    global CONFIG_FILE
    global MANIFEST
    # print(debug)
    fmt = "[%(asctime)s] %(filename)s[line:%(lineno)d] %(message)s"
    field_styles = {"asctime": {"color": "green"}, "hostname": {"color": "magenta"}, "levelname": {"color": "magenta"}, "filename": {"color": "magenta"}, "name": {"color": "blue"}, "threadName": {"color": "green"}}
    level_styles = {"debug": {"color": "white"}, "info": {"color": "cyan"}, "warning": {"color": "yellow"}, "error": {"color": "red"}, "critical": {"color": "red"}}
    level = logging.DEBUG if debug == True else logging.INFO
    if debug == True:
        logging.debug("\033[32m调试模式已开启\033[0m")
        DEBUG_MODE = True
    else:
        DEBUG_MODE = False
    coloredlogs.install(level=level, fmt=fmt, field_styles=field_styles, level_styles=level_styles)

    CONFIG_FILE = config_file
    CONFIG = readjson(config_file)
    MANIFEST = readjson(manifest_file)


@cli.command(help="从Manifest中获取信息")
@ click.option("--markdown", "gen_md", is_flag=True, default=False, help="")
def info(gen_md):
    logging.debug(json.dumps(MANIFEST, ensure_ascii=False, indent=4))
    mObj = Manifest(MANIFEST)
    mObj.info_table()


@ cli.command(help="根据Manifest的信息下载Mod")
@ click.option("--download-dir", "-D", "download", default="", help="下载文件的路径,默认为本程序所在文件夹")
@ click.option("--no-check", "no_check", is_flag=True, default=False, help="")
@ click.option("--no-async", "no_async", is_flag=True, default=False, help="")
@ click.option("--type", "type", default=0, help="Mod类型,0:忽略,1:仅服务端,2:仅客户端,3:双端")
def dlmod(download, no_check, no_async, _type):
    if no_check == False:
        logging.info("命令行参数指定不进行Hash校验")

    if os.path.exists(download):
        dpath = os.path.abspath(download)
    else:
        dpath = os.path.abspath(os.path.dirname(sys.argv[0]))
        logging.warning("指定的路径不可用或未指定路径,自动选择默认路径")

    mod_list = Manifest(MANIFEST).mods()
    for index, item in enumerate(mod_list):
        if _type != 0:
            if "type" in item.keys():
                if _type != item["type"]:
                    break
        try:
            urllib3.disable_warnings()
            headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.66 Safari/537.36"}
            r = requests.get(
                f"{CONFIG['curseforge']['apiurl']}{item['projectID']}/file/{item['fileID']}",
                headers=headers, verify=False, proxies=CONFIG["proxy"], timeout=5
            ).text
            download_url = json.loads(r)["downloadUrl"]
            file_name = json.loads(r)["fileName"]
            down_res = requests.get(download_url, headers=headers, proxies=CONFIG["proxy"], verify=False, timeout=120)
            file_path = f"{dpath}\{file_name}"
            with open(file_path, "wb") as f:
                f.write(down_res.content)
            logging.info(f"[{index+1}/{len(mod_list)}] {file_name}下载完成")
        except Exception as e:
            logging.error(f"在下载第{index+1}个mod时发生错误")
            logging.debug(e)
            break

        if no_check == False:
            with open(file_path, "rb") as f:
                sha1Obj = hashlib.sha1()
                sha1Obj.update(f.read())
                if "hash" in item.keys():
                    if sha1Obj.hexdigest().upper().lower() != item["hash"].lower():
                        logging.warning(f"所下载的第{index+1}个Mod{file_name}与Manifest中指定的Hash值不一致")
                else:
                    logging.warning(f"Manifest中的第{index+1}个Mod{file_name}未指定Hash值, 跳过校验")


if __name__ == "__main__":
    click.clear()
    os.chdir(os.path.abspath(os.path.dirname(sys.argv[0])))
    cli()
