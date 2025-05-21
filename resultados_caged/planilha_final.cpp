#include <Rcpp.h>
#include <algorithm>
#include <R.h>
#include <Rinternals.h>
#include <regex>
#include <string>

using namespace std;
using namespace Rcpp;


// Criando função de consulta do banco de dados:
int consulta_rais(Rcpp::String uf, Rcpp::String sexo,
                  Rcpp::String cor, Rcpp::String idade,Rcpp::String instrucao,
                  Rcpp::String setor)
{
  // acessando funções do usúario:
  Rcpp::Environment global_env = Rcpp::Environment::global_env(); // ambiente global
  Rcpp::Function query_estoque = global_env["query_estoque"];     // acessando função de consulta da Rais

  return (Rcpp::as<int>(query_estoque(sexo, cor, uf, idade,instrucao,setor)));
}

// criando função query mov

int query_mov(Rcpp::String mes, Rcpp::String uf, Rcpp::String sexo, Rcpp::String cor,
              Rcpp::String idade,Rcpp::String instrucao, Rcpp::String setor,bool condicao)
{
  // acessando a função query_mov
  Rcpp::Environment global_env = Rcpp::Environment::global_env();
  Rcpp::Function query_mov = global_env["query_mov"];

  return (Rcpp::as<int>(query_mov(mes, uf, sexo, cor, idade,instrucao, 
                                  setor,condicao)));
}

// criando função query for

int query_for(Rcpp::String mes, Rcpp::String uf, Rcpp::String sexo, Rcpp::String cor,
              Rcpp::String idade ,Rcpp::String instrucao, Rcpp::String setor,bool condicao)
{
  // acessando a função query_mov
  Rcpp::Environment global_env = Rcpp::Environment::global_env();
  Rcpp::Function query_for = global_env["query_for"];

  return (Rcpp::as<int>(query_for(mes, uf, sexo, cor, idade,instrucao, 
                                  setor,condicao)));
}

// criando função query exc
int query_exc(Rcpp::String mes, Rcpp::String uf, Rcpp::String sexo, Rcpp::String cor,
              Rcpp::String idade ,Rcpp::String instrucao, Rcpp::String setor,bool condicao)
{
  // acessando a função query_mov
  Rcpp::Environment global_env = Rcpp::Environment::global_env();
  Rcpp::Function query_exc = global_env["query_exc"];

  return (Rcpp::as<int>(query_exc(mes, uf, sexo, cor, idade,instrucao, 
                                  setor,condicao)));
}

