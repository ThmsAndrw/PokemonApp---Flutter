from flask import Flask, jsonify
from flask_cors import CORS
import requests

app = Flask(__name__)

CORS(app)


# LISTA DE POKÉMON
@app.route("/pokemons", methods=["GET"])
def listar_pokemons():

    resposta = requests.get(
        "https://pokeapi.co/api/v2/pokemon?limit=30"
    )

    dados = resposta.json()

    pokemons = []

    for pokemon in dados["results"]:

        detalhes = requests.get(
            pokemon["url"]
        ).json()

        pokemon_formatado = {
            "id": detalhes["id"],
            "nome": detalhes["name"],
            "imagem": detalhes["sprites"]["front_default"],
            "tipo": detalhes["types"][0]["type"]["name"]
        }

        pokemons.append(
            pokemon_formatado
        )

    return jsonify(pokemons)


# DETALHES DE UM POKÉMON
@app.route("/pokemons/<int:id>", methods=["GET"])
def detalhes_pokemon(id):

    resposta = requests.get(
        f"https://pokeapi.co/api/v2/pokemon/{id}"
    )

    if resposta.status_code != 200:
        return jsonify({
            "erro": "Pokémon não encontrado"
        }), 404

    dados = resposta.json()


    tipos = []

    for tipo in dados["types"]:
        tipos.append(
            tipo["type"]["name"]
        )


    habilidades = []

    for habilidade in dados["abilities"]:
        habilidades.append(
            habilidade["ability"]["name"]
        )


    pokemon = {
        "id": dados["id"],
        "nome": dados["name"],
        "imagem": dados["sprites"]["front_default"],
        "altura": dados["height"],
        "peso": dados["weight"],
        "experiencia": dados["base_experience"],
        "tipos": tipos,
        "habilidades": habilidades,
        "hp": dados["stats"][0]["base_stat"],
        "ataque": dados["stats"][1]["base_stat"],
        "defesa": dados["stats"][2]["base_stat"],
        "geracao": dados["game_indices"][0]["version"]["name"],
        "shiny": dados["sprites"]["other"]["home"]["front_shiny"]
    }

    return jsonify(pokemon)


# PESQUISA DE UM POKEMON
@app.route("/pokemons/pesquisa/<string:busca>", methods=["GET"])
def pesquisar_pokemon(busca):
    try:
        resposta = requests.get(
            f"https://pokeapi.co/api/v2/pokemon/{busca}"
        )

        if resposta.status_code != 200:
            return jsonify({
                "erro": "Pokémon não encontrado"
            }), 404

        dados = resposta.json()

        pokemon_formatado = {
            "id": dados["id"],
            "nome": dados["name"],
            "imagem": dados["sprites"]["front_default"],
            "tipo": [tipo["type"]["name"] for tipo in dados["types"]]
        }

        return jsonify([pokemon_formatado])

    except requests.exceptions.RequestException as e:
        return jsonify({
            "erro": "Erro ao se conectar à PokéAPI",
            "detalhes": str(e)
        }), 500


if __name__ == "__main__":

    app.run(
        host="0.0.0.0",
        port=5001,
        debug=True
    )