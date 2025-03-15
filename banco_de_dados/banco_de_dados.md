# Criação de Banco de Dados

## Banco de Dados RAIS

### Extração dos Dados
Os dados serão extraídos via API da plataforma [Base dos Dados](https://basedosdados.org/). O objetivo é construir um banco de dados com as seguintes colunas:

- **local**: Localização geográfica do dado.
- **sexo**: Gênero dos indivíduos.
- **raça**: Raça/cor conforme classificação oficial.
- **grau de instrução**: Nível educacional atingido.
- **estoque**: Contagem referente à consulta na API da Base dos Dados.

## Banco de Dados CAGED Movimentações

### Processamento das Movimentações Mensais de 2022
Os dados das movimentações do CAGED serão processados para a construção de um banco de dados. As colunas incluídas serão:

- **local**: Localização geográfica do dado.
- **sexo**: Gênero dos indivíduos.
- **raça**: Raça/cor conforme classificação oficial.
- **grau de instrução**: Nível educacional atingido.
- **cnae**: Classificação Nacional de Atividades Econômicas.
- **número de admissões**: Contagem das admissões filtradas por local, sexo, raça, grau de instrução e cnae.
- **número de demissões**: Contagem das demissões filtradas pelos mesmos critérios.

## Banco de Dados CAGED Fora do Prazo

### Processamento das Movimentações Fora do Prazo de 2022
Este banco de dados conterá informações sobre as movimentações declaradas fora do prazo. As colunas serão:

- **local**: Localização geográfica do dado.
- **sexo**: Gênero dos indivíduos.
- **raça**: Raça/cor conforme classificação oficial.
- **grau de instrução**: Nível educacional atingido.
- **cnae**: Classificação Nacional de Atividades Econômicas.
- **número de admissões**: Contagem das admissões filtradas por local, sexo, raça, grau de instrução e cnae.
- **número de demissões**: Contagem das demissões filtradas pelos mesmos critérios.

## Banco de Dados CAGED Exclusões

### Processamento das Movimentações Excluídas de 2022
O banco de dados armazenará informações sobre movimentações que foram excluídas do sistema do CAGED. As colunas incluídas serão:

- **local**: Localização geográfica do dado.
- **sexo**: Gênero dos indivíduos.
- **raça**: Raça/cor conforme classificação oficial.
- **grau de instrução**: Nível educacional atingido.
- **cnae**: Classificação Nacional de Atividades Econômicas.
- **número de admissões**: Contagem das admissões filtradas por local, sexo, raça, grau de instrução e cnae.
- **número de demissões**: Contagem das demissões filtradas pelos mesmos critérios.

