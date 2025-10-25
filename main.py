import json, psycopg2,time 
from json import JSONDecodeError
from datetime import datetime
from captures import get_requests, products_capture
from data import *


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
        
        print(f"[{datetime.now()}] iniciando captura dos filtros...")

        response_filters = get_requests(
            url=url_filters,
            params=filters_params
        )

        print(f"[{datetime.now()}] filtros capturados com sucesso")

        print(f"[{datetime.now()}] iniciando persistencia dos filtros...")

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

        unique_products = []

        for filter in filters:
            print(f"[{datetime.now()}] iniciando captura dos produtos do filtro \"{filter['slug']}\"...")

            products_list =  products_capture(filter_id=filter['id'])

            print(f"[{datetime.now()}] iniciando tratamento dos produtos...")

            clean_products, no_repeat_products  = product_treatment(
                filter_id=filter['id'],
                products_list=products_list
            )

            unique_products.extend(no_repeat_products)

            print(f"[{datetime.now()}] tratamento finalizado com sucesso")

            print(f"[{datetime.now()}] persistindo no banco...")

            insert_products(
                clean_products=clean_products,
                connection=connection
            )

            print(f"[{datetime.now()}] produtos salvos com sucesso no banco")

        building_csv(unique_products)

        print(f"[{datetime.now()}] produtos salvos com sucesso em CSV")

        print(f"[{datetime.now()}] finalizando pipeline")

        time.sleep(5)

    except JSONDecodeError as e:
        print(f"[{datetime.now()}] problema no carregamento do json: {str(e)}")


if __name__ == '__main__':
    main()



