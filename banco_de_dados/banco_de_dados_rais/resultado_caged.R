# Criando planilha final
con_for = RSQLite::dbConnect(SQLite(),"cagedfor.db")
con_exc = RSQLite::dbConnect(SQLite(),"cagedexc.db")
con_mov = RSQLite::dbConnect(SQLite(),"cagedmov.db")

comb = length(local)*length(raca_cor)*length(sexo)*length(idades)*length(setores)*length(grau_de_instrucao)


mes_janeiro <- function(conexao_for,conexao_mov,conexao_exc,vec1,vec2,vec3,
                        vec4,vec5,vec6){
  i = 1
  n = length(vec1)*length(vec2)*length(vec3)*length(vec4)*length(vec5)*length(vec6)
  
  JANEIRO = numeric(n)
  for(local_ in local){
    for(sexo_ in sexo){
      for(raca_ in raca_cor){
        for(idade_ in idades){
          for(gdi_ in grau_de_instrucao){
            for(cnae_ in setores){
              
              janeiro_ = contagem.mov.mov("CAGEDMOV202201", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202201", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202201", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202201", con_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202201", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202201", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              JANEIRO[i] = janeiro_
              
              cat(local_,sexo_,raca_,idade_,gdi_,cnae_,JANEIRO[i],
                  "\n")
              i = i + 1
            }
          }
        }
      }
    }
  }
  return(JANEIRO)
}

mes_fevereiro <- function(conexao_for, conexao_mov, conexao_exc, vec1, vec2, vec3,
                          vec4, vec5, vec6){
  i <- 1
  n <- length(vec1) * length(vec2) * length(vec3) * length(vec4) * length(vec5) * length(vec6)
  
  FEVEREIRO <- numeric(n)
  
  for(local_ in vec1){
    for(sexo_ in vec2){
      for(raca_ in vec3){
        for(idade_ in vec4){
          for(gdi_ in vec5){
            for(cnae_ in vec6){
              
              fevereiro_ <- contagem.mov.mov("CAGEDMOV202202", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202202", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202202", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202202", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202202", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202202", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              FEVEREIRO[i] <- fevereiro_
              
              cat(local_, sexo_, raca_, idade_, gdi_, cnae_, FEVEREIRO[i], "\n")
              i <- i + 1
            }
          }
        }
      }
    }
  }
  
  return(FEVEREIRO)
}

mes_marco <- function(conexao_for, conexao_mov, conexao_exc, vec1, vec2, vec3,
                      vec4, vec5, vec6){
  i <- 1
  n <- length(vec1) * length(vec2) * length(vec3) * length(vec4) * length(vec5) * length(vec6)
  
  MARCO <- numeric(n)
  
  for(local_ in vec1){
    for(sexo_ in vec2){
      for(raca_ in vec3){
        for(idade_ in vec4){
          for(gdi_ in vec5){
            for(cnae_ in vec6){
              
              marco_ <- contagem.mov.mov("CAGEDMOV202203", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202203", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202203", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202203", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202203", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202203", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              MARCO[i] <- marco_
              
              cat(local_, sexo_, raca_, idade_, gdi_, cnae_, MARCO[i], "\n")
              i <- i + 1
            }
          }
        }
      }
    }
  }
  
  return(MARCO)
}

mes_abril <- function(conexao_for, conexao_mov, conexao_exc, vec1, vec2, vec3,
                      vec4, vec5, vec6){
  i <- 1
  n <- length(vec1) * length(vec2) * length(vec3) * length(vec4) * length(vec5) * length(vec6)
  
  ABRIL <- numeric(n)
  
  for(local_ in vec1){
    for(sexo_ in vec2){
      for(raca_ in vec3){
        for(idade_ in vec4){
          for(gdi_ in vec5){
            for(cnae_ in vec6){
              
              abril_ <- contagem.mov.mov("CAGEDMOV202204", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202204", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202204", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202204", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202204", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202204", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              ABRIL[i] <- abril_
              
              cat(local_, sexo_, raca_, idade_, gdi_, cnae_, ABRIL[i], "\n")
              i <- i + 1
            }
          }
        }
      }
    }
  }
  
  return(ABRIL)
}

mes_maio <- function(conexao_for, conexao_mov, conexao_exc, vec1, vec2, vec3,
                     vec4, vec5, vec6){
  i <- 1
  n <- length(vec1) * length(vec2) * length(vec3) * length(vec4) * length(vec5) * length(vec6)
  
  MAIO <- numeric(n)
  
  for(local_ in vec1){
    for(sexo_ in vec2){
      for(raca_ in vec3){
        for(idade_ in vec4){
          for(gdi_ in vec5){
            for(cnae_ in vec6){
              
              maio_ <- contagem.mov.mov("CAGEDMOV202205", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202205", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202205", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202205", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202205", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202205", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              MAIO[i] <- maio_
              
              cat(local_, sexo_, raca_, idade_, gdi_, cnae_, MAIO[i], "\n")
              i <- i + 1
            }
          }
        }
      }
    }
  }
  
  return(MAIO)
}

mes_junho <- function(conexao_for, conexao_mov, conexao_exc, vec1, vec2, vec3,
                      vec4, vec5, vec6){
  i <- 1
  n <- length(vec1) * length(vec2) * length(vec3) * length(vec4) * length(vec5) * length(vec6)
  
  JUNHO <- numeric(n)
  
  for(local_ in vec1){
    for(sexo_ in vec2){
      for(raca_ in vec3){
        for(idade_ in vec4){
          for(gdi_ in vec5){
            for(cnae_ in vec6){
              
              junho_ <- contagem.mov.mov("CAGEDMOV202206", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202206", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202206", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202206", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202206", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202206", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              JUNHO[i] <- junho_
              
              cat(local_, sexo_, raca_, idade_, gdi_, cnae_, JUNHO[i], "\n")
              i <- i + 1
            }
          }
        }
      }
    }
  }
  
  return(JUNHO)
}

mes_julho <- function(conexao_for, conexao_mov, conexao_exc, vec1, vec2, vec3,
                      vec4, vec5, vec6){
  i <- 1
  n <- length(vec1) * length(vec2) * length(vec3) * length(vec4) * length(vec5) * length(vec6)
  
  JULHO <- numeric(n)
  
  for(local_ in vec1){
    for(sexo_ in vec2){
      for(raca_ in vec3){
        for(idade_ in vec4){
          for(gdi_ in vec5){
            for(cnae_ in vec6){
              
              julho_ <- contagem.mov.mov("CAGEDMOV202207", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202207", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202207", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202207", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202207", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202207", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              JULHO[i] <- julho_
              
              cat(local_, sexo_, raca_, idade_, gdi_, cnae_, JULHO[i], "\n")
              i <- i + 1
            }
          }
        }
      }
    }
  }
  
  return(JULHO)
}

mes_agosto <- function(conexao_for, conexao_mov, conexao_exc, vec1, vec2, vec3,
                       vec4, vec5, vec6){
  i <- 1
  n <- length(vec1) * length(vec2) * length(vec3) * length(vec4) * length(vec5) * length(vec6)
  
  AGOSTO <- numeric(n)
  
  for(local_ in vec1){
    for(sexo_ in vec2){
      for(raca_ in vec3){
        for(idade_ in vec4){
          for(gdi_ in vec5){
            for(cnae_ in vec6){
              
              agosto_ <- contagem.mov.mov("CAGEDMOV202208", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202208", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202208", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202208", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202208", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202208", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              AGOSTO[i] <- agosto_
              
              cat(local_, sexo_, raca_, idade_, gdi_, cnae_, AGOSTO[i], "\n")
              i <- i + 1
            }
          }
        }
      }
    }
  }
  
  return(AGOSTO)
}

mes_setembro <- function(conexao_for, conexao_mov, conexao_exc, vec1, vec2, vec3,
                         vec4, vec5, vec6){
  i <- 1
  n <- length(vec1) * length(vec2) * length(vec3) * length(vec4) * length(vec5) * length(vec6)
  
  SETEMBRO <- numeric(n)
  
  for(local_ in vec1){
    for(sexo_ in vec2){
      for(raca_ in vec3){
        for(idade_ in vec4){
          for(gdi_ in vec5){
            for(cnae_ in vec6){
              
              setembro_ <- contagem.mov.mov("CAGEDMOV202209", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202209", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202209", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202209", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202209", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202209", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              SETEMBRO[i] <- setembro_
              
              cat(local_, sexo_, raca_, idade_, gdi_, cnae_, SETEMBRO[i], "\n")
              i <- i + 1
            }
          }
        }
      }
    }
  }
  
  return(SETEMBRO)
}

mes_outubro <- function(conexao_for, conexao_mov, conexao_exc, vec1, vec2, vec3,
                        vec4, vec5, vec6){
  i <- 1
  n <- length(vec1) * length(vec2) * length(vec3) * length(vec4) * length(vec5) * length(vec6)
  
  OUTUBRO <- numeric(n)
  
  for(local_ in vec1){
    for(sexo_ in vec2){
      for(raca_ in vec3){
        for(idade_ in vec4){
          for(gdi_ in vec5){
            for(cnae_ in vec6){
              
              outubro_ <- contagem.mov.mov("CAGEDMOV202210", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202210", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202210", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202210", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202210", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202210", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              OUTUBRO[i] <- outubro_
              
              cat(local_, sexo_, raca_, idade_, gdi_, cnae_, OUTUBRO[i], "\n")
              i <- i + 1
            }
          }
        }
      }
    }
  }
  
  return(OUTUBRO)
}

mes_novembro <- function(conexao_for, conexao_mov, conexao_exc, vec1, vec2, vec3,
                         vec4, vec5, vec6){
  i <- 1
  n <- length(vec1) * length(vec2) * length(vec3) * length(vec4) * length(vec5) * length(vec6)
  
  NOVEMBRO <- numeric(n)
  
  for(local_ in vec1){
    for(sexo_ in vec2){
      for(raca_ in vec3){
        for(idade_ in vec4){
          for(gdi_ in vec5){
            for(cnae_ in vec6){
              
              novembro_ <- contagem.mov.mov("CAGEDMOV202211", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202211", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202211", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202211", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202211", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202211", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              NOVEMBRO[i] <- novembro_
              
              cat(local_, sexo_, raca_, idade_, gdi_, cnae_, NOVEMBRO[i], "\n")
              i <- i + 1
            }
          }
        }
      }
    }
  }
  
  return(NOVEMBRO)
}

mes_dezembro <- function(conexao_for, conexao_mov, conexao_exc, vec1, vec2, vec3,
                         vec4, vec5, vec6){
  i <- 1
  n <- length(vec1) * length(vec2) * length(vec3) * length(vec4) * length(vec5) * length(vec6)
  
  DEZEMBRO <- numeric(n)
  
  for(local_ in vec1){
    for(sexo_ in vec2){
      for(raca_ in vec3){
        for(idade_ in vec4){
          for(gdi_ in vec5){
            for(cnae_ in vec6){
              
              dezembro_ <- contagem.mov.mov("CAGEDMOV202212", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.mov("CAGEDMOV202212", conexao_mov, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov.for_("CAGEDFOR202212", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov_demissoes.for_("CAGEDFOR202212", conexao_for, local_, sexo_, raca_, idade_, gdi_, cnae_) -
                contagem.mov.exc("CAGEDEXC202212", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_) +
                contagem.mov_demissoes.exc("CAGEDEXC202212", conexao_exc, local_, sexo_, raca_, idade_, gdi_, cnae_)
              
              DEZEMBRO[i] <- dezembro_
              
              cat(local_, sexo_, raca_, idade_, gdi_, cnae_, DEZEMBRO[i], "\n")
              i <- i + 1
            }
          }
        }
      }
    }
  }
  
  return(DEZEMBRO)
}

# Chamadas das funções
resultado_janeiro <- mes_janeiro(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)
resultado_fevereiro <- mes_fevereiro(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)
resultado_marco <- mes_marco(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)
resultado_abril <- mes_abril(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)
resultado_maio <- mes_maio(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)
resultado_junho <- mes_junho(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)
resultado_julho <- mes_julho(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)
resultado_agosto <- mes_agosto(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)
resultado_setembro <- mes_setembro(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)
resultado_outubro <- mes_outubro(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)
resultado_novembro <- mes_novembro(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)
resultado_dezembro <- mes_dezembro(con_for, con_mov, con_exc, local, sexo, raca_cor, idades, grau_de_instrucao, setores)

janeiro <- resultado_janeiro
fevereiro <- janeiro + resultado_fevereiro
marco <- fevereiro + resultado_marco
abril <- marco + resultado_abril
maio <- abril + resultado_maio
junho <- maio + resultado_junho
julho <- junho + resultado_julho
agosto <- julho + resultado_agosto
setembro <- agosto + resultado_setembro
outubro <- setembro + resultado_outubro
novembro <- outubro + resultado_novembro
dezembro <- novembro + resultado_dezembro

df = tidyr::expand_grid(local,sexo,raca_cor,idades,grau_de_instrucao,setores)

df[['janeiro']] <- janeiro
df[['fevereiro']] <- fevereiro
df[['março']] <- marco
df[['abril']] <- abril
df[['maio']] <- maio
df[['junho']] <- junho
df[['julho']] <- julho
df[['agosto']] <- agosto
df[['setembro']] <- setembro
df[['outubro']] <- outubro
df[['novembro']] <- novembro
df[['dezembro']] <- dezembro

