defmodule ComplexNumbers do
  import Kernel, except: [div: 2]

  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(c :: complex) :: number
  def real({r, _}), do: r

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(c :: complex) :: number
  def imaginary({_, i}), do: i

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(n1 :: complex | number, n2 :: complex | number) :: complex
  def mul({r1, i1}, {r2, i2}), do: {r1 * r2 - i1 * i2, r1 * i2 + r2 * i1}
  def mul({r1, i1}, n2), do: mul({r1, i1}, to_complex(n2))
  def mul(n1, {r2, i2}), do: mul(to_complex(n1), {r2, i2})

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(n1 :: complex | number, n2 :: complex | number) :: complex
  def add({r1, i1}, {r2, i2}), do: {r1 + r2, i1 + i2}
  def add({r1, i1}, n2), do: add({r1, i1}, to_complex(n2))
  def add(n1, {r2, i2}), do: add(to_complex(n1), {r2, i2})

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(n1 :: complex | number, n2 :: complex | number) :: complex
  def sub({r1, i1}, {r2, i2}), do: {r1 - r2, i1 - i2}
  def sub({r1, i1}, n2), do: sub({r1, i1}, to_complex(n2))
  def sub(n1, {r2, i2}), do: sub(to_complex(n1), {r2, i2})

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(n1 :: complex | number, n2 :: complex | number) :: complex
  def div({r1, i1}, {r2, i2}) do
    denominator = r2 * r2 + i2 * i2
    {(r1 * r2 + i1 * i2) / denominator, (r2 * i1 - r1 * i2) / denominator}
  end

  def div({r1, i1}, n2), do: div({r1, i1}, to_complex(n2))
  def div(n1, {r2, i2}), do: div(to_complex(n1), {r2, i2})

  @doc """
  Absolute value of a complex number
  """
  @spec abs(c :: complex) :: number
  def abs({r, i}), do: :math.sqrt(r ** 2 + i ** 2)

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(c :: complex) :: complex
  def conjugate({r, i}), do: {r, -i}

  @doc """
  Exponential of a complex number
  """
  @spec exp(c :: complex) :: complex
  def exp({r, i}), do: {:math.exp(r) * :math.cos(i), :math.exp(r) * :math.sin(i)}

  @spec to_complex(n :: number) :: complex
  defp to_complex(n), do: {n, 0}
end
