.PHONY:		all re clean fclean norme debug

SERV_NAME = server
CLIENT_NAME = client
SERV_DIR = ./servers/
CLIENT_DIR = ./clients/
LIBFTDIR = ./libft/
LIBFT = $(LIBFTDIR)libft.a
INCLD_LIBFT = -I ./libft/includes/
SERV_INCLD = -I ./servers/
CLIENT_INCLD = -I ./clients/
CC = gcc
CFLAGS = -Wall -Wextra -Werror $(SERV_INCLD) $(CLIENT_INCLD) $(INCLD_LIBFT) -O3 -MD

SERV_FILES = server.c
CLIENT_FILES = client.c

SERV_SRC = $(addprefix $(SERV_DIR), $(SERV_FILES))
SERV_OBJS = $(SERV_SRC:.c=.o)
SERV_D_FILES = $(SERV_SRC:.c=.d)

CLIENT_SRC = $(addprefix $(CLIENT_DIR), $(CLIENT_FILES))
CLIENT_OBJS = $(CLIENT_SRC:.c=.o)
CLIENT_D_FILES = $(CLIENT_SRC:.c=.d)

all: $(SERV_NAME) $(CLIENT_NAME)

debug: CFLAGS += -fsanitize=address -g
debug: all

$(SERV_NAME): $(SERV_OBJS) | tools
		$(CC) $(CFLAGS) $(LIBFT) $(SERV_OBJS) -o $(SERV_NAME)
include $(wildcard $(SERV_D_FILES))

$(CLIENT_NAME): $(CLIENT_OBJS) | tools
		$(CC) $(CFLAGS) $(LIBFT) $(CLIENT_OBJS) -o $(CLIENT_NAME)
include $(wildcard $(D_FILES))

tools:
		make -C $(LIBFTDIR)
norme: fclean
		norminette ./servers/* ./clients/*
		make -C $(LIBFTDIR) norme

clean:
		rm -f $(SERV_OBJS) $(SERV_D_FILES) $(CLIENT_OBJS) $(CLIENT_D_FILES)
		make -C $(LIBFTDIR) clean
fclean: clean
		rm -f ${SERV_NAME} $(CLIENT_NAME)
		make -C $(LIBFTDIR) fclean

re: fclean all
