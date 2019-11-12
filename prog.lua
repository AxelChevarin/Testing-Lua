listeValeur = {"AS", "2", "3", "4", "5", "6", "7", "8", "9", "10", "VALET", "DAME", "ROI"}
listeForce = {1,2,3,4,5,6,7,8,9,10,11,12,13}
listeCouleur = {"COEUR", "CARREAU", "TREFLE", "PIQUE"}
cartePaquet = {}
carte = {"valeur", "couleur", "force"}
maCarte = carte
carteTire = {}
cartePrec = {{"","",0}}
compteurNbCarte = 0
score = 0
score2 = 0

function pigerCarte()
	if compteurNbCarte == 0 then
		i=0
		for y=1,4 do
			for z=1,13 do
				i = i + 1
				carte['valeur'] = listeValeur[z]
				carte['couleur'] = listeCouleur[y]
				carte['force']= listeForce[z]
				--print (carte['valeur'], carte['couleur'])
				cartePaquet[i] = {}
				cartePaquet[i]['valeur'] = carte['valeur']
				cartePaquet[i]['force']  = carte['force']
				cartePaquet[i]['couleur'] = carte['couleur']

			end
		end
		compteurNbCarte = 52
	end
	math.randomseed(os.time())
	aleatoire = math.random(1,compteurNbCarte)
	carteTire['valeur']= cartePaquet[aleatoire]['valeur']
	carteTire['couleur'] = cartePaquet[aleatoire]['couleur']
	carteTire['force'] = cartePaquet[aleatoire]['force']
	table.remove(cartePaquet, aleatoire)
	compteurNbCarte = compteurNbCarte - 1
end


function player1()

	p2 = coroutine.wrap(player2)

	while(score <= 100) do
		pigerCarte()

		textePigerCarteA ="Joueur 1 : Piger la carte ".. carteTire["valeur"].." de ".. carteTire["couleur"]
		print(textePigerCarteA)
		fichierLog:write(textePigerCarteA.."\n")

		if carteTire['couleur'] == "COEUR" and  math.fmod(carteTire['force'], 2) == 0 then

			if score == 100 then
				break
			end
			score = score + 1
			texteScoreTest1A ="Joueur 1 gagne 1 points (Total : "..score..")"
			print(texteScoreTest1A)
			fichierLog:write(texteScoreTest1A.."\n")

		end
			if carteTire['couleur'] == cartePrec[#cartePrec][2] then
				if score == 100 then
						break
				end
				score = score + 2
				texteScoreTest2A="Joueur 1 gagne 2 points (Total : "..score..")"
				print(texteScoreTest2A)
				fichierLog:write(texteScoreTest2A.."\n")

			end
		if carteTire['force'] == 13 and carteTire['couleur'] == "CARREAU" then
			if score == 100 then
					break
			end
			score = score + 5
			texteScoreTest3A="Joueur 1 gagne 5 points (Total : "..score..")"
			print(texteScoreTest3A)
			fichierLog:write(texteScoreTest3A.."\n")

		end
			if carteTire['force'] == cartePrec[#cartePrec][3] then
				if score == 100 then
						break
				end
				texteScoreTest4A="Joueur 1 : Valeur identique, Fin du tour "
				print(texteScoreTest4A)
				fichierLog:write(texteScoreTest4A.."\n")
				p2()
			end

		if #cartePaquet == 3 then
			table.remove(cartePrec,1)
			table.insert(cartePrec,{carteTire['valeur'], carteTire['couleur'], carteTire['force']})
		else
			table.insert(cartePrec,{carteTire['valeur'], carteTire['couleur'], carteTire['force']})
		end

	end

end

function player2()
	while(score2 <= 100) do
		pigerCarte();

		textePigerCarteB ="Joueur 2 : Piger la carte ".. carteTire["valeur"].." de ".. carteTire["couleur"]
		print(textePigerCarteB)
		fichierLog:write(textePigerCarteB.."\n")

		if carteTire['couleur'] == "CARREAU" and carteTire['force'] == 7 then
			score2 = score + 5
			texteScoreTest1B ="Joueur 2 gagne 5 points (Total : "..score2..")"
			print(texteScoreTest1B)
			fichierLog:write(texteScoreTest1B.."\n")
			if score2 == 100 then
				break
			end
		end

		w = 0
		for i=1,#cartePrec do
			valeurPrec = cartePrec[i][3]
			w= valeurPrec + w
		end

		if w <= 10 then

			score2 = score2 + 5
			texteScoreTest2B ="Joueur 2 gagne 5 points (Total : "..score2..")"
			print(texteScoreTest2B)
			fichierLog:write(texteScoreTest2B.."\n")
			if score2 == 100 then
				break
			end
		end

		a = carteTire['force']
		b = cartePrec[3][3]
		c = cartePrec[2][3]

		if b == a-1 and c == a-2 or b == a-2 and c == a-1 or b==a+1 and c == a+2 or b==a+2 and c == a+1 or b == a -1 and c == a +1 or b == a + 1 and c == a -1 then
			score2 = score2 + 10
			texteScoreTest3B ="Joueur 2 gagne 10 points (Total : "..score..")"
			print(texteScoreTest3B)
			fichierLog:write(texteScoreTest3B.."\n")
			if score2 == 100 then
				break
			end
		end

		if carteTire['force'] == cartePrec[#cartePrec][3] then
			texteScoreTest4B="Joueur 2 : Valeur identique, Fin du tour"
			print(texteScoreTest4B)
			fichierLog:write(texteScoreTest4B.."\n")
			coroutine.yield()
			if score2 == 100 then
				break
			end
		end

		if #cartePaquet == 3 then
			table.remove(cartePrec,1)
			table.insert(cartePrec,{carteTire['valeur'], carteTire['couleur'], carteTire['force']})
		else
			table.insert(cartePrec,{carteTire['valeur'], carteTire['couleur'], carteTire['force']})
		end
	end

end


fichierLog = io.open("partie.log", "w")
texteDebut= "=====Debut de la partie======"
print(texteDebut)
fichierLog:write(texteDebut.."\n")
p1= coroutine.create(player1)
coroutine.resume(p1)
print("=====Fin de partie=====")
pointA= "Joueur 1: " .. score .. "points"
print(pointA)
fichierLog:write(pointA.."\n")
pointB="Joueur 2: "..score2.."points"
print(pointB)
fichierLog:write(pointB.."\n")
