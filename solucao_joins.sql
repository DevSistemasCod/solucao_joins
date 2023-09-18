-- INNER
-- 1) Liste o nome do funcionário e o nome do departamento em que eles trabalham
SELECT f.nome_funcionario AS nomes,  d.nome_depto AS departamento 
FROM funcionario f INNER JOIN departamento d 
ON f.sigla_depto = d.sigla_depto;

-- 2) Liste o nome do projeto e o nome do departamento que supervisiona o projeto.
SELECT p.nome_projeto AS projeto, d.nome_depto AS departamento
FROM projeto p INNER JOIN departamento d
ON p.sigla_depto = d.sigla_depto;

-- 3) Liste os nomes dos funcionários e o nome dos projetos em que eles trabalham apenas para o departamento de Vendas.
SELECT f.nome_funcionario, p.nome_projeto
FROM funcionario f
INNER JOIN projeto p ON f.codigo_funcionario = p.codigo_funcionario
INNER JOIN departamento d ON f.sigla_depto = d.sigla_depto
WHERE d.nome_depto = 'Vendas';

-- LEFT
--  4) Liste todos os funcionários e seus projetos, mesmo que eles não estejam associados a nenhum projeto.
SELECT f.nome_funcionario, p.nome_projeto
FROM funcionario f
LEFT JOIN projeto p ON f.codigo_funcionario = p.codigo_funcionario;

-- 5) Liste todos os departamentos e seus funcionários, mesmo que alguns departamentos não tenham funcionários.
SELECT d.nome_depto, f.nome_funcionario
FROM departamento d
LEFT JOIN funcionario f ON d.sigla_depto = f.sigla_depto;

--  6) Liste todos os projetos e o nome dos funcionários que estão associados a eles, incluindo os projetos sem funcionários.
SELECT p.nome_projeto, f.nome_funcionario
FROM projeto p
LEFT JOIN funcionario f ON p.codigo_funcionario = f.codigo_funcionario;

-- RIGHT
-- 7) Liste todos os funcionários que estão associados a projetos e o nome dos projetos.
SELECT f.nome_funcionario, p.nome_projeto
FROM funcionario f
RIGHT JOIN projeto p ON f.codigo_funcionario = p.codigo_funcionario;

--  8) Liste todos os departamentos que têm funcionários e o nome dos funcionários
SELECT d.nome_depto, f.nome_funcionario
FROM departamento d
RIGHT JOIN funcionario f ON d.sigla_depto = f.sigla_depto;

-- 9)  Liste todos os projetos e o nome dos funcionários que estão associados a eles, incluindo os projetos sem funcionários
SELECT p.nome_projeto, f.nome_funcionario
FROM projeto p
RIGHT JOIN funcionario f ON p.codigo_funcionario = f.codigo_funcionario;

-- FULL JOIN
-- 10) Liste todos os funcionários e o nome dos projetos em que trabalham, bem como todos os projetos e o nome dos funcionários associados a eles.
SELECT f1.nome_funcionario, p1.nome_projeto
FROM funcionario f1
LEFT JOIN projeto p1 ON f1.codigo_funcionario = p1.codigo_funcionario
UNION ALL
SELECT f2.nome_funcionario, p2.nome_projeto
FROM funcionario f2
RIGHT JOIN projeto p2 ON f2.codigo_funcionario = p2.codigo_funcionario;

-- 11 )  Liste todos os departamentos e a quantidade de funcionários que eles têm, incluindo os departamentos sem funcionários, bem como todos os funcionários e o nome dos departamentos em que trabalham, incluindo aqueles que não têm departamentos atribuídos.
SELECT d1.nome_depto, COUNT(f1.codigo_funcionario) AS qtd_funcionarios
FROM departamento d1
LEFT JOIN funcionario f1 ON d1.sigla_depto = f1.sigla_depto
GROUP BY d1.nome_depto
UNION ALL
SELECT f2.nome_funcionario, d2.nome_depto 
FROM funcionario f2
LEFT JOIN departamento d2 ON f2.sigla_depto = d2.sigla_depto;