// [[Rcpp::export]]
Rcpp::DataFrame enumerarConjuntos(Rcpp::CharacterVector vec1, Rcpp::CharacterVector vec2,
                                  Rcpp::CharacterVector vec3, Rcpp::CharacterVector vec4,
                                  Rcpp::CharacterVector vec5, Rcpp::CharacterVector vec6)
{

  int comb = vec1.size() * vec2.size() * vec3.size() * vec4.size() * vec5.size() * vec6.size(); // total de combinações

  // Definição das colunas do DataFrame

  // Vetores coluna que armazenam informações categóricas
  Rcpp::CharacterVector UF(comb);    // Coluna que armazena os estados (Unidades Federativas - UF)
  Rcpp::CharacterVector SEXO(comb);  // Coluna que armazena o sexo das pessoas
  Rcpp::CharacterVector RACA(comb);  // Coluna que armazena a raça/cor das pessoas
  Rcpp::CharacterVector IDADE(comb);  // Coluna que armazena as idades
  Rcpp::CharacterVector GDI(comb);   // Coluna que armazena os graus de instrução
  Rcpp::CharacterVector CNAE(comb);
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
      for (Rcpp::String idade_ : vec4)
        {
        for(Rcpp::String gdi_ : vec5)
          {
          for(Rcpp::String setor_ : vec6)
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
            IDADE[i] = idade_;
            GDI[i] = gdi_;   // adicionando grau de instrução
            CNAE[i] = setor_;

            // Cálculo do total de cada mês com base nas consultas
            int janeiro_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
              + query_mov("janeiro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
              - query_mov("janeiro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
              + query_for("janeiro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
              - query_for("janeiro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
              - query_exc("janeiro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
              + query_exc("janeiro", local_, sexo_, cor_, idade_, gdi_, setor_, false);
              
              int fevereiro_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
                + query_mov("Fevereiro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                - query_mov("Fevereiro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                + query_for("fevereiro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                - query_for("fevereiro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                - query_exc("fevereiro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                + query_exc("fevereiro", local_, sexo_, cor_, idade_, gdi_, setor_, false);
                
                int marco_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
                  + query_mov("Março", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                  - query_mov("Março", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                  + query_for("março", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                  - query_for("março", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                  - query_exc("março", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                  + query_exc("março", local_, sexo_, cor_, idade_, gdi_, setor_, false);
                  
                  int abril_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
                    + query_mov("Abril", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                    - query_mov("Abril", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                    + query_for("abril", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                    - query_for("abril", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                    - query_exc("abril", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                    + query_exc("abril", local_, sexo_, cor_, idade_, gdi_, setor_, false);
                    
                    int maio_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
                      + query_mov("Maio", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                      - query_mov("Maio", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                      + query_for("maio", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                      - query_for("maio", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                      - query_exc("maio", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                      + query_exc("maio", local_, sexo_, cor_, idade_, gdi_, setor_, false);
                      
                      int junho_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
                        + query_mov("Junho", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                        - query_mov("Junho", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                        + query_for("junho", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                        - query_for("junho", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                        - query_exc("junho", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                        + query_exc("junho", local_, sexo_, cor_, idade_, gdi_, setor_, false);
                        
                        int julho_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
                          + query_mov("Julho", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                          - query_mov("Julho", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                          + query_for("julho", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                          - query_for("julho", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                          - query_exc("julho", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                          + query_exc("julho", local_, sexo_, cor_, idade_, gdi_, setor_, false);
                          
                          int agosto_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
                            + query_mov("Agosto", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                            - query_mov("Agosto", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                            + query_for("agosto", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                            - query_for("agosto", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                            - query_exc("agosto", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                            + query_exc("agosto", local_, sexo_, cor_, idade_, gdi_, setor_, false);
                            
                            int setembro_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
                              + query_mov("Setembro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                              - query_mov("Setembro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                              + query_for("setembro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                              - query_for("setembro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                              - query_exc("setembro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                              + query_exc("setembro", local_, sexo_, cor_, idade_, gdi_, setor_, false);
                              
                              int outubro_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
                                + query_mov("Outubro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                                - query_mov("Outubro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                                + query_for("outubro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                                - query_for("outubro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                                - query_exc("outubro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                                + query_exc("outubro", local_, sexo_, cor_, idade_, gdi_, setor_, false);
                                
                                int novembro_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
                                  + query_mov("Novembro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                                  - query_mov("Novembro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                                  + query_for("novembro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                                  - query_for("novembro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                                  - query_exc("novembro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                                  + query_exc("novembro", local_, sexo_, cor_, idade_, gdi_, setor_, false);
                                  
                                  int dezembro_ = consulta_rais(local_, sexo_, cor_, idade_, gdi_, setor_)
                                    + query_mov("Dezembro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                                    - query_mov("Dezembro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                                    + query_for("dezembro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                                    - query_for("dezembro", local_, sexo_, cor_, idade_, gdi_, setor_, false)
                                    - query_exc("dezembro", local_, sexo_, cor_, idade_, gdi_, setor_, true)
                                    + query_exc("dezembro", local_, sexo_, cor_, idade_, gdi_, setor_, false);
                                    
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
   }
  }
  // Criando o dataframe:
  Rcpp::DataFrame tabela = Rcpp::DataFrame::create(Named("estado") = UF,
                                                   Named("sexo") = SEXO,
                                                   Named("cor") = RACA,
                                                   Named("idade") = IDADE,
                                                   Named("grau de instrução") = GDI,
                                                   Named("seção") = CNAE,
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