# Processamento da Caged For
import pandas as pd
from tqdm import tqdm
import sqlite3

from arquivos import dic_exc_admissoes,dic_exc_demissoes,dic_for_admissoes,dic_for_demissoes
con_for_admissoes = sqlite3.connect("For_admissoes.db")
con_for_demissoes = sqlite3.connect("For_demissoes.db")
con_exc_admissoes = sqlite3.connect("exc_admissoes.db")
con_exc_demissoes = sqlite3.connect("exc_demissoes.db")



def executar_bd(arquivos,conexao):
    try:
        for nome, arquivo in tqdm(arquivos.items()):
            df = pd.read_csv(arquivo, sep = ';')
            df.to_sql(nome, conexao, index=False, if_exists='replace')
    except:
        print("Erro na execução do bd")


executar_bd(dic_for_admissoes,con_for_admissoes)
executar_bd(dic_for_demissoes,con_for_demissoes)
executar_bd(dic_exc_admissoes,con_exc_admissoes)
executar_bd(dic_exc_demissoes,con_exc_demissoes)