# Processamento da Caged For
import pandas as pd
from tqdm import tqdm
import sqlite3

meses = ['janeiro','fevereiro','março','abril','maio','junho','julho','agosto','setembro','outubro','novembro','dezembro']
meses_df_for = {}

dic_for_admissoes = {
    "janeiro_admissao_2024": "janeiro_admissoes_for.csv",
    "fevereiro_admissao_2024": "fevereiro_admissoes_for.csv",
    "marco_admissao_2024": "março_admissoes_for.csv",
    "abril_admissao_2024": "abril_admissoes_for.csv",
    "maio_admissao_2024": "maio_admissoes_for.csv",
    "junho_admissao_2024": "junho_admissoes_for.csv",
    "julho_admissao_2024": "julho_admissoes_for.csv",
    "agosto_admissao_2024": "agosto_admissoes_for.csv",
    "setembro_admissao_2024": "setembro_admissoes_for.csv",
    "outubro_admissao_2024": "outubro_admissoes_for.csv",
    "novembro_admissao_2024": "novembro_admissoes_for.csv",
    "dezembro_admissao_2024": "dezembro_admissoes_for.csv"
}

dic_for_demissoes = {
    "janeiro_demissao_2024": "janeiro_demissoes_for.csv",
    "fevereiro_demissao_2024": "fevereiro_demissoes_for.csv",
    "marco_demissao_2024": "março_demissoes_for.csv",
    "abril_demissao_2024": "abril_demissoes_for.csv",
    "maio_demissao_2024": "maio_demissoes_for.csv",
    "junho_demissao_2024": "junho_demissoes_for.csv",
    "julho_demissao_2024": "julho_demissoes_for.csv",
    "agosto_demissao_2024": "agosto_demissoes_for.csv",
    "setembro_demissao_2024": "setembro_demissoes_for.csv",
    "outubro_demissao_2024": "outubro_demissoes_for.csv",
    "novembro_demissao_2024": "novembro_demissoes_for.csv",
    "dezembro_demissao_2024": "dezembro_demissoes_for.csv"
}

dic_exc_demissoes = {
    "janeiro_demissao_2024": "janeiro_demissoes_exc.csv",
    "fevereiro_demissao_2024": "fevereiro_demissoes_exc.csv",
    "marco_demissao_2024": "março_demissoes_exc.csv",
    "abril_demissao_2024": "abril_demissoes_exc.csv",
    "maio_demissao_2024": "maio_demissoes_exc.csv",
    "junho_demissao_2024": "junho_demissoes_exc.csv",
    "julho_demissao_2024": "julho_demissoes_exc.csv",
    "agosto_demissao_2024": "agosto_demissoes_exc.csv",
    "setembro_demissao_2024": "setembro_demissoes_exc.csv",
    "outubro_demissao_2024": "outubro_demissoes_exc.csv",
    "novembro_demissao_2024": "novembro_demissoes_exc.csv",
    "dezembro_demissao_2024": "dezembro_demissoes_exc.csv"
}

dic_exc_admissoes = {
    "janeiro_admissao_2024": "janeiro_admissoes_exc.csv",
    "fevereiro_admissao_2024": "fevereiro_admissoes_exc.csv",
    "marco_admissao_2024": "março_admissoes_exc.csv",
    "abril_admissao_2024": "abril_admissoes_exc.csv",
    "maio_admissao_2024": "maio_admissoes_exc.csv",
    "junho_admissao_2024": "junho_admissoes_exc.csv",
    "julho_admissao_2024": "julho_admissoes_exc.csv",
    "agosto_admissao_2024": "agosto_admissoes_exc.csv",
    "setembro_admissao_2024": "setembro_admissoes_exc.csv",
    "outubro_admissao_2024": "outubro_admissoes_exc.csv",
    "novembro_admissao_2024": "novembro_admissoes_exc.csv",
    "dezembro_admissao_2024": "dezembro_admissoes_exc.csv"
}


