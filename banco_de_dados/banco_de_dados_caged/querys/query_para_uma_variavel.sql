-- Modelo de consulta para função de filtragem de uma variável

WITH filtragem AS(
	SELECT *,
		CASE
			WHEN uf = local_ THEN TRUE
			WHEN sexo = sexo_ THEN TRUE
			WHEN raçacor = raca_ THEN TRUE
			WHEN faixa_idade = idade_ THEN TRUE
			WHEN graudeinstrução = gdi_ THEN TRUE
			WHEN seção = setor_ THEN TRUE
			ELSE FALSE
		END AS validacao
	FROM tabela
) 

SELECT uf,sexo,raçacor,faixa_idade,graudeinstrução,seção,tipomovimentação FROM filtragem
	WHERE validacao = TRUE;