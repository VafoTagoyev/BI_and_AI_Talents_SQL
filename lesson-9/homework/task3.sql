;WITH fibonacci(n, Fibonacci_Number, Prev) as
(
	SELECT 1, 1, 0
	UNION ALL
	SELECT n + 1, Fibonacci_Number + Prev, Fibonacci_Number
	FROM fibonacci
	WHERE n < 10
)
SELECT n, Fibonacci_Number FROM fibonacci;