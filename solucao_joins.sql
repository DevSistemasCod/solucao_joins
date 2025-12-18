-- 1) Liste o nome do funcionário e o nome do departamento em que eles trabalham
SELECT f.nome_funcionario AS nomes, d.nome_depto AS departamento 
FROM funcionario f INNER JOIN departamento d 
ON f.sigla_depto = d.sigla_depto;

-- 2) Liste o nome do projeto e o nome do departamento que supervisiona o projeto.
SELECT p.nome_projeto AS projeto, d.nome_depto AS departamento
FROM projeto p INNER JOIN departamento d
ON p.sigla_depto = d.sigla_depto;

-- 3) Liste os nomes dos funcionários e o nome dos projetos em que eles trabalham apenas para o departamento de Vendas.
select f.nome_funcionario, p.nome_projeto
from funcionario f 
inner join projeto p
on f.codigo_funcionario = p.codigo_funcionario
inner join departamento d
on f.sigla_depto = d.sigla_depto
where d.nome_depto = 'Vendas';

--  4) Liste todos os funcionários e seus projetos, mesmo que eles não estejam associados a nenhum projeto.
SELECT f.nome_funcionario, p.nome_projeto
FROM funcionario f
LEFT JOIN projeto p 
ON f.codigo_funcionario = p.codigo_funcionario;

-- 5) Liste todos os departamentos e seus funcionários, mesmo que alguns não tenham funcionários, ordenando por nome do departamento.
SELECT d.nome_depto, f.nome_funcionario
FROM departamento d
LEFT JOIN funcionario f 
ON d.sigla_depto = f.sigla_depto
ORDER BY d.nome_depto;

--  6) Liste cada departamento e a quantidade de projetos supervisionados por ele. Departamentos sem projetos também devem aparecer com total igual a 0.
SELECT d.nome_depto, COUNT(p.sigla_projeto) AS total_projetos
FROM departamento d
LEFT JOIN projeto p 
ON d.sigla_depto = p.sigla_depto
GROUP BY d.nome_depto
ORDER BY total_projetos DESC;

--  7) Liste todos os departamentos que possuem funcionários e mostre o salário médio dos seus funcionários.
SELECT d.nome_depto, AVG(f.salario) AS salario_medio
FROM departamento d
RIGHT JOIN funcionario f 
ON d.sigla_depto = f.sigla_depto
GROUP BY d.nome_depto
ORDER BY salario_medio DESC;


-- 8) Liste todos os departamentos e a quantidade de  funcionários vinculados a cada um, garantindo que funcionários sem departamento também apareçam na contagem geral.
SELECT d.nome_depto, COUNT(f.codigo_funcionario) AS total_funcionarios
FROM departamento d
RIGHT JOIN funcionario f
ON d.sigla_depto = f.sigla_depto
GROUP BY d.nome_depto
ORDER BY total_funcionarios DESC;

-- 9 Liste cada departamento da empresa e associe-o a todos os funcionários, calculando a média salarial geral da empresa para cada departamento (para fins de análise organizacional).
SELECT f1.nome_funcionario, COUNT(*) 
AS qtd_funcionarios_que_ganham_mais 
FROM funcionario f1 
CROSS JOIN funcionario f2 
WHERE f2.salario > f1.salario 
GROUP BY f1.nome_funcionario 
ORDER BY qtd_funcionarios_que_ganham_mais DESC;

-- 10 Exiba os funcionários que ganham mais que seus colegas do mesmo departamento (self join).
SELECT f1.nome_funcionario, f1.sigla_depto, COUNT(f2.codigo_funcionario) AS qtd_colegas_que_ganham_menos
FROM funcionario f1
LEFT JOIN funcionario f2
ON f1.sigla_depto = f2.sigla_depto
AND f2.salario < f1.salario
GROUP BY f1.nome_funcionario, f1.sigla_depto
ORDER BY qtd_colegas_que_ganham_menos DESC;

-- 11) Liste todos os funcionários e o nome dos projetos em que trabalham, bem como todos os projetos e o nome dos funcionários associados a eles.
SELECT f1.nome_funcionario, p1.nome_projeto
FROM funcionario f1
LEFT JOIN projeto p1 ON f1.codigo_funcionario = p1.codigo_funcionario
UNION ALL
SELECT f2.nome_funcionario, p2.nome_projeto
FROM funcionario f2
RIGHT JOIN projeto p2 ON f2.codigo_funcionario = p2.codigo_funcionario;
