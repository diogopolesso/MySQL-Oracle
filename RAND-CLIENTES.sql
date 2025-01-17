-- Função que obtem um CLIENTE de forma aleatória.

-- OBS: Normalmente, as instalações MySQL não permitem que você crie funções.
-- para o ambiente MySQL poder criar funções é preciso estipular um parâmetro:

SET GLOBAL LOG_BIN_TRUST_FUNCTION_CREATORS = 1;

-- DEPOIS = CREATE FUNCTION:

DROP function IF EXISTS `f_cliente_aleatorio`;

DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `f_cliente_aleatorio`() RETURNS varchar(11)
BEGIN
    declare vRetorno varchar(11);
    declare num_max_tabela int;
    declare num_aleatorio int;
    select count(*) into num_max_tabela from tabela_de_clientes;
    set num_aleatorio = f_numero_aleatorio(1, num_max_tabela);
    set num_aleatorio = num_aleatorio - 1;
    select CPF into vRetorno from tabela_de_clientes limit num_aleatorio, 1;
RETURN vRetorno;
END$$

DELIMITER ;

select f_cliente_aleatorio(); -- RESULTADO = Cada vez que rodar essa função ela me tras um CPF ALEATÓRIO.

