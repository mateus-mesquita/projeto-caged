# Criando função de consultar estoque Rais:

funcao_estoque_rais = function(local, sexo, raca, grau_de_instrucao, cnae) {
  
  if (local == "" & sexo == "" & raca == "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 1: Todos vazios
    return(consulta_geral_rais(ano = 2022))
  } else if (local != "" & sexo == "" & raca == "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 2: Apenas local preenchido
    return(consulta_estado_rais(ano = 2022,uf = local))
  } else if (local == "" & sexo != "" & raca == "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 3: Apenas sexo preenchido
    return(consulta_sexo_rais(ano = 2022,sexo = sexo))
  } else if (local == "" & sexo == "" & raca != "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 4: Apenas raca preenchida
    return(consulta_raca_rais(ano = 2022,raca= raca))
  } else if (local == "" & sexo == "" & raca == "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 5: Apenas grau_de_instrucao preenchido
    return(consulta_grau_de_instrucao_rais(ano=2022,gdi=grau_de_instrucao))
  } else if (local == "" & sexo == "" & raca == "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 6: Apenas cnae preenchido
    return(consulta_cnae_rais(ano=2022,cnae=cnae))
  } else if (local != "" & sexo != "" & raca == "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 7: local e sexo preenchidos
    return(consulta_estado_sexo_rais(ano=2022,uf=local,sexo=sexo))
  } else if (local != "" & sexo == "" & raca != "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 8: local e raca preenchidos
    return(consulta_estado_raca_rais(ano=2022,uf=local,raca=raca))
  } else if (local != "" & sexo == "" & raca == "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 9: local e grau_de_instrucao preenchidos
    return(consulta_estado_gdi_rais(ano = 2022, uf = local, gdi=grau_de_instrucao))
  } else if (local != "" & sexo == "" & raca == "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 10: local e cnae preenchidos
    return(consulta_estado_cnae_rais(ano=2022,uf=local,cnae=cnae))
  } else if (local == "" & sexo != "" & raca != "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 11: sexo e raca preenchidos
    return(consulta_sexo_raca_rais(ano=2022,sexo=sexo,raca=raca))
  } else if (local == "" & sexo != "" & raca == "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 12: sexo e grau_de_instrucao preenchidos
    return(consulta_sexo_gdi_rais(ano = 2022,sexo=sexo,gdi=grau_de_instrucao))
  } else if (local == "" & sexo != "" & raca == "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 13: sexo e cnae preenchidos
    return(consulta_sexo_cnae_rais(ano = 2022, sexo = sexo,cnae=cnae))
  } else if (local == "" & sexo == "" & raca != "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 14: raca e grau_de_instrucao preenchidos
    return(consulta_raca_gdi_rais(ano = 2022, raca=raca, gdi=grau_de_instrucao))
  } else if (local == "" & sexo == "" & raca != "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 15: raca e cnae preenchidos
    return(consulta_raca_cnae_rais(ano=2022,raca=raca,cnae=cnae))
  } else if (local == "" & sexo == "" & raca == "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 16: grau_de_instrucao e cnae preenchidos
    return(consulta_grau_de_instrucao_cnae_rais(ano=2022,gdi=grau_de_instrucao,cnae=cnae))
  } else if (local != "" & sexo != "" & raca != "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 17: local, sexo e raca preenchidos
    return(consulta_estado_sexo_raca_rais(ano=2022,uf=local,sexo=sexo,raca=raca))
  } else if (local != "" & sexo != "" & raca == "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 18: local, sexo e grau_de_instrucao preenchidos
    return(consulta_estado_sexo_gdi_rais(ano=2022,uf = local,sexo=sexo,gdi=grau_de_instrucao))
  } else if (local != "" & sexo != "" & raca == "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 19: local, sexo e cnae preenchidos
    return(consulta_estado_sexo_cnae_rais(ano = 2022,uf=local,sexo=sexo,cnae=cnae))
  } else if (local != "" & sexo == "" & raca != "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 20: local, raca e grau_de_instrucao preenchidos
    return(consulta_estado_raca_gdi_rais(ano = 2022,uf=local,raca=raca,gdi = grau_de_instrucao))
  } else if (local != "" & sexo == "" & raca != "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 21: local, raca e cnae preenchidos
    return(consulta_estado_raca_cnae_rais(ano = 2022,uf=local,raca=raca,cnae=cnae))
  } else if (local != "" & sexo == "" & raca == "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 22: local, grau_de_instrucao e cnae preenchidos
    return(consulta_estado_grau_de_instrucao_cnae_rais(ano = 2022, uf = local, gdi=grau_de_instrucao,cnae=cnae))
  } else if (local == "" & sexo != "" & raca != "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 23: sexo, raca e grau_de_instrucao preenchidos
    return(consulta_sexo_raca_gdi_rais(ano=2022,sexo = sexo,raca=raca,gdi = grau_de_instrucao))
  } else if (local == "" & sexo != "" & raca != "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 24: sexo, raca e cnae preenchidos
    return(consulta_sexo_raca_cnae(ano=2022,sexo=sexo,raca=raca,cnae=cnae))
  } else if (local == "" & sexo != "" & raca == "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 25: sexo, grau_de_instrucao e cnae preenchidos
    return(consulta_sexo_grau_de_instrucao_cnae_rais(ano=2022,sexo=sexo,gdi=grau_de_instrucao,cnae=cnae))
  } else if (local == "" & sexo == "" & raca != "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 26: raca, grau_de_instrucao e cnae preenchidos
    return(consulta_raca_gdi_cnae_rais(ano=2022,raca=raca,gdi=grau_de_instrucao,cnae=cnae))
  } else if (local != "" & sexo != "" & raca != "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 27: local, sexo, raca e grau_de_instrucao preenchidos
    return(consulta_estado_sexo_raca_gdi_rais(ano=2022,uf=local,sexo=sexo,raca=raca,gdi=grau_de_instrucao))
  } else if (local != "" & sexo != "" & raca != "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 28: local, sexo, raca e cnae preenchidos
    return(consulta_estado_raca_gdi_cnae_rais(ano = 2022,uf=local,raca=raca,gdi=grau_de_instrucao,cnae=cnae))
  } else if (local != "" & sexo != "" & raca == "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 29: local, sexo, grau_de_instrucao e cnae preenchidos
    return(consulta_estado_sexo_gdi_cnae_rais(ano=2022,uf=local,sexo=sexo,gdi=grau_de_instrucao,cnae=cnae))
  } else if (local != "" & sexo == "" & raca != "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 30: local, raca, grau_de_instrucao e cnae 
    return(consulta_estado_raca_gdi_cnae_rais(ano=2022,uf=local,raca=raca,gdi=grau_de_instrucao,cnae =cnae))
  } else if (local == "" & sexo != "" & raca != "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 31: sexo, raca, grau_de_instrucao e cnae preenchidos
    return(consulta_sexo_raca_gdi_cnae_rais(ano = 2022,sexo=sexo,raca=raca,gdi=grau_de_instrucao,cnae=cnae))
  } else {
    # Caso 32: Todos preenchidos
    return(consulta_todas_variaveis(ano =2022,uf=local,sexo=sexo,raca=raca,gdi=grau_de_instrucao,cnae=cnae))
  }
}
