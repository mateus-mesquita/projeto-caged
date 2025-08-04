import pandas as pd

def preprocessamento(arquivo_caged):
    # Esta função lê e pré-processa um arquivo CSV do CAGED, convertendo
    # códigos numéricos e alfanuméricos em descrições textuais.
    try:
        # Lê o arquivo de texto usando pandas, com o separador ';'.
        caged = pd.read_table(arquivo_caged, sep=";")

        # Mapeia os códigos numéricos da coluna 'sexo' para descrições textuais.
        caged['sexo'] = caged['sexo'].replace({
            1: 'Masculino',
            3: 'Feminino',
            9: 'Não informado'
        })

        # Mapeia os códigos numéricos da coluna 'uf' para as siglas dos estados brasileiros.
        caged['uf'] = caged['uf'].replace({
            11: 'RO', 12: 'AC', 13: 'AM', 14: 'RR', 15: 'PA', 16: 'AP', 17: 'TO',
            21: 'MA', 22: 'PI', 23: 'CE', 24: 'RN', 25: 'PB', 26: 'PE', 27: 'AL', 28: 'SE', 29: 'BA',
            31: 'MG', 32: 'ES', 33: 'RJ', 35: 'SP', 41: 'PR', 42: 'SC', 43: 'RS',
            50: 'MS', 51: 'MT', 52: 'GO', 53: 'DF'
        })

        # Mapeia os códigos numéricos da coluna 'região' para os nomes das regiões.
        caged['região'] = caged['região'].replace({
            1: 'Norte', 2: 'Nordeste', 3: 'Sudeste',
            4: 'Sul', 5: 'Centro-Oeste', 9: 'Não identificado'
        })

        # Mapeia os códigos numéricos da coluna 'raçacor' para as descrições de raça/cor.
        caged['raçacor'] = caged['raçacor'].replace({
            1: 'Branca', 2: 'Preta', 3: 'Parda', 4: 'Amarela',
            5: 'Indígena', 6: 'Não informada', 9: 'Não identificada'
        })

        # Mapeia os códigos numéricos da coluna 'graudeinstrução' para as descrições de escolaridade.
        caged['graudeinstrução'] = caged['graudeinstrução'].replace({
            1: "ANALFABETO", 2: "ATE 5.A INC", 3: "5.A CO FUND", 4: "6.A.9.FUND", 5: "FUND COMPL",
            6: "MEDIO INCOMP", 7: "MEDIO COMPL", 8: "SUP.INCOMP", 9: "SUP.COMP",
            10: "MESTRADO", 11: "DOUTORADO", 80: "Pós-Graduação completa", 99: "Não identificado"
        })

        # Mapeia os códigos alfabéticos da coluna 'seção' para as descrições das atividades econômicas.
        caged['seção'] = caged['seção'].replace({
            'A': 'Agricultura, Pecuária, Produção Florestal, Pesca e AqÜIcultura',
            'B': 'Indústrias Extrativas',
            'C': 'Indústrias de Transformação',
            'D': 'Eletricidade e Gás',
            'E': 'Água, Esgoto, Atividades de Gestão de Resíduos e Descontaminação',
            'F': 'Construção',
            'G': 'Comércio, Reparação de Veículos Automotores e Motocicletas',
            'H': 'Transporte, Armazenagem e Correio',
            'I': 'Alojamento e Alimentação',
            'J': 'Informação e Comunicação',
            'K': 'Atividades Financeiras, de Seguros e Serviços Relacionados',
            'L': 'Atividades Imobiliárias',
            'M': 'Atividades Profissionais, Científicas e Técnicas',
            'N': 'Atividades Administrativas e Serviços Complementares',
            'O': 'Administração Pública, Defesa e Seguridade Social',
            'P': 'Educação',
            'Q': 'Saúde Humana e Serviços Sociais',
            'R': 'Artes, Cultura, Esporte e Recreação',
            'S': 'Outras Atividades de Serviços',
            'T': 'Serviços Domésticos',
            'U': 'Organismos Internacionais e Outras Instituições Extraterritoriais',
            'Z': 'Não identificado'
        })

        # Mapeia os códigos numéricos da coluna 'categoria' para as descrições das categorias de emprego.
        caged['categoria'] = caged['categoria'].replace({
            101: 'Empregado - Geral, inclusive o empregado público da administração direta ou indireta contratado pela CLT',
            102: 'Empregado - Trabalhador rural por pequeno prazo da Lei 11.718/2008',
            103: 'Empregado - Aprendiz',
            104: 'Empregado - Doméstico',
            105: 'Empregado - Contrato a termo firmado nos termos da Lei 9.601/1998',
            106: 'Trabalhador temporário - Contrato nos termos da Lei 6.019/1974',
            107: 'Empregado - Contrato de trabalho Verde e Amarelo - sem acordo para antecipação mensal da multa rescisória do FGTS',
            108: 'Empregado - Contrato de trabalho Verde e Amarelo - com acordo para antecipação mensal da multa rescisória do FGTS',
            111: 'Empregado - Contrato de trabalho intermitente',
            999: 'Não Identificado'
        })

        # Mapeia os códigos numéricos da coluna 'tipomovimentação' para as descrições das movimentações.
        # Note que aqui as descrições são misturadas com tipos de admissão e desligamento.
        caged['tipomovimentação'] = caged['tipomovimentação'].replace({
            10: 'Admissao por primeiro emprego',
            20: 'Admissao por reemprego',
            25: 'Admissao por contrato trabalho prazo determinado',
            31: 'Desligamento por demissão sem justa causa',
            32: 'Desligamento por demissão com justa causa',
            33: 'Culpa Recíproca',
            35: 'Admissao por reintegração',
            40: 'Desligamento a pedido',
            43: 'Término contrato trabalho prazo determinado',
            45: 'Desligamento por Término de contrato',
            50: 'Desligamento por aposentadoria',
            60: 'Desligamento por morte',
            70: 'Admissão por transferência',
            80: 'Desligamento por transferência',
            90: 'Desligamento por Acordo entre empregado e empregador',
            97: 'Admissao de Tipo Ignorado',
            98: 'Desligamento de Tipo Ignorado',
            99: 'Não Identificado'
        })

        # Cria uma nova coluna 'faixa_idade' categorizando a 'idade'.
        # A função `pd.cut` divide a coluna `idade` em faixas (bins) e atribui rótulos (labels).
        caged['faixa_idade'] = pd.cut(
            caged['idade'],
            bins=[14, 17, 24, 39, 59, float('inf')],
            labels=["14 a 17", "18 a 24", "25 a 39", "40 a 59", "60 ou mais"]
        )

        # Define uma lista de colunas a serem excluídas do DataFrame.
        colunas_excluir = [
            'região', 'idade', 'subclasse', 'saldomovimentação', 'categoria',
            'horascontratuais', 'tipoempregador', 'tipoestabelecimento', 'tipodedeficiência',
            'indtrabintermitente', 'indtrabparcial', 'salário', 'tamestabjan', 'indicadoraprendiz',
            'origemdainformação', 'competênciadec', 'indicadordeforadoprazo', 'unidadesaláriocódigo',
            'valorsaláriofixo', 'município', 'seção', 'competênciaexc', 'indicadordeexclusão', 'cbo2002ocupação'
        ]
        # Exclui as colunas do DataFrame, ignorando aquelas que não existirem.
        caged = caged.drop(columns=colunas_excluir, errors='ignore')

        # Retorna o DataFrame já pré-processado.
        return caged
    except FileNotFoundError as e:
        # Lida com o erro de arquivo não encontrado.
        print(e)
        print("Trecho de código: caged = pd.read_table(arquivo_caged, sep=';')")
        print("Erro: O arquivo especificado para leitura não foi encontrado.")
    except ValueError as v:
        # Lida com o erro de arquivo vazio ou inválido.
        print(v)
        print("Trecho de código: caged = pd.read_table(arquivo_caged, sep=';')")
        print("Erro: O arquivo está vazio ou não contém dados válidos.")
    except KeyError as k:
        # Lida com o erro de coluna ausente no DataFrame.
        print(k)
        print("Erro: Uma coluna esperada não foi encontrada no DataFrame. Verifique se o arquivo de entrada possui todas as colunas necessárias.")
    except TypeError as t:
        # Lida com o erro de tipo incompatível na operação de substituição.
        print(e)
        print("Trecho do Código: caged['sexo'] = caged['sexo'].replace(...) (e demais linhas que usam .replace() em colunas)")
        print("Erro: O tipo de dado em uma coluna não é compatível com a operação de substituição esperada.")


