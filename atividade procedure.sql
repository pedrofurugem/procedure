SET SERVEROUTPUT ON;

--1. Considerando o modelo da aula passada,
--1.1 Escreva uma procedure que exibe o nome de uma disciplina cujo
--id deve ser passado como parâmetro.
CREATE OR REPLACE PROCEDURE nome_disciplina (id NUMBER) IS
BEGIN
   dbms_output.put_line('Caluculo' || id);
END;

--1.2 Escreva uma function que devolve o nome do curso de um aluno
--cujo id deve ser passado como parâmetro.
CREATE OR REPLACE FUNCTION nome_curso (id NUMBER)
RETURN NUMBER IS
BEGIN
 dbms_output.put_line('Calculo');
 RETURN id;
END;

--1.3 Crie uma sequence e uma trigger para cada tabela, a fim de gerar
--seus valores de chave primária automaticamente. Cursos devem ter id
--ímpar. Os ids de alunos devem ser múltiplos de 7, começando no
--primeiro a partir de 1000.

--tabela curso
CREATE TABLE tb_curso (id INT PRIMARY KEY, nome VARCHAR2 (200));
--tabela aluno
CREATE TABLE tb_aluno (id INT PRIMARY KEY, nome VARCHAR2 (200));

--cria uma sequence para curso
CREATE SEQUENCE seq_pk_tb_curso START WITH 1 INCREMENT BY 1 CACHE 20;
--cria uma sequence para aluno
CREATE SEQUENCE seq_pk_tb_aluno START WITH 1 INCREMENT BY 1 CACHE 20;


--cria uma trigger para curso
CREATE TRIGGER t_pk_curso_seq BEFORE INSERT ON
tb_curso
FOR EACH ROW
BEGIN
:NEW.id := seq_pk_curso.NEXTVAL;
END;
--insere "--994 1001 são multiplos de 7, mas vou começar pelo 1000"
INSERT INTO tb_curso (id, nome) VALUES (1000, 'Calculo');
INSERT INTO tb_curso (id, nome) VALUES (994, 'Engenharia');
INSERT INTO tb_curso (id, nome) VALUES (987, 'Programação Linear');
--seleciona
SELECT * FROM tb_curso;

--cria uma trigger para aluno
CREATE TRIGGER t_pk_aluno_seq BEFORE INSERT ON
tb_aluno
FOR EACH ROW
BEGIN
:NEW.id := seq_pk_aluno.NEXTVAL;
END;
--insere
INSERT INTO tb_aluno (id, nome) VALUES (1, 'Julia');
INSERT INTO tb_aluno (id, nome) VALUES (3, 'Leo');
INSERT INTO tb_aluno (id, nome) VALUES (5, 'Pedro');
--seleciona
SELECT * FROM tb_aluno;


--1.4 Crie uma tabela de log que deverá armazenar as seguintes
--informações sobre operações realizadas no banco.
--- data e hora da operação
--- tipo da operação (pode ser insert, update ou delete)
---A tabela de log será: tb_log (id, data_hora, operacao)
CREATE TABLE tb_log (data_hora TIMESTAMP);
CREATE TRIGGER tg_registra_log AFTER INSERT ON tb_aluno
FOR EACH ROW
BEGIN
 INSERT INTO tb_log VALUES (CURRENT_TIMESTAMP);
END;



