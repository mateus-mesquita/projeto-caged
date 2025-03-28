## Alternativas para a coleta de dados via API - Base dos dados

Durante a extração das informações, nos deparamos com os seguintes problemas:
- A extração é um processo lento.
- Existe um limite disponível de consultas pelo Google Cloud, usando o plano gratuito.
- Realizar várias consultas em curto espaço de tempo pode gerar erros.

Para tentar superar esses impasses, serão feitas duas alternativas:

- **Alternativa 1:**  
Realizar a iteração dos valores e anexar em uma lista por índices, ao mesmo tempo em que adiciona no banco de dados. Em caso de erro, verificar dentro do banco de dados qual o último valor adicionado e continuar após esse ponto. Ou seja, será um checkpoint.

Exemplo do código:


- **Alternativa 2:**  
Realizar um número X de consultas e iterações e adicionar no banco de dados. Após isso, definir uma pausa até voltar a adicionar os dados novamente, desde que seja a cada X consultas e iterações.

Exemplo do código:

