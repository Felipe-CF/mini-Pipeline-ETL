import re, json, pandas as pd, os, csv
from csv import Error
from psycopg2.errors import UniqueViolation
from datetime import datetime


def insert_filter(category_name, filter_id, connection):
    try:
        cursor = connection.cursor()

        cursor.execute(
            "INSERT INTO categories (category_name, filter_id) VALUES (%s, %s) ON CONFLICT DO NOTHING",
            (category_name, filter_id)
        )

        connection.commit()

        cursor.close()

    except UniqueViolation as e:
        print(f"[{datetime.now()}] erro de duplicidade detectado")

    except Exception as e:
        print(str(e))


def insert_products(clean_products, connection):
    try:
        cursor = connection.cursor()

        for product in clean_products:

            cursor.execute(
                """
                INSERT INTO products (
                    product_id_url, product_name, product_url, part_number, 
                    brand_name, product_price, filter_id, photo_url, stock_quantity, 
                    product_gross_weight, product_width, product_length, warranty, material
                ) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) ON CONFLICT DO NOTHING
                """,
                (
                    product["product_id_url"], product["product_name"], product["product_url"],
                    product["part_number"], str(product["brand_name"]).upper(), product["product_price"],
                    product["filter_id"], product["photo_url"], product["stock_quantity"],
                    product["product_gross_weight"], product["product_width"], product["product_length"],
                    product["warranty"], product["material"]
                )
            )

            connection.commit()

        cursor.close()

    except UniqueViolation as e:
        print(f"[{datetime.now()}] erro de duplicidade detectado")

    except Exception as e:
        print(f"[{datetime.now()}] {str(e)}")


def product_treatment(products_list, filter_id):
    try:
        clean_products = []

        unique_products = []

        for product in products_list:
            specifications_regex = re.search(
            pattern=r'Peso Bruto\:\s*([\d\.]+)\w+\s*\|\s*Dimensões\s*\(LxC\)\:\s*([\d\.]+)\w+\s*\w\s*([\d\.]+)\w+\s*\|\s*Material\s*Principal\:\s*([\w\s]+)\s*\|\s*Garantia\s*do\s*Fabricante\:\s*(\d+)',
            string=product['specifications']
            )

            if specifications_regex is None:
                x = 2
                
            product_url = 'https://api.devmka.online/products/' + product['id']

            product_name =  product['title'].rsplit(' ', 1)[0]

            product_name = str(product_name).upper()

            product_price = str(product['price']).replace(',', '.')

            product_price = float(product_price)

            brand_name = str(product['brand']).upper()

            json_product = {
                "product_id_url": product['id'],
                "product_name": product_name,
                "product_url": product_url,
                "part_number": product['part_number'],
                "brand_name": brand_name,
                "product_price": product_price,
                "filter_id": filter_id,
                "photo_url": product['thumbnail'],
                "stock_quantity": product['stock_quantity'],
                "product_gross_weight": specifications_regex.group(1),
                "product_width": specifications_regex.group(2),
                "product_length": specifications_regex.group(3),
                "warranty": specifications_regex.group(4),
                "material": specifications_regex.group(5),
            }

            if json_product not in unique_products:
                unique_products.append(json_product)

            clean_products.append(json_product)

        print(f"[{datetime.now()}] insercao dos produtos de filtro {filter_id} finalizada com sucesso")

        return clean_products, unique_products
    
    except json.JSONDecodeError as e:
        print(str(e))
    
    except Exception as e:
        print(str(e))


def building_csv(unique_products):
    file_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

    csv_path = os.path.join(file_dir, 'desafio.csv')

    title = [
        "product_id_url", "product_name", "product_url", "part_number", "brand_name", 
        "product_price", "filter_id", "photo_url", "stock_quantity", "product_gross_weight", 
        "product_width", "product_length", "warranty", "material"
    ]

    with open('desafio.csv', "w", newline="") as file:
        cw = csv.DictWriter(
            file,
            title,
            delimiter=',',
            quotechar='|',
            quoting=csv.QUOTE_MINIMAL
        )

        cw.writeheader()

        cw.writerows(unique_products)
