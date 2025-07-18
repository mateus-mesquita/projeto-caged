## Processando df
import pandas as pd
import sqlite3
from arquivos import dic_for_admissoes, meses,dic_exc_admissoes,dic_exc_demissoes,dic_for_demissoes

# Unidades Federativas (UF) a serem consideradas.
local = ["", "CE", "PE", "BA"]

# Opções de gênero.
sexo = ["", "Feminino", "Masculino", "Não informado"]

# Categorias de raça/cor.
raca_cor = ["", "Branca", "Preta", "Parda", "Amarela", "Indígena","Não informada", "Não identificado"]

# Níveis de instrução (escolaridade).
grau_de_instrucao = ["", "ANALFABETO", "ATE 5.A INC", "5.A CO FUND", "6. A 9. FUND",
"FUND COMPL", "MEDIO INCOMP", "MEDIO COMPL",'SUP. INCOMP', "SUP. COMP", "MESTRADO", "DOUTORADO"]

# Faixas etárias.
idades = ["", "14 a 17", "18 a 24", "25 a 39", "40 a 59", "60 ou mais"]

# CLT
clt = ["","SIM","NÃO"]
mov_admissoes = pd.read_csv("mov_admissoes.csv", sep =';')
mov_demissoes = pd.read_csv("mov_demissoes.csv",sep = ';')
mov_admissoes2025 = pd.read_csv("mov_admissoes2025.csv",sep = ';')
mov_demissoes2025 = pd.read_csv("mov_demissoes2025.csv",sep = ';')
for_admissoes2025 = pd.read_csv("for_admissoes2025_final.csv",sep = ';')
for_demissoes2025 = pd.read_csv("for_demissoes2025_final.csv",sep = ';')
exc_admissoes2025 = pd.read_csv("exc_admissoes2025_final.csv", sep = ';')
exc_demissoes2025 = pd.read_csv("exc_demissoes2025_final.csv", sep = ';')

def df_auxiliar():
    dados = []
    for local_ in local:
        for sexo_ in sexo:
            for raca_ in raca_cor:
                for idade_ in idades:
                    for gdi_ in grau_de_instrucao:
                        for clt_ in clt:
                            dados.append({
                                'local': local_,
                                'sexo': sexo_,
                                'raca': raca_,
                                'idade': idade_,
                                'grau_de_instrucao': gdi_,
                                'clt': clt_
                            })
    return pd.DataFrame(dados)


def tabela(conexao,lista):
    lista_chaves = list(lista.keys())
    dic_arquivos = []
    conexao = sqlite3.connect(conexao)
    df = df_auxiliar()  # transforma lista em df
    
    # Lê todas as tabelas e salva em dic_arquivos
    for arquivo_ in lista_chaves:
        dic_arquivos.append(pd.read_sql(f"SELECT * FROM {arquivo_};", con=conexao))
    
    # Meses que vão somar (supondo que variável meses existe)
    for mes_ in meses:
        df[mes_] = 0
        
        for i in dic_arquivos:
            df[mes_] += i[mes_]
    
    conexao.close()
    return df

meses_2024 = {
    "janeiro": "janeiro_2024",
    "fevereiro": "fevereiro_2024",
    "março": "março_2024",
    "abril": "abril_2024",
    "maio": "maio_2024",
    "junho": "junho_2024",
    "julho": "julho_2024",
    "agosto": "agosto_2024",
    "setembro": "setembro_2024",
    "outubro": "outubro_2024",
    "novembro": "novembro_2024",
    "dezembro": "dezembro_2024"
}

meses_2025 = {
    "janeiro": "janeiro_2025",
    "fevereiro": "fevereiro_2025",
    "março": "março_2025",
    "abril": "abril_2025",
    "maio": "maio_2025"
}

