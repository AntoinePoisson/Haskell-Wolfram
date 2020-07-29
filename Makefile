##
## EPITECH PROJECT, 2020
## PSU_nmobjdump_2019
## File description:
## Makefile
##

NAME	=	wolfram

SRC	=	./src/wolfram.hs

SRC_TEST	=	./src/.test_file.hs

FLAG	=	-Wall -W

RM	=	rm -f

CC	=	ghc


all:	name

name:
	ghc -o $(NAME) $(SRC) $(FLAG)

test:
	ghc -o b.out $(SRC_TEST)

clean:
	@$(RM) $(NAME)

fclean:	clean
	@$(RM) vgcore.*
	@$(RM) ./src/*.o
	@$(RM) ./src/*.hi

re: fclean all

.PHONY:	all clean fclean re name test