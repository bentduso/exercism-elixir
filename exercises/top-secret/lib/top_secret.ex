defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part({keyword, _, children} = ast, acc)
      when keyword in [:def, :defp] do
    {name, args} = extract_function_name_and_arguments(children)

    arity = if args, do: length(args), else: 0

    message =
      name
      |> to_string()
      |> String.slice(0, arity)

    {ast, [message | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp extract_function_name_and_arguments([{:when, _, [{function_name, _, args} | _]} | _]) do
    {function_name, args}
  end

  defp extract_function_name_and_arguments([{function_name, _, args} | _]) do
    {function_name, args}
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)

    acc
    |> Enum.reverse()
    |> Enum.join("")
  end
end
