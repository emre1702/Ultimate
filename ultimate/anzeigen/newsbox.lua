addEvent ( "deActivateCustomRadar", true )

function news1 ()
	outputChatBox ( "#383838═══════ #FFD700Ultimate-RL Info #383838═══════", getRootElement(), 56, 56, 56, true )
	outputChatBox ( "╔ Bei Fragen und Problemen benutzt /report", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╠ Um einer Fraktion beizutreten, melde dich im Teamspeak³.", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╠ Teamspeak: 151.80.196.135:1578", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╚ Forum: Ultimate-RL.de", getRootElement(), 255, 215, 0 )
	outputChatBox ( "═════════════════════════", getRootElement(), 56, 56, 56 )
	setTimer ( news2, 600000, 1 )
end
function news2 ()
	outputChatBox ( "#383838═══════ #FFD700Ultimate-RL Info #383838═══════", getRootElement(), 56, 56, 56, true )
	outputChatBox ( "╔ Bei Fragen und Problemen benutzt /report, für alle Admins online /admins.", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╠ Nutze /save, um deine Position und deine Waffen zu sichern.", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╠ Service Nummern: Polizei - 110 | Sanitäter - 112 | Mechaniker - 300", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╚ Shader kannst du per /shader aktivieren.", getRootElement(), 255, 215, 0 )
	outputChatBox ( "═════════════════════════", getRootElement(), 56, 56, 56 )
	setTimer ( news3, 600000, 1 )
end
function news3 ()
	outputChatBox ( "#383838═══════ #FFD700Ultimate-RL Info #383838═══════", getRootElement(), 56, 56, 56, true )
	outputChatBox ( "╔ Mit /admins seht ihr, welcher Admin momentan online ist.", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╠ Beim gelben Punkt kannst du dir Scheine kaufen und dich über Jobs informieren.", getRootElement(), 255 , 215, 0 )
	outputChatBox ( "╠ Teamspeak: 151.80.196.135:1578", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╚ Forum: Ultimate-RL.de", getRootElement(), 255, 215, 0 )
	outputChatBox ( "═════════════════════════", getRootElement(), 56, 56, 56 )
	setTimer ( news1, 600000, 1 )
end
setTimer ( news1, 600000, 1 )

function infobox ( player, text, time, r, g, b )

	if isElement ( player ) then
		triggerClientEvent ( player, "infobox_start", getRootElement(), text, time, r, g, b )
	end
end
