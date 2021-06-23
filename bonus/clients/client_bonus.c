/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: agigi <agigi@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/06/22 00:30:53 by agigi             #+#    #+#             */
/*   Updated: 2021/06/23 11:42:34 by agigi            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "client.h"

void	ft_error_message(char *message)
{
	ft_putendl_fd(message, 2);
	exit(1);
}

int	ft_check_pid(char *pid)
{
	size_t	i;

	i = 0;
	while (pid[i])
	{
		if (!ft_isdigit(pid[i]))
			return (0);
		i++;
	}
	return (1);
}

int	ft_send_message(char c, pid_t pid)
{
	int	bit;
	int	i;

	i = 0;
	while (i < 8)
	{
		bit = (c >> i) & 1;
		if (bit == 0)
		{
			if (kill(pid, SIGUSR1) == -1)
				return (0);
		}
		if (bit == 1)
		{
			if (kill(pid, SIGUSR2) == -1)
				return (0);
		}
		usleep(100);
		i++;
	}
	return (1);
}

void	ft_sighandler(int signum)
{
	if (signum == 31)
		ft_putendl_fd("\033[1;32mmessage delivered to the server!\033[0m", 1);
}

int	main(int argc, char **argv)
{
	int		i;
	pid_t	pid;

	i = 0;
	signal(SIGUSR2, ft_sighandler);
	if (argc != 3)
		ft_error_message("Error: wrong number of arguments");
	if (!ft_check_pid(argv[1]))
		ft_error_message("Error: invalid PID number");
	pid = (pid_t)ft_atoi(argv[1]);
	while (argv[2][i])
	{
		if (!ft_send_message(argv[2][i], pid))
			ft_error_message("Error: sending signal");
		i++;
	}
	if (!ft_send_message('\0', pid))
		ft_error_message("Error: sending signal");
	return (0);
}
