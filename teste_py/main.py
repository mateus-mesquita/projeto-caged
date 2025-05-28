# Dados dos arquivos
import pandas as pd
import sqlite3
from tabela_de_contagem import tabela_resultado, dados_comb
from funcoes_rais import tabela_final_estoque

# conexões com os bancos de dados
con_exc = sqlite3.connect()
con_for = sqlite3.connect()
con_mov = sqlite3.connect()
con_rais = sqlite3.connect()

dados_exc_admissoes = {
    "admissoes_exc202301": "cagedexc202301",
    "admissoes_exc202302": "cagedexc202302",
    "admissoes_exc202303": "cagedexc202303",
    "admissoes_exc202304": "cagedexc202304",
    "admissoes_exc202305": "cagedexc202305",
    "admissoes_exc202306": "cagedexc202306",
    "admissoes_exc202307": "cagedexc202307",
    "admissoes_exc202308": "cagedexc202308",
    "admissoes_exc202309": "cagedexc202309",
    "admissoes_exc202310": "cagedexc202310",
    "admissoes_exc202311": "cagedexc202311",
    "admissoes_exc202312": "cagedexc202312"
}  

dados_exc_demissoes = {
    "demissoes_exc202301": "cagedexc202301",
    "demissoes_exc202302": "cagedexc202302",
    "demissoes_exc202303": "cagedexc202303",
    "demissoes_exc202304": "cagedexc202304",
    "demissoes_exc202305": "cagedexc202305",
    "demissoes_exc202306": "cagedexc202306",
    "demissoes_exc202307": "cagedexc202307",
    "demissoes_exc202308": "cagedexc202308",
    "demissoes_exc202309": "cagedexc202309",
    "demissoes_exc202310": "cagedexc202310",
    "demissoes_exc202311": "cagedexc202311",
    "demissoes_exc202312": "cagedexc202312"
}

dados_mov_demissoes = {
    "demissoes_mov202301": "cagedmov202301",
    "demissoes_mov202302": "cagedmov202302",
    "demissoes_mov202303": "cagedmov202303",
    "demissoes_mov202304": "cagedmov202304",
    "demissoes_mov202305": "cagedmov202305",
    "demissoes_mov202306": "cagedmov202306",
    "demissoes_mov202307": "cagedmov202307",
    "demissoes_mov202308": "cagedmov202308",
    "demissoes_mov202309": "cagedmov202309",
    "demissoes_mov202310": "cagedmov202310",
    "demissoes_mov202311": "cagedmov202311",
    "demissoes_mov202312": "cagedmov202312"
}

dados_mov_admissoes = {
    "admissoes_mov202301": "cagedmov202301",
    "admissoes_mov202302": "cagedmov202302",
    "admissoes_mov202303": "cagedmov202303",
    "admissoes_mov202304": "cagedmov202304",
    "admissoes_mov202305": "cagedmov202305",
    "admissoes_mov202306": "cagedmov202306",
    "admissoes_mov202307": "cagedmov202307",
    "admissoes_mov202308": "cagedmov202308",
    "admissoes_mov202309": "cagedmov202309",
    "admissoes_mov202310": "cagedmov202310",
    "admissoes_mov202311": "cagedmov202311",
    "admissoes_mov202312": "cagedmov202312"
}

dados_for_admissoes = {
    "admissoes_for202301": "cagedfor202301",
    "admissoes_for202302": "cagedfor202302",
    "admissoes_for202303": "cagedfor202303",
    "admissoes_for202304": "cagedfor202304",
    "admissoes_for202305": "cagedfor202305",
    "admissoes_for202306": "cagedfor202306",
    "admissoes_for202307": "cagedfor202307",
    "admissoes_for202308": "cagedfor202308",
    "admissoes_for202309": "cagedfor202309",
    "admissoes_for202310": "cagedfor202310",
    "admissoes_for202311": "cagedfor202311",
    "admissoes_for202312": "cagedfor202312"
}

dados_for_demissoes = {
    "demissoes_for202301": "cagedfor202301",
    "demissoes_for202302": "cagedfor202302",
    "demissoes_for202303": "cagedfor202303",
    "demissoes_for202304": "cagedfor202304",
    "demissoes_for202305": "cagedfor202305",
    "demissoes_for202306": "cagedfor202306",
    "demissoes_for202307": "cagedfor202307",
    "demissoes_for202308": "cagedfor202308",
    "demissoes_for202309": "cagedfor202309",
    "demissoes_for202310": "cagedfor202310",
    "demissoes_for202311": "cagedfor202311",
    "demissoes_for202312": "cagedfor202312"
}

