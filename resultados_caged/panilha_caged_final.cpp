#include <Rcpp.h>
#include <algorithm>
#include <R.h>
#include <Rinternals.h>
#include <regex>
#include <string>

using namespace std;
using namespace Rcpp;

// funções de contagem de movimentações
bool busca(Rcpp::String texto)
{
  std::regex padrao("Admissao");
  std::string texto_ = texto;
  return (std::regex_search(texto_, padrao));
}

// [[Rcpp::export]]
// função contador de movimentações
int contador(Rcpp::CharacterVector dados_alterado, Rcpp::LogicalVector condicao)
{
  int admissoes = 0; // admissões
  int demissoes = 0; // demissões

  for (int i = 0; i < dados_alterado.size(); i++)
  {
    if (busca(dados_alterado[i]))
    {                 // aplicando Regex
      admissoes += 1; // incrementando as ademissões
    }
    else
    {
      demissoes += 1; // incrementanddo as demissões
    }
  }
  if (Rcpp::as<bool>(condicao) == true)
  {                     // convertendo o tipo de dado da variável condicao
    return (admissoes); // para booleano c++
  }
  else
  {
    return (demissoes);
  }
}

// Criando função de consulta do banco de dados:
int consulta_rais(Rcpp::String uf, Rcpp::String sexo,
                  Rcpp::String cor, Rcpp::String instrucao)
{
  // acessando funções do usúario:
  Rcpp::Environment global_env = Rcpp::Environment::global_env(); // ambiente global
  Rcpp::Function query_estoque = global_env["query_estoque"];     // acessando função de consulta da Rais

  return (Rcpp::as<int>(query_estoque(sexo, cor, uf, instrucao)));
}

// criando função query mov

int query_mov(Rcpp::String mes, Rcpp::String uf, Rcpp::String sexo, Rcpp::String cor,
              Rcpp::String instrucao, bool condicao)
{
  // acessando a função query_mov
  Rcpp::Environment global_env = Rcpp::Environment::global_env();
  Rcpp::Function query_mov = global_env["query_mov"];

  return (Rcpp::as<int>(query_mov(mes, uf, sexo, cor, instrucao, condicao)));
}

// criando função query for

int query_for(Rcpp::String mes, Rcpp::String uf, Rcpp::String sexo, Rcpp::String cor,
              Rcpp::String instrucao, bool condicao)
{
  // acessando a função query_mov
  Rcpp::Environment global_env = Rcpp::Environment::global_env();
  Rcpp::Function query_for = global_env["query_for"];

  return (Rcpp::as<int>(query_for(mes, uf, sexo, cor, instrucao, condicao)));
}

// criando função query exc
int query_exc(Rcpp::String mes, Rcpp::String uf, Rcpp::String sexo, Rcpp::String cor,
              Rcpp::String instrucao, bool condicao)
{
  // acessando a função query_mov
  Rcpp::Environment global_env = Rcpp::Environment::global_env();
  Rcpp::Function query_exc = global_env["query_exc"];

  return (Rcpp::as<int>(query_exc(mes, uf, sexo, cor, instrucao, condicao)));
}

// [[Rcpp::export]]
// Função de contagem de movimentações:
Rcpp::DataFrame movimentacao(Rcpp::DataFrame dados, Rcpp::CharacterVector vec1,
                             Rcpp::CharacterVector vec2, Rcpp::CharacterVector vec3,
                             Rcpp::CharacterVector vec4)
{

  int comb = vec1.size() * vec2.size() * vec3.size() * vec4.size(); // número de elementos do vetor

  // acessando a função filtro
  Rcpp::Environment global_env = Rcpp::Environment::global_env();
  Rcpp::Function filtro = global_env["filtro"];

  // declarando funções

  // vetor coluna estoque - admissões + estoque(rais) - demissões
  Rcpp::IntegerVector ESTOQUE(comb);
  int i = 0;

  for (Rcpp::String local_ : vec1)
  {
    for (Rcpp::String sexo_ : vec2)
    {
      for (Rcpp::String cor_ : vec3)
      {
        for (Rcpp::String gdi_ : vec4)
        {

          Rcpp::CharacterVector dados_filtrados = filtro(dados, local_, sexo_, cor_, gdi_);
          int admissoes = contador(dados_filtrados, true);
          int demissoes = contador(dados_filtrados, false);
          int consulta = consulta_rais(local_, sexo_, cor_, gdi_);

          ESTOQUE[i] = ((admissoes + consulta) - demissoes);
          i += 1;
        }
      }
    }
  }
  Rcpp::DataFrame coluna = Rcpp::DataFrame::create(ESTOQUE);
  return (coluna);
}

