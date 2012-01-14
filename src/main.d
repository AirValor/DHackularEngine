 module main;

import dhe.util.geometry.all;
import std.datetime;
import std.string;
import std.stdio;

import derelict.sdl.sdl;

immutable ushort WINDOW_WIDTH = 640;
immutable ushort WINDOW_HEIGHT = 480;
immutable ushort WINDOW_BPP = 32;

SDL_Surface *window = null;

Rectangle r1 = Rectangle(0, 0, 100, 100);
Rectangle r2 = Rectangle(200, 300, 100, 100);

int clr = 0xFFFFFF;

SDL_Event event;

void DrawRect(Rectangle r, int color) {
	SDL_Rect rect = {cast(short)r.X, cast(short)r.Y, cast(ushort)r.W, cast(ushort)r.H};
	SDL_FillRect(window, &rect, color);
}

void apply_surface(short x, short y, SDL_Surface *source, SDL_Surface *destination) {
	SDL_Rect offset;
	offset.x = x;
	offset.y = y;

	SDL_BlitSurface(source, null, destination, &offset);
}

bool InitializeSDL() {
	DerelictSDL.load();

	if (SDL_Init(SDL_INIT_EVERYTHING) == -1) {
		writeln("Could not initialize SDL");
		return false;
	}

	window = SDL_SetVideoMode(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_BPP, SDL_HWSURFACE);

	if (window == null) {
		writeln("Window creation failed.");
		return false;
	}

	SDL_WM_SetCaption("asd", null);
	return true;
}

void Clean_Up() {
	writefln("Cleanup");
	SDL_Quit();
}

void Load_Resources()
{
	
}

void CreateWindow() {
	bool running = true;

	if (InitializeSDL() == false) { writeln("Could not initialize SDL"); };

	Load_Resources();

	while (running)	{
		while (SDL_PollEvent(&event)) {
			if (event.type == SDL_QUIT)
				running = false;

			if (event.type == SDL_KEYDOWN)
			{
				SDLKey keypressed = event.key.keysym.sym;
				switch (keypressed)
				{
					case SDLK_ESCAPE:
						running = false;
						break;
					case SDLK_LEFT:
					//	r1.X -= 15;
						break;
					case SDLK_RIGHT:
					//	r1.X += 15;
						break;
					case SDLK_UP:
					//	r1.Y -= 15;
						break;
					case SDLK_DOWN:
					//	r1.Y += 15;
						break;
					default:
						break;
				}
			}
		}


		clr = r1.intersects(r2) ? 0xFF0000 : 0xFFFFFF;

		SDL_FillRect(window, null, 0 );
		DrawRect(r2,0x0000FF);
		DrawRect(r1,clr);
		SDL_Flip(window);
	}

	Clean_Up();
}

void main(string args[])
{
	InitializeSDL();
	CreateWindow();
}