def ler_arquivo(caminho):
    # Esta função é uma wrapper que chama a função de pré-processamento.
    try:
        # Chama a função principal de pré-processamento.
        dados = preprocessamento(caminho)
        return dados
    except:
        # Captura e imprime um erro genérico caso o processamento falhe.
        print("Erro ao processar os dados")

def mapeamento_dados(dados):
    # Esta função cria uma nova coluna com um mapeamento específico para 'graudeinstrução'.
    mapeamento = {
        '': '',
        'ANALFABETO': 'ANALFABETO',
        'ATE 5.A INC': 'ATE 5.A INC',
        '5.A CO FUND': '5.A CO FUND',
        '6.A.9.FUND': '6. A 9. FUND',
        'FUND COMPL': 'FUND COMPL',
        'MEDIO INCOMP': 'MEDIO INCOMP',
        'MEDIO COMPL': 'MEDIO COMPL',
        'SUP.INCOMP': 'SUP. INCOMP',
        'SUP.COMP': 'SUP. COMP',
        'MESTRADO': 'MESTRADO',
        'DOUTORADO': 'DOUTORADO'
    }

    # Aplica o mapeamento na coluna 'graudeinstrução' e cria a nova coluna 'grau_instrucao_padrao'.
    # Note que o mapeamento parece ser quase um para um, o que pode ser simplificado.
    dados['grau_instrucao_padrao'] = dados['graudeinstrução'].map(mapeamento)
    return dados


def caged(caminho):
    # Esta é a função principal que orquestra a leitura, pré-processamento e mapeamento dos dados.
    try:
        # Chama `ler_arquivo` para obter o DataFrame pré-processado e, em seguida,
        # chama `mapeamento_dados` para aplicar o mapeamento de escolaridade.
        dados = mapeamento_dados(ler_arquivo(caminho))
        return dados
    except:
        # Lida com falhas genéricas no fluxo do processamento.
        print("Falha ao Processar o arquivo")