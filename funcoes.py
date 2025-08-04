import pandas as pd
from itertools import combinations
from tqdm import tqdm

# --- Variáveis de categoria ---
variaveis = ['uf', 'sexo', 'raçacor', 'faixa_idade', 'graudeinstrução', 'clt']
variaveis_compt = ['competênciamov','uf', 'sexo', 'raçacor', 'faixa_idade', 'graudeinstrução', 'clt']

# Unidades Federativas (UF) a serem consideradas, incluindo uma string vazia para representar "todos".
local = ["", "CE", "PE", "BA"]

# Opções de gênero. A string vazia representa "todos".
sexo = ["", "Feminino", "Masculino", "Não informado"]

# Categorias de raça/cor. A string vazia representa "todos".
raca_cor = ["", "Branca", "Preta", "Parda", "Amarela", "Indígena","Não informada", "Não identificado"]

# Níveis de instrução (escolaridade). A string vazia representa "todos".
grau_de_instrucao = ["", "ANALFABETO", "ATE 5.A INC", "5.A CO FUND", "6. A 9. FUND",
"FUND COMPL", "MEDIO INCOMP", "MEDIO COMPL",'SUP. INCOMP', "SUP. COMP", "MESTRADO", "DOUTORADO"]

# Faixas etárias. A string vazia representa "todos".
idades = ["", "14 a 17", "18 a 24", "25 a 39", "40 a 59", "60 ou mais"]

# CLT. A string vazia representa "todos".
clt = ["","SIM","NÃO"]

dic_meses24 = { # Dicionário que mapeia o ano e mês de início para uma lista de meses subsequentes
    202401.0: ["fevereiro", "março", "abril", "maio", "junho",
               "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"], # Meses de janeiro a dezembro
    202402.0: ["fevereiro", "março", "abril", "maio", "junho",
               "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"], # Meses de fevereiro a dezembro
    202403.0: ["março", "abril", "maio", "junho",
               "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"], # Meses de março a dezembro
    202404.0: ["abril", "maio", "junho",
               "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"], # Meses de abril a dezembro
    202405.0: ["maio", "junho",
               "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"], # Meses de maio a dezembro
    202406.0: ["junho", "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"], # Meses de junho a dezembro
    202407.0: ["julho", "agosto", "setembro", "outubro", "novembro", "dezembro"], # Meses de julho a dezembro
    202408.0: ["agosto", "setembro", "outubro", "novembro", "dezembro"], # Meses de agosto a dezembro
    202409.0: ["setembro", "outubro", "novembro", "dezembro"], # Meses de setembro a dezembro
    202410.0: ["outubro", "novembro", "dezembro"], # Meses de outubro a dezembro
    202411.0: ["novembro", "dezembro"], # Meses de novembro a dezembro
    202412.0: ["dezembro"] # Mês de dezembro
}

# --- Funções de utilidade ---

# Função lambda para converter um DataFrame em uma lista de tuplas,
# excluindo a primeira coluna (geralmente o índice).
def listar_dados(df):
    return [tuple(dados) for dados in df.itertuples(index = False)]

compts = lambda dados: dados['competênciamov'].unique()

def lista_de_combinacoes(n, compt=False):
    global variaveis, variaveis_compt
    lista_var = variaveis_compt if compt else variaveis
    try:
        return [list(comb) for comb in combinations(lista_var, n)]
    except:
        print("Erro ao gerar as combinações entre as colunas")


def busca_linear(lista, local_, sexo_, raca_, idade_, gdi_, clt_):
    try:
        for i in lista:
            if i[:6] == (local_, sexo_, raca_, idade_, gdi_, clt_):
                return i[6]
        return 0
    except Exception as e:
        print(f"Erro na busca: {e}")
        
def construir_dict_compt(df):
    return {
        (
            i[0],                        # compt
            str(i[1]).strip(),           # local
            str(i[2]).strip(),           # sexo
            str(i[3]).strip(),           # raca
            str(i[4]).strip(),           # idade
            str(i[5]).strip(),           # gdi
            str(i[6]).strip()            # clt
        ): i[7]                         # valor
        for i in df.itertuples(index=False)
    }

def busca_linear_compt(dicionario, compt_, local_, sexo_, raca_, idade_, gdi_, clt_):
    chave = (
        compt_,
        str(local_).strip(),
        str(sexo_).strip(),
        str(raca_).strip(),
        str(idade_).strip(),
        str(gdi_).strip(),
        str(clt_).strip()
    )
    return dicionario.get(chave, 0)
