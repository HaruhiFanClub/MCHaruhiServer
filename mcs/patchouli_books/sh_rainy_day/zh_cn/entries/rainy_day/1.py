import json


def cut(text, num):
    page_list = []
    while(text != ''):
        page_list.append({"type": "text", "text": text[0:num]})
        text = text[num:]
    return page_list


with open("1.txt", "r") as f:
    s = cut(f.read(), 200)
    with open("2.json", "w") as j:
        json.dump(s, j, ensure_ascii=False, indent=4)