// [[Rcpp::export]]
Rcpp::DataFrame enumerarConjuntos(Rcpp::CharacterVector vec1, Rcpp::CharacterVector vec2,
                                  Rcpp::CharacterVector vec3, Rcpp::CharacterVector vec4)
{

  int comb = vec1.size() * vec2.size() * vec3.size() * vec4.size(); // total de combinações

  // Definição das colunas do DataFrame

  // Vetores coluna que armazenam informações categóricas
  Rcpp::CharacterVector UF(comb);    // Coluna que armazena os estados (Unidades Federativas - UF)
  Rcpp::CharacterVector SEXO(comb);  // Coluna que armazena o sexo das pessoas
  Rcpp::CharacterVector RACA(comb);  // Coluna que armazena a raça/cor das pessoas
  Rcpp::CharacterVector GDI(comb);   // Coluna que armazena os graus de instrução
  Rcpp::IntegerVector estoque(comb); // Coluna que armazena o estoque da RAIS (Relação Anual de Informações Sociais)

  // Definição das colunas para os meses do ano
  Rcpp::IntegerVector janeiro(comb);   // Coluna que armazena os dados referentes a janeiro
  Rcpp::IntegerVector fevereiro(comb); // Coluna que armazena os dados referentes a fevereiro
  Rcpp::IntegerVector marco(comb);     // Coluna que armazena os dados referentes a março
  Rcpp::IntegerVector abril(comb);     // Coluna que armazena os dados referentes a abril
  Rcpp::IntegerVector maio(comb);      // Coluna que armazena os dados referentes a maio
  Rcpp::IntegerVector junho(comb);     // Coluna que armazena os dados referentes a junho
  Rcpp::IntegerVector julho(comb);     // Coluna que armazena os dados referentes a julho
  Rcpp::IntegerVector agosto(comb);    // Coluna que armazena os dados referentes a agosto
  Rcpp::IntegerVector setembro(comb);  // Coluna que armazena os dados referentes a setembro
  Rcpp::IntegerVector outubro(comb);   // Coluna que armazena os dados referentes a outubro
  Rcpp::IntegerVector novembro(comb);  // Coluna que armazena os dados referentes a novembro
  Rcpp::IntegerVector dezembro(comb);  // Coluna que armazena os dados referentes a dezembro

  // construindo o dataframe
  int i = 0; // indice
  for (Rcpp::String local_ : vec1)
  {
    for (Rcpp::String sexo_ : vec2)
    {
      for (Rcpp::String cor_ : vec3)
      {
        for (Rcpp::String gdi_ : vec4)
        {

          if (i == comb)
          {
            break;
          }
          else
          {
            // povoando vetores(colunas)
            UF[i] = local_;  // adicionando estado
            SEXO[i] = sexo_; // adicioando sexo
            RACA[i] = cor_;  // adicioando cor
            GDI[i] = gdi_;   // adicionando grau de instrução

            // Cálculo do total de cada mês com base nas consultas
            int janeiro_ = query_mov("janeiro", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("janeiro", local_, sexo_, cor_, gdi_, false) + query_for("janeiro", local_, sexo_, cor_, gdi_, true) - query_for("janeiro", local_, sexo_, cor_, gdi_, false) - query_exc("janeiro", local_, sexo_, cor_, gdi_, true) + query_exc("janeiro", local_, sexo_, cor_, gdi_, false);

            int fevereiro_ = query_mov("Fevereiro", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("Fevereiro", local_, sexo_, cor_, gdi_, false) + query_for("fevereiro", local_, sexo_, cor_, gdi_, true) - query_for("fevereiro", local_, sexo_, cor_, gdi_, false) - query_exc("fevereiro", local_, sexo_, cor_, gdi_, true) + query_exc("fevereiro", local_, sexo_, cor_, gdi_, false);

            int marco_ = query_mov("Março", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("Março", local_, sexo_, cor_, gdi_, false) + query_for("março", local_, sexo_, cor_, gdi_, true) - query_for("março", local_, sexo_, cor_, gdi_, false) - query_exc("março", local_, sexo_, cor_, gdi_, true) + query_exc("março", local_, sexo_, cor_, gdi_, false);

            int abril_ = query_mov("Abril", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("Abril", local_, sexo_, cor_, gdi_, false) + query_for("abril", local_, sexo_, cor_, gdi_, true) - query_for("abril", local_, sexo_, cor_, gdi_, false) - query_exc("abril", local_, sexo_, cor_, gdi_, true) + query_exc("abril", local_, sexo_, cor_, gdi_, false);

            int maio_ = query_mov("Maio", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("Maio", local_, sexo_, cor_, gdi_, false) + query_for("maio", local_, sexo_, cor_, gdi_, true) - query_for("maio", local_, sexo_, cor_, gdi_, false) - query_exc("maio", local_, sexo_, cor_, gdi_, true) + query_exc("maio", local_, sexo_, cor_, gdi_, false);

            int junho_ = query_mov("Junho", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("Junho", local_, sexo_, cor_, gdi_, false) + query_for("junho", local_, sexo_, cor_, gdi_, true) - query_for("junho", local_, sexo_, cor_, gdi_, false) - query_exc("junho", local_, sexo_, cor_, gdi_, true) + query_exc("junho", local_, sexo_, cor_, gdi_, false);

            int julho_ = query_mov("Julho", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("Julho", local_, sexo_, cor_, gdi_, false) + query_for("julho", local_, sexo_, cor_, gdi_, true) - query_for("julho", local_, sexo_, cor_, gdi_, false) - query_exc("julho", local_, sexo_, cor_, gdi_, true) + query_exc("julho", local_, sexo_, cor_, gdi_, false);

            int agosto_ = query_mov("Agosto", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("Agosto", local_, sexo_, cor_, gdi_, false) + query_for("agosto", local_, sexo_, cor_, gdi_, true) - query_for("agosto", local_, sexo_, cor_, gdi_, false) - query_exc("agosto", local_, sexo_, cor_, gdi_, true) + query_exc("agosto", local_, sexo_, cor_, gdi_, false);

            int setembro_ = query_mov("Setembro", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("Setembro", local_, sexo_, cor_, gdi_, false) + query_for("setembro", local_, sexo_, cor_, gdi_, true) - query_for("setembro", local_, sexo_, cor_, gdi_, false) - query_exc("setembro", local_, sexo_, cor_, gdi_, true) + query_exc("setembro", local_, sexo_, cor_, gdi_, false);

            int outubro_ = query_mov("Outubro", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("Outubro", local_, sexo_, cor_, gdi_, false) + query_for("outubro", local_, sexo_, cor_, gdi_, true) - query_for("outubro", local_, sexo_, cor_, gdi_, false) - query_exc("outubro", local_, sexo_, cor_, gdi_, true) + query_exc("outubro", local_, sexo_, cor_, gdi_, false);

            int novembro_ = query_mov("Novembro", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("Novembro", local_, sexo_, cor_, gdi_, false) + query_for("novembro", local_, sexo_, cor_, gdi_, true) - query_for("novembro", local_, sexo_, cor_, gdi_, false) - query_exc("novembro", local_, sexo_, cor_, gdi_, true) + query_exc("novembro", local_, sexo_, cor_, gdi_, false);

            int dezembro_ = query_mov("Dezembro", local_, sexo_, cor_, gdi_, true) + consulta_rais(local_, sexo_, cor_, gdi_) - query_mov("Dezembro", local_, sexo_, cor_, gdi_, false) + query_for("dezembro", local_, sexo_, cor_, gdi_, true) - query_for("dezembro", local_, sexo_, cor_, gdi_, false) - query_exc("dezembro", local_, sexo_, cor_, gdi_, true) + query_exc("dezembro", local_, sexo_, cor_, gdi_, false);

            janeiro[i] = janeiro_;
            fevereiro[i] = janeiro_ + fevereiro_;
            marco[i] = janeiro_ + fevereiro_ + marco_;
            abril[i] = janeiro_ + fevereiro_ + marco_ + abril_;
            maio[i] = janeiro_ + fevereiro_ + marco_ + abril_ + maio_;
            junho[i] = janeiro_ + fevereiro_ + marco_ + abril_ + maio_ + junho_;
            julho[i] = janeiro_ + fevereiro_ + marco_ + abril_ + maio_ + junho_ + julho_;
            agosto[i] = janeiro_ + fevereiro_ + marco_ + abril_ + maio_ + junho_ + julho_ + agosto_;
            setembro[i] = janeiro_ + fevereiro_ + marco_ + abril_ + maio_ + junho_ + julho_ + agosto_ + setembro_;
            outubro[i] = janeiro_ + fevereiro_ + marco_ + abril_ + maio_ + junho_ + julho_ + agosto_ + setembro_ + outubro_;
            novembro[i] = janeiro_ + fevereiro_ + marco_ + abril_ + maio_ + junho_ + julho_ + agosto_ + setembro_ + outubro_ + novembro_;
            dezembro[i] = janeiro_ + fevereiro_ + marco_ + abril_ + maio_ + junho_ + julho_ + agosto_ + setembro_ + outubro_ + novembro_ + dezembro_;
            i += 1;
          }
        }
      }
    }
  }
  // Criando o dataframe:
  Rcpp::DataFrame tabela = Rcpp::DataFrame::create(Named("estado") = UF,
                                                   Named("sexo") = SEXO,
                                                   Named("cor") = RACA,
                                                   Named("grau de instrução") = GDI,
                                                   Named("Janeiro") = janeiro,
                                                   Named("Fevereiro") = fevereiro,
                                                   Named("Março") = marco,
                                                   Named("Abril") = abril,
                                                   Named("Maio") = maio,
                                                   Named("junho") = junho,
                                                   Named("Agosto") = agosto,
                                                   Named("Setembro") = setembro,
                                                   Named("Outubro") = outubro,
                                                   Named("Novembro") = novembro,
                                                   Named("Dezembro") = dezembro);
  return (tabela);
}