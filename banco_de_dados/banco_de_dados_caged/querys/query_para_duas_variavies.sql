-- Consulta que deve servir de modelo para função de filtragem - duas variáveis

WITH filtragem AS (
SELECT *,
    CASE 
        WHEN (uf = local_ AND sexo = sexo_) THEN TRUE
        WHEN (uf = local_ AND racaçor = racaçor_) THEN TRUE
        WHEN (uf = local_ AND faixa_idade = faixa_idade_) THEN TRUE
        WHEN (uf = local_ AND graudeinstrução = grau_) THEN TRUE
        WHEN (uf = local_ AND seção = secao_) THEN TRUE

        WHEN (sexo = sexo_ AND racaçor = racaçor_) THEN TRUE
        WHEN (sexo = sexo_ AND faixa_idade = faixa_idade_) THEN TRUE
        WHEN (sexo = sexo_ AND graudeinstrução = grau_) THEN TRUE
        WHEN (sexo = sexo_ AND seção = secao_) THEN TRUE

        WHEN (racaçor = racaçor_ AND faixa_idade = faixa_idade_) THEN TRUE
        WHEN (racaçor = racaçor_ AND graudeinstrução = grau_) THEN TRUE
        WHEN (racaçor = racaçor_ AND seção = secao_) THEN TRUE

        WHEN (faixa_idade = faixa_idade_ AND graudeinstrução = grau_) THEN TRUE
        WHEN (faixa_idade = faixa_idade_ AND seção = secao_) THEN TRUE

        WHEN (graudeinstrução = grau_ AND seção = secao_) THEN TRUE

        ELSE FALSE
    END AS validacao
FROM sua_tabela
) 
SELECT uf,sexo,raçacor,faixa_idade,graudeinstrução,seção,tipomovimentação FROM filtragem
	WHERE validacao = TRUE;
