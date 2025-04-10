preprocessamento <- function(arquivo_caged)
{
  # Abrindo os dados
  caged <- read.csv(arquivo_caged, sep=";")
  
  inicial <- ncol(caged)
  
  # Idade
  # Nada a fazer.
  
  # Sexo
  caged$sexo[caged$sexo==1] <- 'Masculino'
  caged$sexo[caged$sexo==3] <- 'Feminino'
  caged$sexo[caged$sexo==9] <- 'Não informado'
  
  # UF Nomeado
    caged$uf[caged$uf == 11] <- 'RO'
    caged$uf[caged$uf == 12] <- 'AC'
    caged$uf[caged$uf == 13] <- 'AM'
    caged$uf[caged$uf == 14] <- 'RR'
    caged$uf[caged$uf == 15] <- 'PA'
    caged$uf[caged$uf == 16] <- 'AP'
    caged$uf[caged$uf == 17] <- 'TO'
    caged$uf[caged$uf == 21] <- 'MA'
    caged$uf[caged$uf == 22] <- 'PI'
    caged$uf[caged$uf == 23] <- 'CE'
    caged$uf[caged$uf == 24] <- 'RN'
    caged$uf[caged$uf == 25] <- 'PB'
    caged$uf[caged$uf == 26] <- 'PE'
    caged$uf[caged$uf == 27] <- 'AL'
    caged$uf[caged$uf == 28] <- 'SE'
    caged$uf[caged$uf == 29] <- 'BA'
    caged$uf[caged$uf == 31] <- 'MG'
    caged$uf[caged$uf == 32] <- 'ES'
    caged$uf[caged$uf == 33] <- 'RJ'
    caged$uf[caged$uf == 35] <- 'SP'
    caged$uf[caged$uf == 41] <- 'PR'
    caged$uf[caged$uf == 42] <- 'SC'
    caged$uf[caged$uf == 43] <- 'RS'
    caged$uf[caged$uf == 50] <- 'MS'
    caged$uf[caged$uf == 51] <- 'MT'
    caged$uf[caged$uf == 52] <- 'GO'
    caged$uf[caged$uf == 53] <- 'DF'

  
  # região
  caged$região[caged$região==1] <- 'Norte'
  caged$região[caged$região==2] <- 'Nordeste'
  caged$região[caged$região==3] <- 'Sudeste'
  caged$região[caged$região==4] <- 'Sul'
  caged$região[caged$região==5] <- 'Centro-Oeste'
  caged$região[caged$região==9] <- 'Não identificado'
  
  # raçacor
  caged$raçacor[caged$raçacor==1] <- 'Branca'
  caged$raçacor[caged$raçacor==2] <- 'Preta'
  caged$raçacor[caged$raçacor==3] <- 'Parda'
  caged$raçacor[caged$raçacor==4] <- 'Amarela'
  caged$raçacor[caged$raçacor==5] <- 'Indígena'
  caged$raçacor[caged$raçacor==6] <- 'Não informada'
  caged$raçacor[caged$raçacor==9] <- 'Não identificada'
  
  
  # grau de instrução
  caged$graudeinstrução[caged$graudeinstrução==1] <- "ANALFABETO"
  caged$graudeinstrução[caged$graudeinstrução==2] <- "ATE 5.A INC"
  caged$graudeinstrução[caged$graudeinstrução==3] <- "5.A CO FUND"
  caged$graudeinstrução[caged$graudeinstrução==4] <- "6.A.9.FUND"
  caged$graudeinstrução[caged$graudeinstrução==5] <- "FUND COMPL"
  caged$graudeinstrução[caged$graudeinstrução==6] <- "MEDIO INCOMP"
  caged$graudeinstrução[caged$graudeinstrução==7] <- "MEDIO COMPL"
  caged$graudeinstrução[caged$graudeinstrução==8] <- "SUP.INCOMP"
  caged$graudeinstrução[caged$graudeinstrução==9] <- "SUP.COMP"
  caged$graudeinstrução[caged$graudeinstrução==10] <- "MESTRADO"
  caged$graudeinstrução[caged$graudeinstrução==11] <- "DOUTORADO"
  caged$graudeinstrução[caged$graudeinstrução==80] <- 'Pós-Graduação completa'
  caged$graudeinstrução[caged$graudeinstrução==99] <- 'Não identificado'
  
  # seção
  caged$seção[caged$seção=='A'] <- 'Agricultura, Pecuária, Produção Florestal, Pesca e AqÜIcultura'
  caged$seção[caged$seção=='B'] <- 'Indústrias Extrativas'
  caged$seção[caged$seção=='C'] <- 'Indústrias de Transformação'
  caged$seção[caged$seção=='D'] <- 'Eletricidade e Gás'
  caged$seção[caged$seção=='E'] <- 'Água, Esgoto, Atividades de Gestão de Resíduos e Descontaminação'
  caged$seção[caged$seção=='F'] <- 'Construção'
  caged$seção[caged$seção=='G'] <- 'Comércio, Reparação de Veículos Automotores e Motocicletas'
  caged$seção[caged$seção=='H'] <- 'Transporte, Armazenagem e Correio'
  caged$seção[caged$seção=='I'] <- 'Alojamento e Alimentação'
  caged$seção[caged$seção=='J'] <- 'Informação e Comunicação'
  caged$seção[caged$seção=='K'] <- 'Atividades Financeiras, de Seguros e Serviços Relacionados'
  caged$seção[caged$seção=='L'] <- 'Atividades Imobiliárias'
  caged$seção[caged$seção=='M'] <- 'Atividades Profissionais, Científicas e Técnicas'
  caged$seção[caged$seção=='N'] <- 'Atividades Administrativas e Serviços Complementares'
  caged$seção[caged$seção=='O'] <- 'Administração Pública, Defesa e Seguridade Social'
  caged$seção[caged$seção=='P'] <- 'Educação'
  caged$seção[caged$seção=='Q'] <- 'Saúde Humana e Serviços Sociais'
  caged$seção[caged$seção=='R'] <- 'Artes, Cultura, Esporte e Recreação'
  caged$seção[caged$seção=='S'] <- 'Outras Atividades de Serviços'
  caged$seção[caged$seção=='T'] <- 'Serviços Domésticos'
  caged$seção[caged$seção=='U'] <- 'Organismos Internacionais e Outras Instituições Extraterritoriais'
  caged$seção[caged$seção=='Z'] <- 'Não identificado'
  
  # categoria
  caged$categoria[caged$categoria==101] <- 'Empregado - Geral, inclusive o empregado público da administração direta ou indireta contratado pela CLT'
  caged$categoria[caged$categoria==102] <- 'Empregado - Trabalhador rural por pequeno prazo da Lei 11.718/2008'
  caged$categoria[caged$categoria==103] <- 'Empregado - Aprendiz'
  caged$categoria[caged$categoria==104] <- 'Empregado - Doméstico'
  caged$categoria[caged$categoria==105] <- 'Empregado - Contrato a termo firmado nos termos da Lei 9.601/1998'
  caged$categoria[caged$categoria==106] <- 'Trabalhador temporário - Contrato nos termos da Lei 6.019/1974'
  caged$categoria[caged$categoria==107] <- 'Empregado - Contrato de trabalho Verde e Amarelo - sem acordo para antecipação mensal da multa rescisória do FGTS'
  caged$categoria[caged$categoria==108] <- 'Empregado - Contrato de trabalho Verde e Amarelo - com acordo para antecipação mensal da multa rescisória do FGTS'
  caged$categoria[caged$categoria==111] <- 'Empregado - Contrato de trabalho intermitente'
  caged$categoria[caged$categoria==999] <- 'Não Identificado'
  
  # tipo de movimentação
  caged$tipomovimentação[caged$tipomovimentação==10] <- 'Admissao por primeiro emprego'
  caged$tipomovimentação[caged$tipomovimentação==20] <- 'Admissao por reemprego'
  caged$tipomovimentação[caged$tipomovimentação==25] <- 'Admissao por contrato trabalho prazo determinado'
  caged$tipomovimentação[caged$tipomovimentação==31] <- 'Desligamento por demissão sem justa causa'
  caged$tipomovimentação[caged$tipomovimentação==32] <- 'Desligamento por demissão com justa causa'
  caged$tipomovimentação[caged$tipomovimentação==33] <- 'Culpa Recíproca'
  caged$tipomovimentação[caged$tipomovimentação==35] <- 'Admissao por reintegração'
  caged$tipomovimentação[caged$tipomovimentação==40] <- 'Desligamento a pedido'
  caged$tipomovimentação[caged$tipomovimentação==43] <- 'Término contrato trabalho prazo determinado'
  caged$tipomovimentação[caged$tipomovimentação==45] <- 'Desligamento por Término de contrato'
  caged$tipomovimentação[caged$tipomovimentação==50] <- 'Desligamento por aposentadoria'
  caged$tipomovimentação[caged$tipomovimentação==60] <- 'Desligamento por morte'
  caged$tipomovimentação[caged$tipomovimentação==70] <- 'Admissão por transferência'
  caged$tipomovimentação[caged$tipomovimentação==80] <- 'Desligamento por transferência'
  caged$tipomovimentação[caged$tipomovimentação==90] <- 'Desligamento por Acordo entre empregado e empregador'
  caged$tipomovimentação[caged$tipomovimentação==97] <- 'Admissao de Tipo Ignorado'
  caged$tipomovimentação[caged$tipomovimentação==98] <- 'Desligamento de Tipo Ignorado'
  caged$tipomovimentação[caged$tipomovimentação==99] <- 'Não Identificado'
  
  # excluindo variáveis:
  caged$município <- NULL
  caged$região <- NULL
  caged$subclasse <- NULL
  caged$saldomovimentação <- NULL
  caged$cbo2002ocupação <- NULL
  caged$categoria <- NULL
  caged$idade <- NULL
  caged$horascontratuais <- NULL
  caged$tipoempregador <- NULL
  caged$tipoestabelecimento <- NULL
  caged$tipodedeficiência <- NULL
  caged$indtrabintermitente <- NULL
  caged$indtrabparcial <- NULL
  caged$salário <- NULL
  caged$tamestabjan <- NULL
  caged$indicadoraprendiz <- NULL
  caged$origemdainformação <- NULL
  caged$competênciadec <- NULL
  caged$indicadordeforadoprazo <- NULL
  caged$unidadesaláriocódigo <- NULL
  caged$valorsaláriofixo <- NULL
  
  
  return(caged)
}


