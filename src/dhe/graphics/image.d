module dhe.graphics.image;

import derelict.sdl.sdl;

import dhe.util.resource.resource;

class Image : Resource {
	Image parent;
	SDL_Surface* data;

	public override Resource load() {
		return parent;
	}

	public void draw(short x, short y, SDL_Surface *source, SDL_Surface *destination) {
		SDL_Rect offset;
		offset.x = x;
		offset.y = y;

		SDL_BlitSurface(source, null, destination, &offset);
	}

	public override void dispose() {
		SDL_FreeSurface(data);
	}
}