/// @description Insert description here
// You can write your code in this editor

//whichever is bigger, absorb the little guy

if(other._souls > _souls){
	other.grow(_souls);
	die();
}

if(other._souls == _souls){
	var dier = random(1) > 0.5? self: other;
	var liver = dier == self? other: self;
	liver.grow(dier._souls);
	dier.die();
}