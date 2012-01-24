module dhe.graphics.compoundimage;

import derelict.sdl.sdl;

import dhe.graphics.image;

class CompoundImage {
	Image child;

	void draw(short x, short y, SDL_Surface *source, SDL_Surface *destination) {
		SDL_Rect offset;
		offset.x = x;
		offset.y = y;

		SDL_BlitSurface(source, null, destination, &offset);
	}
}