/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: agigi <agigi@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/06/21 17:43:43 by agigi             #+#    #+#             */
/*   Updated: 2021/06/22 20:39:25 by agigi            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "server.h"

void	ft_error_message(char *message)
{
	ft_putendl_fd(message, 2);
	exit(1);
}

void	ft_sighandler(int signum)
{
	static char	c = 0;
	static int	i = 0;

	if (signum == 31)
		c = c + (1 << i);
	i++;
	if (i == 8)
	{
		ft_putchar_fd(c, 1);
		c = 0;
		i = 0;
	}
}

int	main(int argc, char **argv)
{
	pid_t	pid;

	(void)argv;
	if (argc != 1)
		ft_error_message("Error: wrong number of arguments");
	pid = getpid();
	ft_putstr_fd("\033[1;32mServer started!\nPID: \033[0m", 1);
	ft_putnbr_fd(pid, 1);
	ft_putchar_fd('\n', 1);
	signal(SIGUSR1, ft_sighandler);
	signal(SIGUSR2, ft_sighandler);
	while (21)
		pause();
	ft_putchar_fd('\n', 1);
	return (0);
}
