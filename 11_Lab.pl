nes (58 sloc)  1.3 KB
  
man(arthur).
man(anton).
man(alex).
man(artem).
man(andrey).
man(arseniy).
man(achilley).
man(albert).
man(athansins).

woman(anna).
woman(alena).
woman(anastasia).
woman(alina).
woman(alexandra).
woman(angelina).
woman(amalia).

parent(anna,artem).
parent(anna,andrey).
parent(arthur,artem).
parent(alina,andrey).
parent(alena,alina).
parent(alena,arseniy).
parent(anton,alina).
parent(anton,arseniy).
parent(anastasia,achilley).
parent(anastasia,alexandra).
parent(anastasia,amalia).
parent(alex,achilley).
parent(alex,alexandra).
parent(alex,amalia).

parent(andrey,albert).
parent(alina,albert).
parent(arseniy,angelina).
parent(alexandra,angelina).
parent(albert,athansins).
parent(angelina,athansins).

child(artem,anna).
child(artem,arthur).
child(andrey,anna).
child(andrey,arthur).
child(alina,alena).
child(alina,anton).
child(arseniy,alena).
child(arseniy,anton).
child(alexandra,anastasia).
child(alexandra,alex).
child(achiley,anastasia).
child(achiley,alex).
child(amalia,anastasia).
child(amalia,alex).
child(albert,andrey).
child(albert,alina).
child(angelina,arseniy).
child(angelina,alexandra).
child(athansins,angelina).
child(athansins,albert).

%11
daugther(X,Y):-child(X,Y),woman(X).
daugther(X):-child(Y,X),woman(Y),write(Y),nl,fail.

%12
wife(X,Y):-child(Z,X),child(Z,Y),man(Y),woman(X).

%13
grand_da(X,Y):-woman(X),child(X,Z),child(Z,Y).
grand_dats(X):-grand_da(X,Y).

%14
grand_da(X,Y):-woman(X),child(X,Z),child(Z,Y).
grand_ma_and_da(X,Y):-grand_da(X,Y),woman(Y).
grand_ma_and_da(X,Y):-grand_da(Y,X),woman(X).

%15
minimal(0,9):-!.
minimal(Num,Res):-
	NumNext is Num div 10,
	minimal(NumNext,Res1),
	Res2 is X mod 10,
	(Res2<Res1, Res is Res2;Res is Res1). 

%16
minimal(Num,Res):- minimal(Num,9,Res).
minimal(0,Res,Res):-!.
minimal(Num,CurRes,Res):-
    NextRes is Num mod 10, 
    NextNum1 is Num div 10,
    NextRes < CurRes,!,minimal(NextNum1,NextRes,Res); 
    NextNum2 is Num div 10, minimal(NextNum2,CurRes,Res).

%17
prdONum(0,99):-!.
prdONum(Num,CurRes):-
    NextNum is Num div 10,
    prdONum(NextNum,R1),
    R2 is Num mod 10,
    (R2 < R1, R2 mod 5 =\= 0 -> CurRes is R2; CurRes is R1).

%18
prdONum(Num,Res):-prdONum(Num,1,Res).
prdONum(0,S,S):-!.
prdONum(Num,Prd,Res):-
    Der is Num mod 10,
    Der mod 5 =\= 0, Prd1 is (Prd * Der),
    NN1 is Num div 10,
    prdONum(NN1,Prd1,Res);
    NN2 is Num div 10,prdONum(NN2,Prd,Res).

%19
fibU(1,1):-!.
fibU(2,1):-!.
fibU(N, X):- 
    N1 is N - 1,
    N2 is N - 2, 
    fibU(N1, X1), 
    fibU(N2, X2), 
    X is X1 + X2.

%20
