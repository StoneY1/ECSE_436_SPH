//Counter	4
module	counter4	(	CLK,	Y	);	
//	In	order	to	start	a	new	module	you	must	first	declare	it’s	 
//name	and	parameters.	In	this	case	we	wish	to	create	a	counter4	 Which	takes	as	input	a	
//clock	CLK	and	outputs	a	bit-vector	Y.	Similar	to	 other	coding	languages	like	Java,	we	
//must	end	each	statement	with	a	semi-colon.

input	 CLK;	//	We	must	now	specify	our	inputs	and	outputs.	CLK	will	act	as	our	clock 
output	reg	[3:0]	Y;	
//input.	
//This	is	only	one	bit	so	we	do	not	need	to	specify	a	vector	
//length.	Output	Y	on	the	hand	is	a	vector	of	length	4,	specified	by	[3:0].	Since	it	is	just	a	
//counter	we	do	not	need	to	specify	whether	is	signed,	unsigned,	etc.	Therefore	it	is	
//simply	a	regular	output

always@(posedge	CLK)	begin	//	For	our	counter	to	operate	we	need	to	specify	an	event	
//which	will	trigger	the	increment	of	Y.	In	this	case	at	every	positive	(rising)	clock	edge,	we	
//will	begin	our	operation	
Y	<=	Y	+ 1;	//	Pretty	straightforward	here,	at	every	clock	pulse	Y	is	now	Y	+	1.
end
endmodule	//	Required	to	end	the	body	of	our	method.