def Tabela_final():
    for_admissoes = tabela('For_admissoes.db',dic_for_admissoes)
    for_demissoes = tabela('For_demissoes.db',dic_for_demissoes)
    exc_admissoes = tabela('exc_admissoes.db',dic_exc_admissoes)
    exc_demissoes = tabela('exc_demissoes.db',dic_exc_demissoes)
    
    df = df_auxiliar()
    
    df['janeiro_2024'] = mov_admissoes['janeiro'] - mov_demissoes['janeiro'] + for_admissoes['janeiro'] - for_demissoes['janeiro'] - exc_admissoes['janeiro'] + exc_demissoes['janeiro']
    df['fevereiro_2024'] = df['janeiro_2024'] + mov_admissoes['fevereiro'] - mov_demissoes['fevereiro'] + for_admissoes['fevereiro'] - for_demissoes['fevereiro'] - exc_admissoes['fevereiro'] + exc_demissoes['fevereiro']
    df['março_2024'] = df['fevereiro_2024'] + mov_admissoes['março'] - mov_demissoes['março'] + for_admissoes['março'] - for_demissoes['março'] - exc_admissoes['março'] + exc_demissoes['março']
    df['abril_2024'] = df['março_2024'] + mov_admissoes['abril'] - mov_demissoes['abril'] + for_admissoes['abril'] - for_demissoes['abril'] - exc_admissoes['abril'] + exc_demissoes['abril']
    df['maio_2024'] = df['abril_2024'] + mov_admissoes['maio'] - mov_demissoes['maio'] + for_admissoes['maio'] - for_demissoes['maio'] - exc_admissoes['maio'] + exc_demissoes['maio']
    df['junho_2024'] = df['maio_2024'] + mov_admissoes['junho'] - mov_demissoes['junho'] + for_admissoes['junho'] - for_demissoes['junho'] - exc_admissoes['junho'] + exc_demissoes['junho']
    df['julho_2024'] = df['junho_2024'] + mov_admissoes['julho'] - mov_demissoes['julho'] + for_admissoes['julho'] - for_demissoes['julho'] - exc_admissoes['julho'] + exc_demissoes['julho']
    df['agosto_2024'] = df['julho_2024'] + mov_admissoes['agosto'] - mov_demissoes['agosto'] + for_admissoes['agosto'] - for_demissoes['agosto'] - exc_admissoes['agosto'] + exc_demissoes['agosto']
    df['setembro_2024'] = df['agosto_2024'] + mov_admissoes['setembro'] - mov_demissoes['setembro'] + for_admissoes['setembro'] - for_demissoes['setembro'] - exc_admissoes['setembro'] + exc_demissoes['setembro']
    df['outubro_2024'] = df['setembro_2024'] + mov_admissoes['outubro'] - mov_demissoes['outubro'] + for_admissoes['outubro'] - for_demissoes['outubro'] - exc_admissoes['outubro'] + exc_demissoes['outubro']
    df['novembro_2024'] = df['outubro_2024'] + mov_admissoes['novembro'] - mov_demissoes['novembro'] + for_admissoes['novembro'] - for_demissoes['novembro'] - exc_admissoes['novembro'] + exc_demissoes['novembro']
    df['dezembro_2024'] = df['novembro_2024'] + mov_admissoes['dezembro'] - mov_demissoes['dezembro'] + for_admissoes['dezembro'] - for_demissoes['dezembro'] - exc_admissoes['dezembro'] + exc_demissoes['dezembro']
    
    return df

def Tabela_atualizada():
    tabela = Tabela_final()
    
    tabela['janeiro_2025'] = tabela['dezembro_2024'] + mov_admissoes2025['janeiro'] - mov_demissoes2025['janeiro'] + for_admissoes2025['janeiro'] - for_demissoes2025['janeiro'] - exc_admissoes2025['janeiro'] + exc_demissoes2025['janeiro']
    tabela['fevereiro_2025'] = tabela['janeiro_2025'] + mov_admissoes2025['fevereiro'] - mov_demissoes2025['fevereiro'] + for_admissoes2025['fevereiro'] - for_demissoes2025['fevereiro'] - exc_admissoes2025['fevereiro'] + exc_demissoes2025['fevereiro']
    tabela['março_2025'] = tabela['fevereiro_2025'] + mov_admissoes2025['março'] - mov_demissoes2025['março'] + for_admissoes2025['março'] - for_demissoes2025['março'] - exc_admissoes2025['março'] + exc_demissoes2025['março']
    tabela['abril_2025'] = tabela['março_2025'] + mov_admissoes2025['abril'] - mov_demissoes2025['abril'] + for_admissoes2025['abril'] - for_demissoes2025['abril'] - exc_admissoes2025['abril'] + exc_demissoes2025['abril']
    tabela['maio_2025'] = tabela['abril_2025'] + mov_admissoes2025['maio'] - mov_demissoes2025['maio'] + for_admissoes2025['maio'] - for_demissoes2025['maio'] - exc_admissoes2025['maio'] + exc_demissoes2025['maio']
    tabela['junho_2025'] = tabela['maio_2025'] + mov_admissoes2025['junho'] - mov_demissoes2025['junho'] + for_admissoes2025['junho'] - for_demissoes2025['junho'] - exc_admissoes2025['junho'] + exc_demissoes2025['junho']
    return tabela

print(Tabela_atualizada())
    
    