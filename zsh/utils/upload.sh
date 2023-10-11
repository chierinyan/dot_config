#!/bin/bash
# class RSession:
#     def __init__(self):
#         self.proxy = {
#             "http": 'socks5://127.0.0.1:9000',
#             "https": 'socks5://127.0.0.1:9000'
#         }
#         headers = {
#             'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36',
#             'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
#             'X-Requested-With': 'XMLHttpRequest',
#         }
#         cookies = {
#             'PHPSESSID': 'nonu2a61e9nvali28qlbj4ojfu',
#             'lastest_upload_method': 'normalajax',
#             'X_CACHE_KEY': '522ba869a5f'
#         }
#         self.session = requests.Session()
#         self.session.headers.update(headers)
#         requests.utils.add_dict_to_cookiejar(self.session.cookies, cookies)

#     def upload(self, path):
#         url = 'https://img.chkaja.com/ajax.php'
#         img = open(path, 'rb')
#         data = {
#             'type': 'drop',
#             'name': path.split('/')[-1],
#             'file': f'data:image/{path.split(".")[-1]};base64,{base64.b64encode(img.read()).decode()}',
#         }
#         r = self.session.post(url, data=data)
#         tree = etree.HTML(r.text)
#         try:
#             return tree.xpath('/html/body/li/div[2]/p[1]/input/@value')[0]
#         except:
#             print(r.text)
#             return None


function upload() {
    local path=$1
    local type=${path##*.}
    local url='https://img.chkaja.com/ajax.php'
    local data="name=$(basename $path)&type=drop&file=data:image/$type;base64,$(base64 $path)"
    echo $data
    # echo -n $data | ALL_PROXY=socks5://127.0.0.1:9000 curl -s -X POST -d @- \
    #     -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome' \
    #     -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
    #     -H 'X-Requested-With: XMLHttpRequest' \
    #     --cookie 'PHPSESSID=nonu2a61e9nvali28qlbj4ojfu; lastest_upload_method=normalajax; X_CACHE_KEY=522ba869a5f' \
    #     $url
}

upload $1
