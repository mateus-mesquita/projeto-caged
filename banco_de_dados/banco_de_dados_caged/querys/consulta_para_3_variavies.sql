
WITH filtragem AS (
    SELECT *,
        CASE
            WHEN (uf = local_ AND sexo = sexo_ AND raca_ = raca_) THEN TRUE
            WHEN (uf = local_ AND sexo = sexo_ AND faixa_idade = idade_) THEN TRUE
            WHEN (uf = local_ AND sexo = sexo_ AND gdi_ = gdi_) THEN TRUE
            WHEN (uf = local_ AND sexo = sexo_ AND setor_ = setor_) THEN TRUE
            WHEN (uf = local_ AND raca_ = raca_ AND faixa_idade = idade_) THEN TRUE
            WHEN (uf = local_ AND raca_ = raca_ AND gdi_ = gdi_) THEN TRUE
            WHEN (uf = local_ AND raca_ = raca_ AND setor_ = setor_) THEN TRUE
            WHEN (uf = local_ AND faixa_idade = idade_ AND gdi_ = gdi_) THEN TRUE
            WHEN (uf = local_ AND faixa_idade = idade_ AND setor_ = setor_) THEN TRUE
            WHEN (uf = local_ AND gdi_ = gdi_ AND setor_ = setor_) THEN TRUE
            WHEN (sexo = sexo_ AND raca_ = raca_ AND faixa_idade = idade_) THEN TRUE
            WHEN (sexo = sexo_ AND raca_ = raca_ AND gdi_ = gdi_) THEN TRUE
            WHEN (sexo = sexo_ AND raca_ = raca_ AND setor_ = setor_) THEN TRUE
            WHEN (sexo = sexo_ AND faixa_idade = idade_ AND gdi_ = gdi_) THEN TRUE
            WHEN (sexo = sexo_ AND faixa_idade = idade_ AND setor_ = setor_) THEN TRUE
            WHEN (sexo = sexo_ AND gdi_ = gdi_ AND setor_ = setor_) THEN TRUE
            WHEN (raca_ = raca_ AND faixa_idade = idade_ AND gdi_ = gdi_) THEN TRUE
            WHEN (raca_ = raca_ AND faixa_idade = idade_ AND setor_ = setor_) THEN TRUE
            WHEN (raca_ = raca_ AND gdi_ = gdi_ AND setor_ = setor_) THEN TRUE
            WHEN (faixa_idade = idade_ AND gdi_ = gdi_ AND setor_ = setor_) THEN TRUE
            ELSE FALSE
        END AS validacao
)
SELECT uf, sexo, raca_, faixa_idade, gdi_, setor_
FROM filtragem
WHERE validacao = TRUE;
