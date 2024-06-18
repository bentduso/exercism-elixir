defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({num_a, den_a}, {num_b, den_b}),
    do: reduce({num_a * den_b + num_b * den_a, den_a * den_b})

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({num_a, den_a}, {num_b, den_b}),
    do: reduce({num_a * den_b - num_b * den_a, den_a * den_b})

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({num_a, den_a}, {num_b, den_b}), do: reduce({num_a * num_b, den_a * den_b})

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(a :: rational, b :: rational) :: rational
  def divide_by({num_a, den_a}, {num_b, den_b}) when num_b != 0,
    do: reduce({num_a * den_b, num_b * den_a})

  def divide_by(_, _), do: raise ArgumentError

  @doc """
  Absolute value of a rational number
  """
  @spec abs(r :: rational) :: rational
  def abs({num, den}), do: reduce({Kernel.abs(num), Kernel.abs(den)})

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(r :: rational, n :: integer) :: rational
  def pow_rational({num, den}, n) when n >= 0, do: reduce({num ** n, den ** n})
  def pow_rational({num, den}, n), do: reduce({den ** -n, num ** -n})

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(n :: integer, r :: rational) :: float
  def pow_real(_, {_, 0}), do: raise ArgumentError
  def pow_real(n, {num, den}), do: n ** (num / den)

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(r :: rational) :: rational
  def reduce({_, 0}), do: raise ArgumentError
  def reduce({0, _}), do: {0, 1}
  def reduce({num, num}), do: {1, 1}
  def reduce({num, den}) when den < 0, do: reduce({-num, -den})

  def reduce({num, den} = r) do
    case Integer.gcd(num, den) do
      1 -> r
      gcd -> {div(num, gcd), div(den, gcd)}
    end
  end
end
