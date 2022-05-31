%11 Найти максимальный простой делитель числа.

divCount(N, Count):- divCount(N, 0, Count).
divCount(N, N, 0):-!.
divCount(N, Div, Count):-
	NextDiv is Div + 1,
	0 is N mod NextDiv, 	 
	divCount(N, NextDiv, NextCount),
	Count is NextCount + 1,!;	
	NextDiv is Div + 1,
	0 =\= N mod NextDiv,	 
	divCount(N, NextDiv, NextCount),
	Count is NextCount,!.

isPrime(N):- divCount(N, Count), Count is 2,!.

maxPrimeDiv(N, Max):- maxPrimeDiv(N, 0, 0, Max),!.
maxPrimeDiv(N, N, Max, Max):-!.
maxPrimeDiv(N, Div, CurMax, Max):-
	NextDiv is Div + 1,
	0 is N mod NextDiv,
	isPrime(NextDiv),
	CurMax < NextDiv,
	NextCurMax is NextDiv,
	maxPrimeDiv(N, NextDiv, NextCurMax, Max),!;
	NextDiv is Div + 1,
	maxPrimeDiv(N, NextDiv, CurMax, Max),!.
	

/*12 Найти НОД максимального нечетного непростого делителя числа и про-
зведения цифр данного числа.*/

gcd(_, 0, _):- !,fail.
gcd(0, _, _):- !,fail.
gcd(A, B, X):-
	A1 is A mod B,
	B1 is B mod A,
	(
		A1 == 0, !, X is B;
		B1 == 0, !, X is A;
		A > B, !, gcd(A1, B, X);
		gcd(A, B1, X)
	).	
	
maxNonPrimeDiv(N, Max):- maxNonPrimeDiv(N, 0, 0, Max),!.
maxNonPrimeDiv(N, N, Max, Max):-!.
maxNonPrimeDiv(N, Div, CurMax, Max):-
	NextDiv is Div + 1,
	0 is N mod NextDiv,
	\+isPrime(NextDiv),
	CurMax < NextDiv,
	NextCurMax is NextDiv,
	maxNonPrimeDiv(N, NextDiv, NextCurMax, Max),!;
	NextDiv is Div + 1,
	maxNonPrimeDiv(N, NextDiv, CurMax, Max),!.

productOfDigits(0, 0):-!.
productOfDigits(N, 1):- N > 0, N < 10, !.
productOfDigits(N, Product):-
	NextN is N div 10,
	Num is N mod 10,
	productOfDigits(NextN, NextProduct),
	Product is NextProduct * Num.
	
/*Если произведение цифр числа равно нулю, то результатом будет false*/	
maxOddNotPrimeAndProductOfDigitsGCD(N, Result):- 
	productOfDigits(N, Prod),
	maxNonPrimeDiv(N, Max),
	gcd(Prod, Max, Result),!.
	
/*13 
Если p - периметр прямоугольного треугольника с целыми сторонами длины,
{ a , b , c }, то есть ровно три решения для p = 120
{20,48,52}, {24,45,51}, {30,40,50}
Для какого значения p ≤ 1000 число решений максимально?
Задача должна быть решена без использования списков.
*/

isRight(A, B, C, P):- 
	A1 is A * A, 
	B1 is B * B,
	C1 is C * C,
	AB is A1 + B1,
	AB is C1,
	P is 1.
isRight(_, _, _, P):- P is 0.	
	
numberRightTriangles(P, Res):- a(P, 1, Res).
	
a(P, Value, Res) :- Value > P/3, Res is 0, !.
a(P, Value, Res) :- 
    NextValue is Value+1,
    b(P, Value, NextValue, Ans1),
    a(P, NextValue, Ans2), 
    Res is Ans1 + Ans2,!.

b(P, _, Value, Res) :- Value > P/2, Res is 0, !. 
b(P, A, Value, Res) :-
    C is P-A-Value,
    isRight(A,Value,C, Inc),
    NextValue is Value+1,
    b(P, A, NextValue, Ans1),
    Res is Ans1 + Inc.

maxValue(P, Value):-  
	numberRightTriangles(P, CurMax),
	maxValue(P, CurMax, Value),!.
maxValue(0, Value, Value).
maxValue(P, CurMax, Value):-	
	NextP is P - 1,
	numberRightTriangles(NextP, NextCurMax),	
	NextCurMax > CurMax,
	write(NextP   |   NextCurMax), nl,
	maxValue(NextP, NextP, Value),!;
	NextP is P - 1,
	maxValue(NextP, CurMax, Value),!.

/*14 Построить предикат, получающий длину списка.*/

listLength([],0).
listLength([_|Tail], Length) :- listLength(Tail,Count), Length is Count + 1,!.

/*15 Дан целочисленный массив, в котором лишь один элемент отлича-
ется от остальных. Необходимо найти значение этого элемента.*/

itemValue([Item1|[Item2|[Item3|Tail]]], Res):-
	write(Tail), nl,
	(Item1 is Item2, Item2 is Item3, itemValue([Item2, Item3|Tail], Res);
	getDifferentItem(Item1, Item2, Item3, Res)),!.
