.PHONY:		all re clean fclean norme

SERV_NAME = server
CLIENT_NAME = client

B_SERV_NAME = server_bonus
B_CLIENT_NAME = client_bonus

LIBFTDIR = ./libft/
LIBFT = $(LIBFTDIR)libft.a
INCLD_LIBFT = -I ./libft/includes/

SERV_DIR = ./servers/
CLIENT_DIR = ./clients/
SERV_INCLD = -I ./servers/
CLIENT_INCLD = -I ./clients/

B_SERV_DIR = ./bonus/servers/
B_CLIENT_DIR = ./bonus/clients/
B_SERV_INCLD = -I ./bonus/servers/
B_CLIENT_INCLD = -I ./bonus/clients/

CC = gcc

CFLAGS = -Wall -Wextra -Werror $(SERV_INCLD) $(CLIENT_INCLD) $(INCLD_LIBFT) -O3 -MD
B_CFLAGS = -Wall -Wextra -Werror $(B_SERV_INCLD) $(B_CLIENT_INCLD) $(INCLD_LIBFT) -O3 -MD

SERV_FILES = server.c
CLIENT_FILES = client.c
SERV_SRC = $(addprefix $(SERV_DIR), $(SERV_FILES))
SERV_OBJS = $(SERV_SRC:.c=.o)
SERV_D_FILES = $(SERV_SRC:.c=.d)
CLIENT_SRC = $(addprefix $(CLIENT_DIR), $(CLIENT_FILES))
CLIENT_OBJS = $(CLIENT_SRC:.c=.o)
CLIENT_D_FILES = $(CLIENT_SRC:.c=.d)


B_SERV_FILES = server_bonus.c
B_CLIENT_FILES = client_bonus.c
B_SERV_SRC = $(addprefix $(B_SERV_DIR), $(B_SERV_FILES))
B_CLIENT_SRC = $(addprefix $(B_CLIENT_DIR), $(B_CLIENT_FILES))
B_SERV_OBJS = $(B_SERV_SRC:.c=.o)
B_SERV_D_FILES = $(B_SERV_SRC:.c=.d)
B_CLIENT_OBJS = $(B_CLIENT_SRC:.c=.o)
B_CLIENT_D_FILES = $(B_CLIENT_SRC:.c=.d)

all: $(SERV_NAME) $(CLIENT_NAME)

$(SERV_NAME): $(SERV_OBJS) | tools
		$(CC) $(CFLAGS) $(LIBFT) $(SERV_OBJS) -o $(SERV_NAME)
include $(wildcard $(SERV_D_FILES))

$(CLIENT_NAME): $(CLIENT_OBJS) | tools
		$(CC) $(CFLAGS) $(LIBFT) $(CLIENT_OBJS) -o $(CLIENT_NAME)
include $(wildcard $(CLIENT_D_FILES))

tools:
		make -C $(LIBFTDIR)
norme: fclean
		norminette ./servers/* ./clients/* ./bonus/servers/* ./bonus/clients/*
		make -C $(LIBFTDIR) norme
bonus: $(B_SERV_NAME) $(B_CLIENT_NAME)

$(B_SERV_NAME): $(B_SERV_OBJS) | tools
		$(CC) $(B_CFLAGS) $(LIBFT) $(B_SERV_OBJS) -o $(B_SERV_NAME)
include $(wildcard $(B_SERV_D_FILES))

$(B_CLIENT_NAME): $(B_CLIENT_OBJS) | tools
		$(CC) $(B_CFLAGS) $(LIBFT) $(B_CLIENT_OBJS) -o $(B_CLIENT_NAME)
include $(wildcard $(B_CLIENT_D_FILES))

clean:
		rm -f $(SERV_OBJS) $(SERV_D_FILES) $(CLIENT_OBJS) $(CLIENT_D_FILES)
		rm -f $(B_SERV_OBJS) $(B_SERV_D_FILES) $(B_CLIENT_OBJS) $(B_CLIENT_D_FILES)
		make -C $(LIBFTDIR) clean
fclean: clean
		rm -f ${SERV_NAME} $(CLIENT_NAME) $(B_CLIENT_NAME) $(B_SERV_NAME)
		make -C $(LIBFTDIR) fclean

re: fclean all
