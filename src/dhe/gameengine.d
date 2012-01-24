module dhe.gameengine;

import std.stdio;
import derelict.sdl.sdl;
import derelict.sdl.image;

final class GameEngine {
	private static GameEngine self;

	private this() {
		DerelictSDL.load();
		DerelictSDLImage.load();

		if (SDL_Init(SDL_INIT_EVERYTHING) == -1) {
			writeln("Could not initialize SDL");
		}
	}

	public static GameEngine init() {
		if (self is null)
			self = new GameEngine();
		return self;
	}
}