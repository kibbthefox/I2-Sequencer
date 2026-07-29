extends Node

var selected:int = 0
var sequence:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var sequencestep:int = 0
var BPM:int = 130
var signature:int = 4
var playpitch
var scalenote
var octave
var notepressed:bool = false
var latestnote:int = 0
