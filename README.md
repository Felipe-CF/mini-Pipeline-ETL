# mini-Pipeline-ETL -- Análise, Projeto, Resultado 
Projeto para raspagem, tratamento e persistência de dados


##  Análise
Por ser um 
- [] **Análise de Dados**

## Objetivos
Coletar informações dos produtos disponibilizados


## Avaliando requisições

Acessando o site, notei que as 6 categorias são identificadas pelo intervalo de interios de 1 (mais a esquerda) à 6 (mais a direita). Ao selecionar uma delas, se obtemo seguinte JSON reposta:
{
    "data": [...],
    "links": {
        "first": "https:\/\/api.devmka.online\/categories\/<id_inteiro>\/products?page=<pagina inicial>",
        "last": "https:\/\/api.devmka.online\/categories\/<id_inteiro>\/products?page=<pagina final>",
        "prev": "https:\/\/api.devmka.online\/categories\/<id_inteiro>\/products?page=<pagina anterior>",
        "next": "https:\/\/api.devmka.online\/categories\/<id_inteiro>\/products?page=<proxima pagina>"
    },

    "meta": {...}
}

### campo data
Contém uma lista com as principais informações de cada produto retornado na requisição, sendo elas: `name`, `part_number`, `brand_name`, `category`, `gross_weight`, `width`, `length`, `warranty`, `material`, `photo_url`

|Campo JSON requisicao|Coluna PostgreSQL|Tipo|
|---|---|---|
|title|name|(str)|
|part_number|part_number|(str)|
|brand|brand_name|(str)|
|category['name']|category|(str)|
|thumbnail|photo_url|(str)|
|stock_quantity|stock_quantity|(int)|
|specifications|<mark>gross_weight</mark>|(float)|
|specifications|<mark>width</mark>|(float)|
|specifications|<mark>length</mark>|(float)|
|specifications|<mark>warranty</mark>|(str)|
|specifications|<mark>material</mark>|(str)|

⚠️  Observação: os valores dos campos acima serão extraídos via regex do campo JSON
Exemplo: "Peso Bruto: 0.15kg | Dimensões (LxC): 6cm x 78.1cm | Material Principal: Aço Carbono | Garantia do Fabricante: 12 meses"


Abaixo se encontra o padrão dos elementos deste campo:

    {
        "id": "019a122c-4af9-7141-8fd4-a55a0a4951d7",
        "title": "Pastilha de Freio id",
        "brand": "Monroe",
        "part_number": "IK664-9876E",
        "price": 166.81,
        "thumbnail": "https:\/\/picsum.photos\/seed\/IK664-9876E\/200\/300",
        "specifications": "Peso Bruto: 6.71kg | Dimens\u00f5es (LxC): 17.7cm x 65cm | Material Principal: Borracha Sint\u00e9tica | Garantia do Fabricante: 12 meses",
        "stock_quantity": 60,
        "category": {
            "name": "Freios",
            "slug": "freios"
        }
    }

