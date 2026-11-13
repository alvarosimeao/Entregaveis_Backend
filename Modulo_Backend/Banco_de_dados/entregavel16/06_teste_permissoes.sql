-- Executar após 04_seguranca.sql como usuário que possa SET ROLE.
-- O DELETE deve falhar com "permission denied"; não corresponde a dado real.
SET ROLE loja_analista;
SELECT COUNT(*) AS produtos_visiveis FROM loja_backend.produtos;
DELETE FROM loja_backend.produtos WHERE sku = 'SKU-INEXISTENTE';
RESET ROLE;
