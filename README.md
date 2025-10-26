# mini-Pipeline-ETL -- Analisando Requisições, Projeto, Execução
Projeto para raspagem, tratamento e persistência de dados


##  Analisando Requisições
Visando eficiência, foi optado por usar a lib `requests` ao invés de `selenium` (ou semelhantes), evitando assim tempo oneroso de navigação (paginação)

###  Categorias
Ao acessar as categorias, é possível obter os dados de todas elas destacando o `nome` e o `id`, que é usado para acessar todos os produtos que pertencem a ela.

**Exemplo**:

    {
        "data": [
            {
                "id": 1,
                "name": "Freios",
                "slug": "freios"
            },
            {...}
        ] 
    }
 
 ###  Produtos
Selecionando uma das categorias, é possível obter todos respectivos produtos. Nesta requisição existem informações importantes para tanto o fluxo da captura de todos os produtos, como aquelas que devem ser persistidas no banco e CSV. Abaixo estão listados pontos importantes obtidos na requisição:

1.  Existe um limite de 100 produtos por página retornado em uma única requisição `GET`  (reduz a quantidade de requisições a serem feitas).
2.  Campo `["meta"] ["last_page"]` informa a pagina final dos produtos (limite de requisições a serem feitas)
3.  Campo `["data"]` contém uma lista com as informações do produto a serem tratadas e persistidas
4.  Campo `["data"] ["specifications"]` contém uma string com os dados `product_gross_weight`, `product_width`, `product_length` `warranty`, `material`. É realizado uma `captura regex` para obter esses dados.

    "Peso Bruto: 0.15kg | Dimensões (LxC): 6cm x 78.1cm | Material Principal: Aço Carbono | Garantia do Fabricante: 12 meses"

5.  A `url do produto` é montada somando o campo `["id"]` do produto presente em `["data"]` com requisição a url `https://api.devmka.online/products/`
6.  
7.  
8.  
9.  

**Exemplo**:

    {
        "data": [
            {
                "id": "1c27081b-a29c-4ba3-a4ff-83e3007e3da7",
                "title": "Bomba de Combust\u00edvel rerum",
                "brand": "Brembo",
                "part_number": "HD399-3191X",
                "price": 849.39,
                "thumbnail": "https:\/\/picsum.photos\/seed\/HD399-3191X\/200\/300",
                "specifications": "Peso Bruto: 10.75kg | Dimens\u00f5es (LxC): 48.8cm x 88.7cm | Material Principal: Borracha Sint\u00e9tica | Garantia do Fabricante: 12 meses",
                "stock_quantity": 33,
                "category": {
                    "name": "Freios",
                    "slug": "freios"
                }
            },
            {...},
        ],
        "links": {...},
        "meta": {
            "current_page": 1,
            "from": 1,
            "last_page": 138,
            "links": [
                {...},
                .
                .
                .
            ],
            "path": "https:\/\/api.devmka.online\/categories\/1\/products",
            "per_page": 12,
            "to": 12,
            "total": 1654
        }
    }

## Projeto

### Fluxo de Execução
A ideia por trás do pipeline é: capturar todas as categorias presentes e capturar todos os produtos de cada uma delas, realizando o tratamento das informações obtidas e persistindo-as tanto no **PostgreSQL**, com o database de nome `pipeline`, quanto em um `arquivo CSV`.

### Persistência e Modelagem dos Dados (PostgreSQL)
Foram criadas duas tabelas: `categories` e `products`. A primeira continha o `id` e o `nome` (uppercase) da categoria, enquanto que a segunda continha uma `foreign key` para identificar a qual categoria o produto pertence, criando relacionamento entre elas. A duplicidade foi tratada declarando variáveis sensíveis como `UNIQUE` e, durante a inserção de novos produtos/categorias, foi adotado o comando `ON CONFLICT DO NOTHING`.

**Tabela products**

|Coluna|Tipo|
|---|---|
|product_id|SERIAL PRIMARY KEY|
|product_id_url|VARCHAR|
|product_name|VARCHAR|
|product_url|TEXT|
|part_number|VARCHAR|
|brand_name|VARCHAR|
|product_price|DECIMAL|
|filter_id|INT|
|photo_url|TEXT|
|stock_quantity|INT|
|product_gross_weight|DECIMAL|
|product_width|DECIMAL|
|product_length|DECIMAL|
|warranty|VARCHAR|
|material|VARCHAR|

**Tabela categories**

|Coluna|Tipo|
|---|---|
|category_id|SERIAL PRIMARY KEY|
|filter_id|INT|
|category_name|VARCHAR|

Foi gerado um .sql para criação das tabelas utilizadas

### Persistência e Modelagem dos Dados (CSV)
Os produtos foram armazenados em lista evitando duplicidade, depois ela foi escrita/inserida no arquivo `desafio.csv`.

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

## Execução

### Requisitos e Modulação
Projeto foi executado em `Python 3.10.9` e as dependencias a serem instaladas via pip são `requests`, `pandas` e `psycopg2-binary` (conexão com o banco PostgreSQL). Todas foram salvas no arquivo `requirements.txt`.

A distribuição do pipeline se da em 3 arquivos, `main.py`, `data.py` e `captures.py`, sendo  necessário executar apenas o primeiro deles para execução de todo so fluxo do projeto.


