extends Node

var selected:int = 0
var sequence:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var dualsequence:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var signature:int = 4
var playpitch
var scalenote
var keyboardoctave:int = 4
var notepressed:bool = false
var latestnote:int = 0
var step:int = 0
var stepamount:int = 16
var stepamountdual:int = 16
var bpmsecs:int = 23
var attack
var decay
var sustain
var release
var knobclicked:String = "Open"
var page:int = 0
var filetext = "default"
var justopened = false
var mode:String = "Normal"
var uploadlastpressed:bool = true
