--- Part 1 ---
CREATE TABLE frumble (
  name VARCHAR(20),
  discount VARCHAR(10),
  month VARCHAR(3),
  price int
);



--- Part 2 ---
-- Month -> Price
SELECT DISTINCT month, discount
FROM frumble
GROUP by month;

-- 