;WITH factorial(Num, Factorial) as
(
	SELECT 1, 1
	UNION ALL
	SELECT Num + 1, Factorial * (Num + 1)
	FROM factorial
	WHERE Num < 10
)
SELECT * FROM factorial;