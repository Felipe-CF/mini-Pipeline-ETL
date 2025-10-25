import requests, json
from requests.exceptions import ConnectionError, JSONDecodeError, RequestException
from datetime import datetime


def get_requests(url, params):
    try:
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

        response = requests.get(url=url, params=params, headers=headers)

        if response.status_code == 200:
            return response.content.decode('utf-8')
        
        raise RequestException(f"[{datetime.now()}] erro na requisicao para endereco: {url}")
    
    except ConnectionError as e:
        print(f"[{datetime.now()}] problema de conexao: {str(e)}")

    except JSONDecodeError as e:
        print(f"[{datetime.now()}] problema de decode: {str(e)}")

    except RequestException as e:
        print(f"[{datetime.now()}] {str(e)}")


def products_capture(filter_id):
    
    url_products = f'https://api.devmka.online/categories/{filter_id}/products'

    products_params = {
        'page': '1',
        'limit': '100',
    }

    response_products = get_requests(
        url=url_products,
        params=products_params
    )

    products = json.loads(response_products)

    links = products['meta']

    last_page = links['last_page']

    products_list = []

    for id_page in (0, last_page):

        products_params = {
            'page': str(id_page+1),
            'limit': '100',
        }

        response_products = get_requests(
            url=url_products,
            params=products_params
        )

        products = json.loads(response_products)

        products_list.extend(products['data'])

        print(f"[{datetime.now()}] captura da pagina {id_page} finalizada com sucesso")
    
    print(f"[{datetime.now()}] captura dos produtos do filtro {filter_id} finalizada com sucesso")

    return products_list