getDifferentItem(X, X, Y, Y).
getDifferentItem(X, Y, X, Y).
getDifferentItem(Y, X, X, Y).

/*16 Даны два массива. Необходимо найти количество совпадающих по
значению элементов.*/

/*Первая реализация 16
Проверяет наличеие значения текущего эелемента из первого списка во втором 
*/

member([Head|_], Head).
member([_|Tail], Head):- member(Tail, Head),!. 

firstCountMatching([], [_|_], 0).
firstCountMatching([Head|Tail], List2, Count):-
	firstCountMatching(Tail, List2, NextCount),
	(member(List2, Head), Count is NextCount + 1; Count is NextCount),!.

/*Вторая реализация 16
Проверяет соответствие значений эелементов с одинаковыми индексами
*/

secondCountMatching([], [_|_], 0):-!.
secondCountMatching([_|_], [], 0):-!.
secondCountMatching([Head|Tail], [Head2|Tail2], Count):-
	secondCountMatching(Tail, Tail2, NextCount),
	(Head is Head2, Count is NextCount + 1; Count is NextCount),!.
	
/*17 Дан целочисленный массив. Необходимо найти элементы, располо-
женные после первого максимального.*/


/*Обычный append. В конец первого списка добавляет второй список*/  
appendList([], List2, List2).
appendList([Head|Tail], List2, [Head|TailResult]):-
   appendList(Tail, List2, TailResult).

/*Пойск индекса максимального элемента в списке*/
maxItemIndex([Head|Tail], Index):- maxItemIndex([Head|Tail], Head, 0, 0, Index).
maxItemIndex([], _, _, Index, Index).
maxItemIndex([Head|Tail], Max, Index, MaxIndex, Res):-
	NextIndex is Index + 1,
	Max =< Head, NextMax is Head, NextMaxIndex is Index,
	maxItemIndex(Tail, NextMax, NextIndex, NextMaxIndex, Res),!; 
	NextIndex is Index + 1, 
	Max > Head, maxItemIndex(Tail, Max, NextIndex, MaxIndex, Res),!.
	
/*Инверсирует элементы списка*/
reverseList(List, Reversed):- reverseList(List, [], Reversed).
reverseList([], Reversed, Reversed).
reverseList([Head|Tail], Buffer, Reversed):-
	reverseList(Tail, [Head|Buffer], Reversed).
	
/* afterFirstMax([1,2,9,1,2,3,4,9,4], X). */
afterFirstMax(List, ResultList):-
	reverseList(List, Reversed),
	maxItemIndex(Reversed, MaxIndex),
	listLength(Reversed, Length),
	AdjustedMaxIndex is Length - MaxIndex - 1,
	write(AdjustedMaxIndex), nl,
	afterFirstMax(List, AdjustedMaxIndex, 0, ResultList),!.
afterFirstMax([], _, _, []).
afterFirstMax([Head|Tail], MaxIndex, Index, ResultList):-
	NextIndex is Index + 1,
	afterFirstMax(Tail, MaxIndex, NextIndex, NextResultList),
	(MaxIndex < Index, appendList([Head], NextResultList, ResultList);
	appendList([], NextResultList, ResultList)),!.

/*18 Дан целочисленный массив. Необходимо найти два наименьших
элемента.*/	

min([Min], Min):-!.
min([Head|Tail], Min):-
   min(Tail, TailMin),
   TailMin < Head, !, Min is TailMin;
   Min is Head.
   
twoMins([Head|Tail], TwoMins):-	
	min([Head|Tail], FirstMin),
	twoMins([Head|Tail], FirstMin, Head, TwoMins),!.
twoMins([],First, Second, [First,Second]).
twoMins([Head|Tail], First, Second, TwoMins):-
	Head is First,
	min(Tail, NextSecond),
	twoMins([], First, NextSecond, TwoMins),!;
	twoMins(Tail, First, Second, TwoMins),!.
	
/*19 Дан целочисленный массив. Проверить, чередуются ли в нем поло-
жительные и отрицательные числа.*/

areAlternated(List):- areAlternated(List, 0),!.
areAlternated([_], 0).
areAlternated([Item|[Item2|Tail]], Flag):-
	areAlternated([Item2|Tail], NextFlag),
	(Item * Item2 < 0, Flag is NextFlag; Flag is NextFlag + 1),!.

/*20 Дан целочисленный массив. Необходимо найти максимальный не-
четный элемент.*/	

getOdds([], []).
getOdds([Head|Tail], Odds):-
	getOdds(Tail, NextOdds),
	(1 is Head mod 2, !, appendList([Head], NextOdds, Odds);
	appendList([], NextOdds, Odds)).
	
maxOdd(List, MaxOdd):- getOdds(List, Odds), maxOdd_(Odds, MaxOdd),!.
maxOdd_([Max], Max):-!.
maxOdd_([Head|Tail], Max):-
   maxOdd_(Tail, NextMax),
   NextMax > Head, !, Max is NextMax;
   Max is Head.
