/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yzisis-p <yzisis-p@student.42barcelona.    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/19 16:20:11 by yzisis-p          #+#    #+#             */
/*   Updated: 2023/07/27 18:23:02 by yzisis-p         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/minitalk.h"

void	yz_receive_bits(int signal)
{
	static int	bit;
	static int	i;
	char		c;

	if (signal == SIGUSR1)
		i |= (0x01 << bit);
	bit++;
	if (bit == 8)
	{
		c = i;
		write(1, &c, 1);
		bit = 0;
		i = 0;
	}
}

void	print_int(int number)
{
	int		num_digits;
	int		digit;
	int		temp;
	int		index;
	char	number_str[6];

	num_digits = 1;
	temp = number;
	while (temp != 0)
	{
		num_digits++;
		temp /= 10;
	}
	index = num_digits - 1;
	while (number != 0)
	{
		digit = number % 10;
		number /= 10;
		number_str[index--] = '0' + digit;
	}
	write(1, number_str, num_digits);
}

int	main(int argc, char **argv)
{
	int	pid;

	(void)argv;
	if (argc != 1)
	{
		write(2, MSG01, 22);
		write(2, "\n", 1);
		write(2, MSG02, 15);
		return (0);
	}
	pid = getpid();
	write(2, MSG03, 7);
	print_int(pid);
	write(2, "\n", 2);
	write(2, MSG04, 26);
	while (argc == 1)
	{
		signal(SIGUSR1, yz_receive_bits);
		signal(SIGUSR2, yz_receive_bits);
		pause ();
	}
	return (0);
}
