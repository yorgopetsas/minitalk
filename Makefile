
SHELL		=	/bin/bash

NAME		= client
NAMESV		= server

INC			= inc
HEADER		= inc/minitalk.h
SRC_DIR		= src/
OBJ_DIR		= obj/

CC			= gcc
FLAGS		= -Wall -Werror -Wextra

RM			= rm -f
ECHO		= echo -e

DEF_COLOR	=	\033[0;39m
ORANGE		=	\033[0;33m
GRAY		=	\033[0;90m
RED			=	\033[0;91m
GREEN		=	\033[1;92m
YELLOW		=	\033[1;93m
BLUE		=	\033[0;94m
MAGENTA		=	\033[0;95m
CYAN		=	\033[0;96m
WHITE		=	\033[0;97m

SRCCL_FILES	=	client
SRCSV_FILES	=	server

SRCCL 		= 	$(addprefix $(SRC_DIR), $(addsuffix .c, $(SRCCL_FILES)))
OBJCL 		= 	$(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRCCL_FILES)))

SRCSV 		= 	$(addprefix $(SRC_DIR), $(addsuffix .c, $(SRCSV_FILES)))
OBJSV 		= 	$(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRCSV_FILES)))

all:		$(NAME) $(NAMESV)

$(NAME):	$(OBJCL)
			@$(CC) $(FLAGS) $(OBJCL) -o $(NAME)

$(NAMESV):	$(OBJSV)
			@$(ECHO) -n "$(RED)]$(DEF_COLOR)"
			@$(ECHO) -n "$(GREEN) => 100%$(DEF_COLOR)\n"
			@$(ECHO) -n "$(YELLOW)[minitalk]:\t$(DEF_COLOR)"
			@$(CC) $(FLAGS) $(OBJSV) -o $(NAMESV)
			@$(ECHO) "$(GREEN) => Success!$(DEF_COLOR)"

$(OBJ_DIR)%.o: $(SRC_DIR)%.c $(HEADER) $(OBJF)
			@$(ECHO) -n "$(ORANGE)=$(DEF_COLOR) to $(CYAN)$@$(DEF_COLOR)"
			@$(CC) $(FLAGS) -c $< -o $@
			@$(ECHO) -n "$(GREEN) Done!$(DEF_COLOR)"

$(OBJF):
			@mkdir -p $(OBJ_DIR)
			@touch $(OBJF)

clean:
			@$(RM) $(OBJ_DIR)*.o
			@$(ECHO) -n "$(BLUE)[minitalk]:\tobject files$(DEF_COLOR)$(GREEN)  => Cleaned!$(DEF_COLOR)\n"

fclean:		clean
			@$(RM) $(NAME) $(NAMESV)
			@find . -name ".DS_Store" -delete
			@$(ECHO) -n "$(CYAN)[minitalk]:\texec. files$(DEF_COLOR)$(GREEN)  => Cleaned!$(DEF_COLOR)\n"

re:			fclean all
			@$(ECHO) -n "$(GREEN)Cleaned and rebuilt everything for [minitalk]!$(DEF_COLOR)\n"

.PHONY:		all clean fclean re

