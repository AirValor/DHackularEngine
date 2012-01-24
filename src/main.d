 module main;

import std.datetime;
import std.string;
import std.stdio;
import std.path;
import std.algorithm;
import std.file;

import derelict.sdl.sdl;

import dhe.all;

immutable ushort WINDOW_WIDTH = 640;
immutable ushort WINDOW_HEIGHT = 480;
immutable ubyte WINDOW_BPP = 32;
immutable ubyte WINDOW_FLAG = 1;

Window window;
GameEngine engine;

SDL_Event event;

Image icon;

void Initialize()
{
	engine = GameEngine.init();
	window = Window.init(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_BPP, WINDOW_FLAG);
	window.setTitle("dhe v0.2");
	window.setIcon("icon.PNG");
	icon = ResourceHandler.loadImage("icon.png");
}

void Update() {
	bool running = true;

	while (running)	{
		while( SDL_PollEvent( &event ) ) { 
			if( event.type == SDL_QUIT ) { 
				running = false; 
			} 
		}
		
		Draw();
		SDL_Flip(window.getSurface());
	}

	Dispose();
}

void Draw() {
	icon.draw(100, 100, icon.data, window.getSurface());
}

void Dispose() {
	writefln("Cleanup");
	icon.dispose();
	SDL_Quit();
}

void main(string args[])
{
	Initialize();
	Update();
}