extends Node

var selected:int = 0
var sequence:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,67]
var BPM:int = 130
var signature:int = 4
var playpitch
var scalenote
var keyboardoctave:float = 1
var notepressed:bool = false
var latestnote:int = 0
var step:int = 0
