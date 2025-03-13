# Criando função de consultar estoque Rais:

funcao_estoque_rais = function(local, sexo, raca, grau_de_instrucao, cnae) {
  
  if (local == "" & sexo == "" & raca == "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 1: Todos vazios
  } else if (local != "" & sexo == "" & raca == "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 2: Apenas local preenchido
  } else if (local == "" & sexo != "" & raca == "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 3: Apenas sexo preenchido
  } else if (local == "" & sexo == "" & raca != "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 4: Apenas raca preenchida
  } else if (local == "" & sexo == "" & raca == "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 5: Apenas grau_de_instrucao preenchido
  } else if (local == "" & sexo == "" & raca == "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 6: Apenas cnae preenchido
  } else if (local != "" & sexo != "" & raca == "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 7: local e sexo preenchidos
  } else if (local != "" & sexo == "" & raca != "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 8: local e raca preenchidos
  } else if (local != "" & sexo == "" & raca == "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 9: local e grau_de_instrucao preenchidos
  } else if (local != "" & sexo == "" & raca == "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 10: local e cnae preenchidos
  } else if (local == "" & sexo != "" & raca != "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 11: sexo e raca preenchidos
  } else if (local == "" & sexo != "" & raca == "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 12: sexo e grau_de_instrucao preenchidos
  } else if (local == "" & sexo != "" & raca == "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 13: sexo e cnae preenchidos
  } else if (local == "" & sexo == "" & raca != "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 14: raca e grau_de_instrucao preenchidos
  } else if (local == "" & sexo == "" & raca != "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 15: raca e cnae preenchidos
  } else if (local == "" & sexo == "" & raca == "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 16: grau_de_instrucao e cnae preenchidos
  } else if (local != "" & sexo != "" & raca != "" & grau_de_instrucao == "" & cnae == "") {
    # Caso 17: local, sexo e raca preenchidos
  } else if (local != "" & sexo != "" & raca == "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 18: local, sexo e grau_de_instrucao preenchidos
  } else if (local != "" & sexo != "" & raca == "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 19: local, sexo e cnae preenchidos
  } else if (local != "" & sexo == "" & raca != "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 20: local, raca e grau_de_instrucao preenchidos
  } else if (local != "" & sexo == "" & raca != "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 21: local, raca e cnae preenchidos
  } else if (local != "" & sexo == "" & raca == "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 22: local, grau_de_instrucao e cnae preenchidos
  } else if (local == "" & sexo != "" & raca != "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 23: sexo, raca e grau_de_instrucao preenchidos
  } else if (local == "" & sexo != "" & raca != "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 24: sexo, raca e cnae preenchidos
  } else if (local == "" & sexo != "" & raca == "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 25: sexo, grau_de_instrucao e cnae preenchidos
  } else if (local == "" & sexo == "" & raca != "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 26: raca, grau_de_instrucao e cnae preenchidos
  } else if (local != "" & sexo != "" & raca != "" & grau_de_instrucao != "" & cnae == "") {
    # Caso 27: local, sexo, raca e grau_de_instrucao preenchidos
  } else if (local != "" & sexo != "" & raca != "" & grau_de_instrucao == "" & cnae != "") {
    # Caso 28: local, sexo, raca e cnae preenchidos
  } else if (local != "" & sexo != "" & raca == "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 29: local, sexo, grau_de_instrucao e cnae preenchidos
  } else if (local != "" & sexo == "" & raca != "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 30: local, raca, grau_de_instrucao e cnae preenchidos
  } else if (local == "" & sexo != "" & raca != "" & grau_de_instrucao != "" & cnae != "") {
    # Caso 31: sexo, raca, grau_de_instrucao e cnae preenchidos
  } else {
    # Caso 32: Todos preenchidos
  }
}
