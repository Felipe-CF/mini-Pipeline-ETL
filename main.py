import json, os, psycopg2, re
from json import JSONDecodeError
from bs4 import BeautifulSoup
from datetime import datetime
from captures import get_requests, products_capture
from data import insert_filter, product_treatment, insert_products


def start_connection():
    return psycopg2.connect(
            host='localhost',
            database='pipeline',
            user='desafio',
            password='desafio'
        ) 


def main():
    try:
        url_filters = 'https://api.devmka.online/categories'

        filters_params = {
            'page': '1',
            'limit': '6',
            }
        
        print(f"[{datetime.now()}] iniciando captura dos filtros")

        response_filters = get_requests(
            url=url_filters,
            params=filters_params
        )

        print(f"[{datetime.now()}] filtros captura com sucesso")

        print(f"[{datetime.now()}] iniciando persistencia dos filtros")

        filters = json.loads(response_filters)

        filters = filters['data']

        connection = start_connection()

        for filter in filters:
            insert_filter(
                category_name=str(filter['name']).upper(),
                filter_id= filter['id'],
                connection=connection
            )

        print(f"[{datetime.now()}] comandos sql para os filtros finalizados com sucesso")

        for filter in filters:
            products_list =  products_capture(filter_id=filter['id'])
            
            clean_products = product_treatment(
                connection=connection,
                filter_id=filter['id'],
                products_list=products_list
            )

            insert_products(
                clean_products=clean_products,
                connection=connection
            )

    except JSONDecodeError as e:
        print(f"[{datetime.now()}] problema no carregamento do json: {str(e)}")



if __name__ == '__main__':
    main()



