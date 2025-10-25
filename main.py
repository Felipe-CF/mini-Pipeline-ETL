import requests, json, os
from bs4 import BeautifulSoup



def main():
    url = 'https://api.devmka.online/'

    headers = {
        'Accept': '*/*',
        'Accept-Language': 'pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7',
        'Connection': 'keep-alive',
        'Origin': 'https://testdata.devmka.online',
        'Referer': 'https://testdata.devmka.online/',
        'Sec-Fetch-Dest': 'empty',
        'Sec-Fetch-Mode': 'cors',
        'Sec-Fetch-Site': 'same-site',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36',
        'sec-ch-ua': '"Google Chrome";v="141", "Not?A_Brand";v="8", "Chromium";v="141"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': '"Windows"',
    }

    params = {
        'page': '1',
        'limit': '6',
    }

    url_categorias = url + 'categories/'

    response = requests.get(url=url_categorias, params=params, headers=headers)

    response = json.loads(response.content.decode('utf-8'))

    x = 2

    url_produtos = url_categorias + "1/products"

    params = {
        'page': '18',
        'limit': '100',
    }

    response = requests.get(url=url_produtos, params=params, headers=headers)

    response = json.loads(response.content.decode('utf-8'))

    x = 2


if __name__ == '__main__':
    main()



