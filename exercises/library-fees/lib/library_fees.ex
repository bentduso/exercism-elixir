defmodule LibraryFees do
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(datetime), do: datetime.hour < 12

  def return_date(%NaiveDateTime{year: year, month: month, day: day} = naive_datetime) do
    checkout_date = Date.new!(year, month, day)

    if before_noon?(naive_datetime) do
      Date.add(checkout_date, 28)
    else
      Date.add(checkout_date, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime = NaiveDateTime.to_date(actual_return_datetime)

    if Date.compare(actual_return_datetime, planned_return_date) in [:lt, :eq] do
      0
    else
      Date.diff(actual_return_datetime, planned_return_date)
    end
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    return_datetime = datetime_from_string(return)
    late_fee = days_late(return_date(checkout_datetime), return_datetime) * rate

    if monday?(return_datetime) do
      floor(late_fee * 0.5)
    else
      late_fee
    end
  end
end