tabela_exc = tabela_resultado(con_exc,dados_exc_admissoes,dados_exc_demissoes)
tabela_for = tabela_resultado(con_for,dados_for_admissoes,dados_for_demissoes)
tabela_mov = tabela_resultado(con_mov,dados_mov_admissoes,dados_mov_demissoes)
tabela_rais = tabela_final_estoque(con_rais)

# Criando novas colunas para resultado final
dados_comb['janeiro'] = (
    tabela_rais['estoque'] 
    + tabela_mov['admissoes_mov202301'] 
    - tabela_mov['demissoes_mov202301']
    + tabela_for['admissoes_for202301']
    - tabela_for['demissoes_for202301']
    - tabela_exc['admissoes_exc202301']
    + tabela_exc['demissoes_exc202301']
)

dados_comb['fevereiro'] = dados_comb['janeiro']+(
    tabela_rais['estoque'] 
    + tabela_mov['admissoes_mov202302'] 
    - tabela_mov['demissoes_mov202302']
    + tabela_for['admissoes_for202302']
    - tabela_for['demissoes_for202302']
    - tabela_exc['admissoes_exc202302']
    + tabela_exc['demissoes_exc202302']
)

dados_comb['marco'] = dados_comb['fevereiro']+(
    tabela_rais['estoque'] 
    + tabela_mov['admissoes_mov202303'] 
    - tabela_mov['demissoes_mov202303']
    + tabela_for['admissoes_for202303']
    - tabela_for['demissoes_for202303']
    - tabela_exc['admissoes_exc202303']
    + tabela_exc['demissoes_exc202303']
)

dados_comb['abril'] = dados_comb['marco'] + (
    tabela_mov['admissoes_mov202304'] 
    - tabela_mov['demissoes_mov202304']
    + tabela_for['admissoes_for202304']
    - tabela_for['demissoes_for202304']
    - tabela_exc['admissoes_exc202304']
    + tabela_exc['demissoes_exc202304']
)

dados_comb['maio'] = dados_comb['abril'] + (
    tabela_mov['admissoes_mov202305'] 
    - tabela_mov['demissoes_mov202305']
    + tabela_for['admissoes_for202305']
    - tabela_for['demissoes_for202305']
    - tabela_exc['admissoes_exc202305']
    + tabela_exc['demissoes_exc202305']
)

dados_comb['junho'] = dados_comb['maio'] + (
    tabela_mov['admissoes_mov202306'] 
    - tabela_mov['demissoes_mov202306']
    + tabela_for['admissoes_for202306']
    - tabela_for['demissoes_for202306']
    - tabela_exc['admissoes_exc202306']
    + tabela_exc['demissoes_exc202306']
)

dados_comb['julho'] = dados_comb['junho'] + (
    tabela_mov['admissoes_mov202307'] 
    - tabela_mov['demissoes_mov202307']
    + tabela_for['admissoes_for202307']
    - tabela_for['demissoes_for202307']
    - tabela_exc['admissoes_exc202307']
    + tabela_exc['demissoes_exc202307']
)

dados_comb['agosto'] = dados_comb['julho'] + (
    tabela_mov['admissoes_mov202308'] 
    - tabela_mov['demissoes_mov202308']
    + tabela_for['admissoes_for202308']
    - tabela_for['demissoes_for202308']
    - tabela_exc['admissoes_exc202308']
    + tabela_exc['demissoes_exc202308']
)

dados_comb['setembro'] = dados_comb['agosto'] + (
    tabela_mov['admissoes_mov202309'] 
    - tabela_mov['demissoes_mov202309']
    + tabela_for['admissoes_for202309']
    - tabela_for['demissoes_for202309']
    - tabela_exc['admissoes_exc202309']
    + tabela_exc['demissoes_exc202309']
)

dados_comb['outubro'] = dados_comb['setembro'] + (
    tabela_mov['admissoes_mov202310'] 
    - tabela_mov['demissoes_mov202310']
    + tabela_for['admissoes_for202310']
    - tabela_for['demissoes_for202310']
    - tabela_exc['admissoes_exc202310']
    + tabela_exc['demissoes_exc202310']
)

dados_comb['novembro'] = dados_comb['outubro'] + (
    tabela_mov['admissoes_mov202311'] 
    - tabela_mov['demissoes_mov202311']
    + tabela_for['admissoes_for202311']
    - tabela_for['demissoes_for202311']
    - tabela_exc['admissoes_exc202311']
    + tabela_exc['demissoes_exc202311']
)

dados_comb['dezembro'] = dados_comb['novembro'] + (
    tabela_mov['admissoes_mov202312'] 
    - tabela_mov['demissoes_mov202312']
    + tabela_for['admissoes_for202312']
    - tabela_for['demissoes_for202312']
    - tabela_exc['admissoes_exc202312']
    + tabela_exc['demissoes_exc202312']
)
