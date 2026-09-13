# **I2 Sequencer**

## General Information
The I2S is a Sequencer that ranges 8 octaves (C2-C9), has up to 32 steps, MIDI + keyboard input, full ASDR controls, custom sound uploading, and a dual mode.

I used Godot (GDScript) for scripting and Piskel (Pixel art website) for making assets. I made it for the [Hackclub](https://hackclub.com/) Program [Stardance](https://stardance.hackclub.com/home). I love making music and music gear so I thought it would be fun to code a music-related program!

Fun Fact! When creating the name (I2 Sequencer), I decided to use the second letter of my fursona (Kibb) and a 2 because it was my second coding project of the music plugin type. I created a very similar program called the [K1 Monophonic Sampler](https://github.com/kibbthefox/K1-Monophonic-Sampler) back in July 2026.

## Links

[Github](https://github.com/kibbthefox/I2-Sequencer)

[Demo Video](https://youtu.be/PT3Mo3PtxxY)

## Usage
Click on a step and then use MIDI or a computer keyboard to input notes! Use the delete key on your keyboard to remove any notes. Use - and + to change the octave on your keyboard.

## MIDI Instructions
 To use MIDI input, your MIDI keyboard MUST be plugged in when the program launches. You can always restart. After trying, I was not able to code a button to connect to MIDI :( 

## Opening Instructions

### Versions Tested
MacOS has been tested multiple times. Windows has been tested once.
| OS      | Version        | Processor                                     |
| ------- | -------------- | --------------------------------------------- |
| MacOS   | Ventura 13.7.8 | 2.9 GHz Quad-Core Intel Core i7.              |
| Windows | Windows 11     | 13th Gen Intel(R) Core(TM) i5-1345U (1.60 GHz)|

Other versions of Windows/MacOS may potentially work.

### MacOS
To open, uncompress the zip, and right click on the file. Select "Open" and then it will open up a window. Click "Open" again and then the program will open. You will probably need to do this twice because gatekeeper usually blocks it the first time.

### Windows
Uncompress the .zip and open the file. If a windows security window shows up, click "more info" and then click "Run Anyway"

## AI Disclosure
I always tried to actually make the code myself. There is only one place where I literally couldn't do this. When uploading a .wav file, there is a lot of stuff that needs to be read in the .wav file that is just too complex for me. I didn't want to spend a week learning how to decode and read it, and then do bug fixing on that. Therefore, AI helped write the code to decode and interpret the .wav file. (Without it, some .wav files would just sound like noise.) Outside of audio file uploading, AI didn't write any code in my project.

## Screenshots

<img src="README assets/ss1.png" alt="ss1" width="650" style="margin-bottom: 20px;">

<img src="README assets/ss2.png" alt="ss2" width="650">
