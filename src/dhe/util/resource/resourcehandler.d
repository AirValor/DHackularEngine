module dhe.util.resource.resourcehandler;

import std.stdio;
import std.string;

import derelict.sdl.sdl;
import derelict.sdl.image;

import dhe.graphics.image;
import dhe.util.resource.resource;

class ResourceHandler {
	
	Resource[string] resources;
	
	static Image loadImage(string filename) {
		writefln("Loading image: %s", filename);
		Image loadedImage = null;
		Image optimizedImage = null;
		
		loadedImage = new Image();
		optimizedImage = new Image();
		loadedImage.data = IMG_Load(toStringz(filename));

		if (loadedImage.data != null) {
			optimizedImage.data = SDL_DisplayFormatAlpha(loadedImage.data);
			SDL_FreeSurface(loadedImage.data);
		}
		else {
			writefln("Cannot find image: %s", filename);
		}

		return optimizedImage;
	}
}