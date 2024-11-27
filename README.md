# Projeto RAIS(Relação Anual de Informações Sociais)

inserir uma breve descrição.

## Colata dos dados:

Por causa da grande quantidade de dados, baixar os dados da RAIS diretamente para o computador não
foi uma opção. Entretando, atráves do banco de dados, da empresa base dos dados, foi possível realizar
consultas e guardar nossas variáveis em um banco de dados próprio.

Embora a ferramenta principal desse projeto seja o R, para essa foi utilizado o python.
caso use os códigos para gerar outro banco de dados, ou algo parecido. Deve-se realizar as seguintes
instalações no jupyter ou colab:
```
!pip install basedosdados

!pip uninstall -y shapely pygeos geopandas
# Install specific versions of shapely, pygeos, and geopandas known to be compatible
!pip install shapely==1.8.5.post1 pygeos==0.12.0 geopandas==0.10.2
# Upgrade google-cloud-aiplatform
!pip install -U google-cloud-aiplatform

```
e depois essas importações:
```
import sqlite3
import basedosdados as bd
import pandas as pd
import numpy as np
```