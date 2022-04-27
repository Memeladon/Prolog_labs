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

wife(X,Y):-child(Z,X),child(Z,Y),man(Y),woman(X).
